# shkeleton

A skeletal bash shell wireframe meant to reduce boilerplate option parsing
for more than the simplest CLIs.

Configure self, self options, commands, command options, and positional arguments for either self or commands.Then just write functions named '_run_COMMAND' for each 'COMMAND' defined, using the parsed options and arguments in the code to do ... whatever.

## Install

    git clone ...
    cd shkeleton

To copy a bare-bones, unconfigured copy of `cli-skel.sh` to a new path or path/filename, just do:

    ./shkeleton skel DEST

This copies an *unconfigured* version of `shkeleton` and `shkeleton.sh` (for your code) from the `skel` directory to the `DEST` path.

### Quickstart

The *configured* `shkeleton` in the project root is also an *example*. It is heavily annotated, but minimal enough to be modified and used as a CLI skeleton, as well. It may even serve as a sort of tutorial.

To use the installer/example `shkeleton` as the skeleton CLI, just copy it to a new location:

    cp shkeleton DEST

Then open in your favorite text editor (emacs, right?!?) and start reading. Also, open `shkeleton.sh` to see an example configuration and function definitions.

## Summary

The `shkeleton` script is not intended to be an Swiss Army knife. Rather it is a *skeleton* intended to be fleshed out. I wanted a starting point to reduce boilerplate when writing more than the simplest CLI scripts. If I just need to slap `$WHATEVER=$1` in to get a positional argument or two for some quick sloppy script, OK. That's fine.

Yet, sometimes I'm writing scripts I'm going to use a lot, with lots of arguments, and maybe there's options I'd like to add but it takes time to code them and I'm in a hurry, and wishing I'd written it in Python, but I didn't. Later I can't even remember how to use it without reading it.

At moments like those, I think, "Sure wish I had a skeleton CLI wireframe."

## Dev Approach

I wanted `shkeleton` to be not just configurable, but malleable as well. That is, I wanted it to work as-is with some simple configuration, but also to design it to be shaped to a wide variety of purposes, quickly. In order to make the entire skel malleable, I tried to keep it simplistic: no arcane scripting. It's up to the user to optimize... or use as-is.

Complicate it as much as you like. Pull requests welcome for code optimization and bug fixing.
