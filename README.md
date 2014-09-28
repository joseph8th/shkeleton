# shkeleton

A skeletal bash shell wireframe meant to reduce boilerplate argument and option parsing for more than the simplest CLIs.

Configure self, self options, commands, command options, and positional arguments for either self or commands. Then just write functions named `_run_COMMAND` for each `COMMAND` defined, using the parsed options and arguments in the code to do ... whatever.

`shkeleton` will generate a `man` page from the configured variables, which will be displayed by when using the default `--help` option.

## Summary

The `shkeleton` script is not intended to be a framework. Rather it is a *wireframe* intended to be fleshed out. If one just needs to slap `WHATEVER=$1` to get a positional argument for some quick script, this is overkill.

However, if one is writing a script that will see a lot of use, takes lots of arguments, or requires more complicated option parsing than `getopts` can easily provide, then `shkeleton` can speed things along.

Basically, I wanted something more like Python's `argparse` for `bash`.

## Install

    git clone git@github.com:joseph8th/shkeleton.git
    cd shkeleton

To copy a bare-bones, unconfigured copy of `cli-skel.sh` to a new path, just do:

    ./shkeleton skel DEST

This copies the version of `shkeleton` and `shkeleton.sh` (for your code) in the `skel` directory to the `DEST` path, and renames the `shkeleton` files to `basename ${DEST}`.

### Quickstart

The *configured* `shkeleton` in the project root is also an *example*. It is heavily annotated, but minimal enough to be modified and used as a CLI skeleton, as well. It may even serve as a sort of tutorial.

To use the installer/example `shkeleton` as the skeleton CLI, just copy the `shkeleton*` files to a new location:

    cp shkeleton* DEST

Then open in your favorite text editor (emacs, right?!?) and start reading. Also, open `shkeleton.sh` to see an example configuration and function definitions.

## Usage

Install a copy of `shkeleton` to your desired `newscript` directory as described above. You will find `newscript` and `newscript.sh` in this location.

  * `newscript` - the executable script contains utility functions, parsing functions, some globals, and the `_main` function. **This file may be used as-is**, or you can customize it as you like.

  * `newscript.sh` - **this is where all your code should go**. Here you define your commands, arguments, options and option arguments. Also, any `man` help sections you would like to use. This is also where you define all of the `_run_COMMAND` functions corresponding to each command defined.

### Use Cases

  1. Like `cp -r SRC DEST` - the script **IS** the command (`cp`).
  2. Like `git checkout -b NEWBRANCH` - the script **RUNS** the command (`checkout`).

### Pitfalls

A couple pitfalls to watch out for:

  * If defining `COMMANDS` array, then don't define `SELF_ARGS` string.
  * For now, options must always precede arguments.
  * When entering multiple-word arguments, you currently need to use escaped double quotes. (This is a bug I'll try to fix someday.) Like this:

    $ ./shkeleton fling -p poopy \"Phil Collins\" \"Batman and Robin\"

### Tips

Read through both `shkeleton` files and try to understand how they work together before you start coding your new script. They are both heavily annotated and explain usage in greater detail, including the proper formatting for commands, options, arguments.

## Dev Approach

I wanted `shkeleton` to be not just configurable, but malleable as well. That is, I wanted it to work as-is with some simple configuration, but also to design it to be shaped to a wide variety of purposes, quickly. In order to make the entire skel malleable, I tried to keep it simplistic: no arcane scripting. It's up to the user to optimize... or use as-is.

Complicate it as much as you like. Pull requests welcome for code optimization and bug fixing.

### Version Note

In this initial version, the files in the `skel` directory are just copies of the `shkeleton` files. Once I have a stable and thoroughly vetted version, I'll strip out the configuration in the `skel/shkeleton.sh` file.