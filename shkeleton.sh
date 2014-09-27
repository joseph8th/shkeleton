#!/usr/bin/env bash

####  CONFIGURABLES  ######################################################

DEBUG=1

# (0) SELF - The 'self' command. Has special status.
#     (a) like `cp -r SRC DEST` - the script IS the command
#     (b) `git -b checkout BRANCH` - the script RUNS command

SELF_NAME="shkeleton - CLI shell scripting for lazy people"

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

CMD_HELP[skel]="copy skel to DEST"
CMD_ARGS[skel]="DEST"   # define both CMD_OPTS[CMD] and CMD_ARGS[CMD] for

# (2) 'fling' command with two args, one opt -- a dummy command

CMD_HELP[fling]="fling love from SRC at DEST"
CMD_ARGS[fling]="SRC DEST"    # space-separated string of positional args
CMD_OPTS[fling]="p poo t toss"    # string of pairwise short-long opts

# (2.1) if CMD_OPTS[CMD] defined, optionally define optargs w opt keys

CMD_OPTARGS[p]="POO"         # option args space-separated string
CMD_OPTS_HELP[p]="SRC instead flings POO at DEST"
CMD_OPTS_HELP[t]="SRC instead tosses at DEST"


#--------------------------------------------------------------------------
# COMMAND FUNCTIONS - must be named `_run_CMD` for each CMD in COMMANDS
# Define each CMD function below. All your logic goes here.
# Use parsed CMD, OPTS[] with OPTARGS[opt], and ARGS[] here.


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