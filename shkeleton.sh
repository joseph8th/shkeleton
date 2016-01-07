#!/usr/bin/env bash

####  CONFIGURABLES  #################################################

readonly DEBUG=0
readonly MAN_HELP=1    # 0=text help, 1=man help
readonly MAN_TYPE=1    # a command by man standards
readonly VERSION="1.0"

# Author metadata
readonly AUTHOR="Joseph Edwards VIII"
readonly AUTHOR_EMAIL="jedwards8th@gmail.com"


####  SELF  ##########################################################

# The 'self' command. Has special status.
#   (a) like `cp -r SRC DEST` - the script IS the command
#   (b) like `git -b checkout BRANCH` - the script RUNS command

# using man so prefix '-' with an escape '\'
readonly SELF_NAME="${SCRIPT} \- CLI shell scripting for lazy people"

# script summary long as you like
readonly SELF_HELP="A skeletal wireframe to speed development of command-line
interface (CLI) executable bash scripts. Intended to speed coding for
more than the simplest command-line scripts. Use whenever 'optargs'
isn't enough, or when you want to use GNU style long arguments, or
when the number of parameters is too unwieldy for positional
arguments, or when the script(s) you're writing are already complex,
or when you don't just feel like doing CL argument parsing."

# SELF_ARGS - if COMMANDS defined, then define empty: `SELF_ARGS=`
#SELF_ARGS="DEST POOP CRAP"

# SELF_OPTS_NOARG - singletons: ARGS ignored, and only 1st OPT parsed
SELF_OPTS_NOARG="h help v version"
SELF_OPTS_HELP=( \
    [h]="print help message" \
    [v]="print version information" \
    )

# SELF_OPTS - pairs short-long OPTS (ie, "t target" == -t, --target)
SELF_OPTS="f foo"
SELF_OPTS_HELP[f]="example self-as-command option"

# SELF_OPTARGS - string of positional option arguments
SELF_OPTARGS[f]="BAR BAZ"


####  COMMANDS  ######################################################

# Command mode: first parameter commands can have ARGS and OPTS.
# If not defining commands then define empty: `COMMANDS=`

COMMANDS=( "skel" "fling" )    # array of strings

# (1) 'skel' command with one arg, no opts

CMD_HELP[skel]="create skeleton project in directory DEST"
CMD_ARGS[skel]="DEST"

# (2) 'fling' command with two args, one opt -- a dummy command

CMD_HELP[fling]="fling love from SRC at DEST"
CMD_ARGS[fling]="SRC DEST"    # space-separated string of positional args
CMD_OPTS[fling]="p poo t toss"    # string of pairwise short-long opts

# (2.1) if CMD_OPTS[CMD] defined, optionally define optargs w opt keys

CMD_OPTARGS[p]="POO BAH"         # option args space-separated string
CMD_OPTS_HELP[p]="SRC instead flings POO at DEST"
CMD_OPTS_HELP[t]="SRC instead tosses at DEST"


####  OPTIONAL MANPAGE  ##############################################

readonly FILES="The 'skel' command copies files in './skel' directory (or the
current scripts) to the given destination path, renaming them in the
process."

readonly ENVIRONMENT=

readonly EXIT_STATUS="Exits with status \$ERRNO."

readonly EXAMPLE_01="${SCRIPT} skel /path/to/new/script"
readonly EXAMPLE_02="${SCRIPT} fling -t -p poo dirt
\(rs\"Phil Collins\(rs\" \(rs\"Batman and Robin\(rs\""
readonly EXAMPLES="\&${EXAMPLE_01}\n\n\&${EXAMPLE_02}"

readonly BUGS="Quotes must be escaped for multiple word arguments. Only double
quotes are supported."

readonly SEE_ALSO=


####  COMMAND FUNCTIONS  #############################################

# Must be named `_run_CMD` for each CMD in COMMANDS.
# Define each CMD function below. All your logic goes here.
# Use parsed CMD, OPTS[] with OPTARGS[opt], and ARGS[arg] here.

# _run_self should always be defined and should minimally _print_help
function _run_self {
    _debug "\n_run_self:\n"
    _str_equal "$CMD" "self" && self_as_command && _exit_err
}

# example of self-as-command
function self_as_command {

    if ! _is_empty "${ARGS[@]}"; then
        cmd_args=( ${CMD_ARGS[@]} )

        # NOTICE the use of 'eval' to get ARGS values
        for arg in "${cmd_args[@]}"; do
            eval val=${ARGS[$arg]}
            echo "${arg}: ${val}"
        done
    fi

    for opt in "${OPTS}"; do
        case $opt in
            h)
                _print_help
                _exit_err
                ;;
            v)
                echo "$SCRIPT $VERSION"
                _exit_err
                ;;
            f)
                # NOTICE the use of 'eval' to get OPTARGS array
                eval fopts=( ${OPTARGS[f]} )
                echo "BAR: ${fopts[0]}"
                echo "BAZ: ${fopts[1]}"
                ;;
            *)
                _print_help
                _err; _exit_err
                ;;
        esac
    done
}

# copy the skel directory and files to chosen destination
function copy_skel {
    dest="$1"
    skelname=`basename ${dest}`

    # default try to copy files out of ./skel directory
    src="$(readlink -m ./skel)"

    # if no 'skel' dir then use current directory (these files)
    [[ ! -d "${src}" ]] && src="$(readlink -m ./)"

    if [[ ! -f "${src}/${SCRIPT}" || ! -f "${src}/${SCRIPT}.sh" ]]; then
        _err; _exit_err "'${SCRIPT}' skel files not found."
    fi

    # now copy the files over
    echo "Copying ${src} directory to new directory ${dest} ..."

    [[ ! -d "${dest}" ]] && mkdir -p "${dest}"
    if [[ ! -d "${dest}" ]]; then
        _err; _exit_err "unable to create directory '${dest}'"
    fi

    cp "${src}/${SCRIPT}" "${dest}/${skelname}"
    if [[ ! -f "${dest}/${skelname}" ]]; then
        _err; exit_err "unable to copy '${SCRIPT}' to '${dest}/${skelname}'"
    fi

    cp "${src}/${SCRIPT}.sh" "${dest}/${skelname}.sh"
    if [[ ! -f "${dest}/${skelname}.sh" ]]; then
        _err; exit_err "unable to copy '${SCRIPT}.sh' to '${dest}/${skelname}.sh'"
    fi

    echo "SUCCESS!"
}

function _run_skel {
    eval dest=${ARGS[DEST]}
    copy_skel "$dest"

}

# example command function using options and option arguments
function _run_fling {

    verb="flings"
    noun1="love"
    noun2="flowers"

    # loop over OPTS + OPTARGS parsed, but *validate* here in `run_CMD`
    for opt in "${OPTS[@]}"; do
        case $opt in
            t)
                verb="tosses"
                ;;
            p)
                # NOTICE use of 'eval' to get OPTARGS array
                eval optargs=( ${OPTARGS[$opt]} )
                noun1="${optargs[0]}"
                noun2="${optargs[1]}"
                ;;
        esac
    done

    # this is what 'fling' cmd does...
    _debug "\n_run_fling:\n"

    # NOTICE use of 'eval' to get ARGS values
    eval src=${ARGS[SRC]}
    eval dest=${ARGS[DEST]}
    printf "${src} ${verb} ${noun1} and ${noun2} at ${dest}.\n"
}
