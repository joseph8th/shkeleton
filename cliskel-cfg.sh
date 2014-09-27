#!/usr/bin/env bash

####  CONFIGURABLES  ######################################################

# (0) SELF - The 'self' command. Has special status.
#     a) like `cp -r SRC DEST` - the script IS the command
#     b) `git -b checkout BRANCH` - the script RUNS command

SELF_HELP="Skeleton CLI wireframe."    # script summary long as you like

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

CMD_HELP[fling]="fling love from BAR at BAZ"
CMD_ARGS[fling]="BAR BAZ"    # space-separated string of positional args
CMD_OPTS[fling]="p poo t toss"    # string of pairwise short-long opts

# (2.1) if CMD_OPTS[CMD] defined, optionally define optargs using short opt keys
CMD_OPTARGS[p]="POO"         # option args space-separated string
CMD_OPTS_HELP[p]="BAR instead flings POO at BAZ"
CMD_OPTS_HELP[t]="BAR instead tosses at BAZ"

#--------------------------------------------------------------------------
# COMMAND FUNCTIONS - must be named `_run_CMD` for each CMD in COMMANDS
# Define each CMD function below. All your logic goes here.
# Use globals $CMD $ARGS and $OPTS in your logic.
#
# i.e., `function _run_skel { ... }`

function _run_self {

    for opt in "${OPTS}"; do
        case $opt in
            h)
                _print_help
                ;;
        esac
    done
}


function _run_fling {

    verb="flings"
    noun="love"

    for opt in "${OPTS}"; do
        case $opt in
            t)
                verb="tosses"
                ;;
            p)
                # remove leading and trailing whitespace
                noun=`echo "${OPTARGS[p]}" | sed -e 's/^[ \t]*//'`
                ;;
        esac
    done

    printf "\n_run_fling:\n\t${ARGS[BAR]} ${verb} ${noun} at ${ARGS[BAZ]}\n"
}
