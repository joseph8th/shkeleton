#!/usr/bin/env bash

####  CONFIGURABLES  ######################################################

DEBUG=0
MAN_TYPE=1    # a command by man standards
VERSION="0.1"

# Author metadata
AUTHOR="Joseph Edwards VIII"
AUTHOR_EMAIL="joseph8th@notroot.us"

# (0) SELF - The 'self' command. Has special status.
#     (a) like `cp -r SRC DEST` - the script IS the command
#     (b) `git -b checkout BRANCH` - the script RUNS command

# using man so prefix '-' with an escape '\'
SELF_NAME="${SCRIPT} \- CLI shell scripting for lazy people"

# script summary long as you like
SELF_HELP="A skeletal wireframe to speed development of command-line interface (CLI) executable bash scripts. Intended to speed coding for more than the simplest command-line scripts. Use whenever 'optargs' isn't enough, or when the number of parameters is too unwieldy for positional arguments, or when one doesn't feel like doing CLI argument parsing, at all."

# SELF_OPTS

SELF_OPTS="h help"       # pairwise short-long options ie, (-h, --help)
SELF_OPTS_HELP[h]="print help message"

# SELF_ARGS

SELF_ARGS=    # string: if COMMANDS defined, then leave empty

# COMMANDS - first argument commands can have arguments and options
# If not defining commands then leave blank: `COMMANDS=`

COMMANDS=( "skel" "fling" )    # array of strings

# (1) 'skel' command with one arg, no opts

CMD_HELP[skel]="copy './skel' to DEST, where DEST is a new directory"
CMD_ARGS[skel]="DEST"   # define both CMD_OPTS[CMD] and CMD_ARGS[CMD] for

# (2) 'fling' command with two args, one opt -- a dummy command

CMD_HELP[fling]="fling love from SRC at DEST"
CMD_ARGS[fling]="SRC DEST"    # space-separated string of positional args
CMD_OPTS[fling]="p poo t toss"    # string of pairwise short-long opts

# (2.1) if CMD_OPTS[CMD] defined, optionally define optargs w opt keys

CMD_OPTARGS[p]="POO"         # option args space-separated string
CMD_OPTS_HELP[p]="SRC instead flings POO at DEST"
CMD_OPTS_HELP[t]="SRC instead tosses at DEST"

# Additional manpage sections (optional)
FILES="The 'skel' command copies files in './skel' directory (or the current scripts) to the given destination path, renaming them in the process."
ENVIRONMENT=
EXIT_STATUS="Exits with status \$NOERR (0 for OK, and >0 with errors)."
EXAMPLE_01="${SCRIPT} skel /path/to/new/script"
EXAMPLE_02="${SCRIPT} fling -t -p poo \(rs\"Phil Collins\(rs\" \(rs\"Batman and Robin\(rs\""
EXAMPLES="\&${EXAMPLE_01}\n\n${EXAMPLE_02}"
BUGS="Quotes must be escaped for multiple word arguments. Only double quotes are supported."
SEE_ALSO=

####  COMMAND FUNCTIONS  ##################################################
# Must be named `_run_CMD` for each CMD in COMMANDS.
# Define each CMD function below. All your logic goes here.
# Use parsed CMD, OPTS[] with OPTARGS[opt], and ARGS[] here.

# _run_self should always be defined and should minimally _print_help
function _run_self {
    for opt in "${OPTS}"; do
        case $opt in
            h)
                _print_help
                ;;
            *)
                _print_help
                ;;
        esac
    done
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
    noun="love"

    # loop over OPTS + OPTARGS parsed, but *validate* here in `run_CMD`
    for opt in "${OPTS[@]}"; do
        case $opt in
            t)
                verb="tosses"
                ;;
            p)
                # remove leading and trailing whitespace
                noun="${OPTARGS[$opt]}"
                ;;
        esac
    done

    # this is what 'fling' cmd does...
    _debug "\n_run_fling:\n"
    printf "\n${ARGS[SRC]} ${verb} ${noun} at ${ARGS[DEST]}.\n"
}
