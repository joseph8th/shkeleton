# shkeleton

A skeletal bash shell wireframe meant to reduce boilerplate argument and option parsing for more than the simplest CLIs.

Use in either (1) self-as-command mode or (2) command mode:
  1. like `cp -r SRC DEST` - the script IS the command
  2. like `git -b checkout BRANCH` - the script RUNS the command

Configure self, self options, self option arguments, commands, command options, command option arguments, and positional arguments for either self or commands. Then just write functions named `_run_COMMAND` for each `COMMAND` defined, using the parsed options and arguments in the code to do ... whatever.

`shkeleton` will generate a `man` page from the configured variables, which will be displayed by when using the default `--help` option.

## Summary

The `shkeleton` script is not intended to be a framework. Rather it is a *wireframe* intended to be fleshed out. If one just needs to slap `WHATEVER=$1` to get a positional argument for some quick script, this is overkill.

However, if one is writing a script that will see a lot of use, takes lots of arguments, or requires more complicated option parsing than `getopts` can easily provide, then `shkeleton` can speed things along.

Basically, I wanted something more like Python's `argparse` for `bash`.

## Install

    git clone git@github.com:joseph8th/shkeleton.git
    cd shkeleton

## Quickstart

To copy a bare-bones, unconfigured copy of `shkeleton` to a new path, just do:

    ./shkeleton skel DEST

This copies the version of `shkeleton` and `shkeleton.sh` (for your code) in the `skel` directory to the `DEST` path, and renames the `shkeleton` files to `basename ${DEST}`.

Then open `shkeleton` in your favorite text editor (`emacs`, right?!?) and start reading. Also, open `shkeleton.sh` to see an example configuration with wirefram function definitions.

## Usage

Install a copy of `shkeleton` to your desired `newscript` directory as described above. You will find `newscript` and `newscript.sh` in this location.

  * `newscript` - the executable script contains utility functions, parsing functions, some globals, and the `_main` function. **This file may be used as-is**, or you can customize it as you like.

  * `newscript.sh` - **this is where all your code should go**. Here you define your commands, arguments, options and option arguments. Also, any `man` help sections you would like to use. This is also where you define all of the `_run_COMMAND` functions corresponding to each command defined.

  * `ARGS` - use `eval` when getting the value of positional `ARGS` in your functions. If the value is multiple-word, this will remove the double-quotes. Like this:

```bash
# NOTICE the use of 'eval' to get ARGS values
for arg in "${cmd_args[@]}"; do
    eval val=${ARGS[$arg]}
    echo "${arg}: ${val}"
done
```

  * `OPTARGS` - similarly, use `eval` when getting the `OPTARGS` array in your functions. This will preserve the correct indexing and remove double-quotes. Like this:

```bash
# NOTICE the use of 'eval' to get OPTARGS array
eval fopts=( ${OPTARGS[f]} )
echo "BAR: ${fopts[0]}"
echo "BAZ: ${fopts[1]}"
```

### Pitfalls

A couple pitfalls to watch out for:

  * If defining `COMMANDS` array, then **don't define** `SELF_ARGS` string. Instead define `CMD_ARGS` per command.
  * When entering multiple-word positional arguments, you currently need to use escaped double quotes. (This is a bug I'll try to fix someday.)

For example on this last pitfall... this is OK:

```bash
    ./shkeleton fling --poo \"poopy farts\" \"litter box\" \"Phil Collins\" \"Batman and Robin\"
```

And this is *not* OK:

```bash
    ./shkeleton fling --poo "poopy farts" "litter box" "Phil Collins" "Batman and Robin"
```

### Example of Self-as-Command

The included `example-self-cmd` directory contains an `example-self-cmd.sh` configuration file that demonstrates how to properly use `shkeleton` in self-as-command mode. The `example-self-cmd` file is just a copy of `shkeleton` itself.

### Tips

Read through both `shkeleton` files and try to understand how they work together before you start coding your new script. They are both heavily annotated and explain usage in greater detail, including the proper formatting for commands, options, arguments.

## Dev Approach

I wanted `shkeleton` to be not just configurable, but malleable as well. That is, I wanted it to work as-is with some simple configuration, but also to design it to be shaped to a wide variety of purposes, quickly. In order to make the entire skel malleable, I tried to keep it simplistic: no arcane scripting. It's up to the user to optimize... or use as-is.

Complicate it as much as you like. Pull requests welcome for code optimization and bug fixing.

## Bugs

  * Multiple-word parameters must be enclosed in escaped double-quotes, like `\"Batman Robin\"`.

## Changelog

#### 2016-01-01  Joseph Edwards

  * v1.0: positional arguments may now come before or after option parameters
  * v1.0: numerous bugfixes for both self-as-command and command mode parameter parsing
  * v1.0: refactored `shkeleton` to use utility functions and safe(r) scripting - easier to read!
  * v1.0: correct usage of ARGS and OPTARGS demonstrated in `shkeleton.sh` boilerplate

#### 2014-11-02  Joseph Edwards

  * v0.2: multiple-word parameters working for option arguments now, as well
  * v0.2: options must still precede arguments (ugh!)

#### 2014-09-28  Joseph Edwards

  * v0.1: working alpha with some limitations like options-must-precede-arguments and multiple-word parameters only working for positional arguments
