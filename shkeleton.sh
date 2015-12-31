#!/usr/bin/env bash

####  CONFIGURABLES  #################################################

DEBUG=1
MAN_HELP=1    # 0=text help, 1=man help
MAN_TYPE=1    # a command by man standards
VERSION="0.2b"

# Author metadata
AUTHOR="Joseph Edwards VIII"
AUTHOR_EMAIL="jedwards8th@gmail.com"


####  SELF  ##########################################################

# The 'self' command. Has special status.
#   (a) like `cp -r SRC DEST` - the script IS the command
#   (b) like `git -b checkout BRANCH` - the script RUNS command

# using man so prefix '-' with an escape '\'
SELF_NAME="${SCRIPT} \- CLI shell scripting for lazy people"

# script summary long as you like
SELF_HELP="A skeletal wireframe to speed development of command-line
interface (CLI) executable bash scripts. Intended to speed coding for
more than the simplest command-line scripts. Use whenever 'optargs'
isn't enough, or when you want to use GNU style long arguments, or
when the number of parameters is too unwieldy for positional
arguments, or when the script(s) you're writing are already complex,
or when you don't just feel like doing CL argument parsing."

# SELF_ARGS - if COMMANDS defined, then define empty: `SELF_ARGS=`
SELF_ARGS="POOP"

# SELF_OPTS_NOARG - singletons: ARGS ignored, and only 1st OPT parsed
SELF_OPTS_NOARG="h help v version"
SELF_OPTS_NOARG_HELP[h]="print help message"
SELF_OPTS_NOARG_HELP[v]="print version information"

# SELF_OPTS - pairs short-long OPTS (ie, "t target" == -t, --target)
SELF_OPTS="t target"
SELF_OPTS_HELP[t]="target project path"

# SELF_OPTARGS - string of positional option arguments
SELF_OPTARGS[t]="SRCDIR TARGETDIR"


####  COMMANDS  ######################################################

# Command mode: first parameter commands can have ARGS and OPTS.
# If not defining commands then define empty: `COMMANDS=`

#COMMANDS=( "skel" "fling" )    # array of strings
COMMANDS=

# (1) 'skel' command with one arg, no opts

#CMD_HELP[skel]="copy './skel' to DEST, where DEST is a new directory"
#CMD_ARGS[skel]="DEST"   # define both CMD_OPTS[CMD] and CMD_ARGS[CMD] for

# (2) 'fling' command with two args, one opt -- a dummy command

#CMD_HELP[fling]="fling love from SRC at DEST"
#CMD_ARGS[fling]="SRC DEST"    # space-separated string of positional args
#CMD_OPTS[fling]="p poo t toss"    # string of pairwise short-long opts

# (2.1) if CMD_OPTS[CMD] defined, optionally define optargs w opt keys

#CMD_OPTARGS[p]="POO BAH"         # option args space-separated string
#CMD_OPTS_HELP[p]="SRC instead flings POO at DEST"
#CMD_OPTS_HELP[t]="SRC instead tosses at DEST"


####  OPTIONAL MANPAGE  ##############################################

FILES="The 'skel' command copies files in './skel' directory (or the
current scripts) to the given destination path, renaming them in the
process."

ENVIRONMENT=

EXIT_STATUS="Exits with status \$ERRNO."

EXAMPLE_01="${SCRIPT} skel /path/to/new/script"

EXAMPLE_02="${SCRIPT} fling -t -p poo dirt
\(rs\"Phil Collins\(rs\" \(rs\"Batman and Robin\(rs\""

EXAMPLES="\&${EXAMPLE_01}\n\n\&${EXAMPLE_02}"

BUGS="Quotes must be escaped for multiple word arguments. Only double
quotes are supported."

SEE_ALSO=


####  COMMAND FUNCTIONS  #############################################

# Must be named `_run_CMD` for each CMD in COMMANDS.
# Define each CMD function below. All your logic goes here.
# Use parsed CMD, OPTS[] with OPTARGS[opt], and ARGS[] here.

# _run_self should always be defined and should minimally _print_help
function _run_self {
    for opt in "${OPTS}"; do
        case $opt in
            h)
                _print_help
                _exit_err
                ;;
            t)
                echo ${OPTARGS[t]}
                ;;
            *)
                _print_help
                _exit_err
                ;;
        esac
    done

    echo ${ARGS[@]}
}

# copy the skel directory and files to chosen destination
function _run_skel {

    # default try to copy out of ./skel directory (unconfigured)
    src='./skel'
    dest="${ARGS[DEST]}"
    skelname=`basename ${dest}`

    # if no 'skel' dir then use current directory (these files)
    [[ ! -d "${src}" ]] && src='./'

    if [[ ! -f "${src}/${SCRIPT}" || ! -f "${src}/${SCRIPT}.sh" ]]; then
        _err; _exit_err "'${SCRIPT}' skel files not found."
    fi

    # now copy the files over
    echo "Copying ${src} directory to new directory ${dest} ..."
    [[ ! -d "${dest}" ]] && mkdir "${dest}"
    cp "${src}/${SCRIPT}" "${dest}/${skelname}"
    cp "${src}/${SCRIPT}.sh" "${dest}/${skelname}.sh"
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
                optargs=( ${OPTARGS[$opt]} )
                noun1="${optargs[0]}"
                noun2="${optargs[1]}"
                ;;
        esac
    done

    # this is what 'fling' cmd does...
    _debug "\n_run_fling:\n"
    printf "\n${ARGS[SRC]} ${verb} ${noun1} and ${noun2} at ${ARGS[DEST]}.\n"
}
