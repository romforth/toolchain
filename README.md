# Toolchain to build the binaries required to build romforth

## To get the source:
	git clone https://github.com/romforth/toolchain

## To build all of the binaries required to build `romforth`
	make

## What is this used for?
There are a boatload of dependencies that are required to build
[romforth](https://github.com/romforth/romforth) successfully.

I've recently created a repo to help with building [binutils](https://github.com/romforth/build-binutils) for all of the architectures required by `romforth`.

This repo provides a toolchain to generate ~~all~~ most of the binaries
required to build/test `romforth` (including `binutils`, by leveraging
`build-binutils`) among others.

## Details

### Builds done via make_list.tsv

Source dependencies which have a `makefile` are listed in `make_list.tsv` which
has three required columns : `url`, `owner`, `repo`, and two optional columns
- the build `dir`ectory and the build `target`.

The repos listed in `make_list.tsv` will be downloaded and built using a build
template that looks something like this:
```
git clone https://$url/$owner/$repo ../../$owner/$repo
make -C ../../$owner/$repo/$dir $target
```
where each of the variables correspond to the column values in `make_list.tsv`

The repos listed in `make_list.tsv` are used to build the following repos:
- binutils (all architectures that are required for the build)
- retroutils (used to build bin2load)
- simh (used to build pdp11)

### Builds directly done by the `Makefile`

In addition to the repos which can be built by calling `make` the `Makefile`
takes care of downloading and building the following repos where the build
is a bit more involved than just running `make`
- sdcc (which needs `configure ; make`)
- nasm (which needs `autogen.sh ; configure ; make`)

### Builds that are currently not done (but may be done in the future)

The toolchain currently does not build the following dependencies which are
needed for a `romforth` build and assumes that they have been installed by
other means and are in your PATH already. Just to keep track of dependencies
in one place I've used a shell script (`linkbin`) which creates the appropriate
links in the ../bin directory. It sets up links for the following dependencies:
- perl
- zig
- qemu
- m4
- msp430-gcc
- wasmtime

I plan to whittle down the above list so that many of the uncommon ones
(msp430-gcc, wasmtime) can be provided by this toolchain.

## Rationale

If you are on Ubuntu (or NixOS), installing these packages may be pretty
trivial but I want to see if I can also help the folks who are on distros where
many of these dependencies may not be already available in packaged form.
