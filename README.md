# cli-skel.sh

This is a 'skel' wireframe meant to reduce boilerplate option parsing
for more than the simplest CLIs.

Configure self, self options, commands, command options, and positional arguments for either self or commands.Then just write functions named '_run_COMMAND' for each 'COMMAND' defined, using the parsed options and arguments in the code to do ... whatever.

## Install

    git clone ...
    cd cli-skel

To copy a bare-bones, unconfigured copy of `cli-skel.sh` to a new path or path/filename, just do:

    ./cli-skel.sh skel DEST

This copies an *unconfigured* version of `cli-skel.sh` from the `skel` directory to the `DEST` path.

### Quickstart

The *configured* `cli-skel.sh` in the project root is also an *example*. It is heavily annotated, but minimal enough to be modified and used as a CLI skeleton, as well. It may even serve as a sort of tutorial.

To use the installer/example `cli-skel.sh` as the skeleton CLI, just copy it to a new location:

    cp cli-skel.sh DEST

Then open in your favorite text editor (emacs, right?!?) and start reading.

## Summary

The `cli-skel.sh` script is not intended to be an Swiss Army knife. Rather it is a *skeleton* intended to be fleshed out. I wanted a starting point to reduce boilerplate when writing more than the simplest CLI scripts. If I just need to slap `$WHATEVER=$1` in to get a positional argument or two for some quick sloppy script, OK. That's fine.

Yet, sometimes I'm writing scripts I'm going to use a lot, with lots of arguments, and maybe there's options I'd like to add but it takes time to code them and I'm in a hurry, and wishing I'd written it in Python, but I didn't. Later I can't even remember how to use it without reading it.

At moments like those, I think, "Sure wish I had a skeleton CLI wireframe."

## Dev Approach

I wanted `cli-skel.sh` to be not just configurable, but malleable as well. That is, I wanted it to work as-is with some simple configuration, but also to design it to be shaped to a wide variety of purposes, quickly. In order to make the entire skel malleable, I tried to keep it simplistic: no arcane scripting. It's up to the user to optimize... or use as-is.

OOTB, this is a "configuration-over-convention" wireframe. For instance, if a command `foo` is declared in the `COMMANDS` array, then also define both `CMD_ARGS[foo]` and `CMD_OPTS[foo]` even if they are empty. This way the CLI parser doesn't have to check to see if `CMD_ARGS` and `CMD_OPTS` associative arrays contain the key `foo`: they will always have `foo`, though the value may be null.

OTOH, the code is also short and simple, so if one wanted to complicate parsing in any way, or optimize in any way, it won't be a pain to do so.