# Makefile : build a toolchain for romforth
#
# Copyright (c) 2025 Charles Suresh <romforth@proton.me>
# SPDX-License-Identifier: AGPL-3.0-only
# Please see the LICENSE file for the Affero GPL 3.0 license details

all : ../bin makefile.gen linkbin
	./linkbin

../bin :
	mkdir ../bin

makefile.gen : genmakefile make_list.tsv
	./genmakefile make_list.tsv > makefile.gen
	$(MAKE) -f makefile.gen

../../swegener/sdcc :
	git clone --depth=1 https://github.com/swegener/sdcc ../../swegener/sdcc
	(cd ../../swegener/sdcc ; ./configure --disable-pic14-port --disable-pic16-port)
	${MAKE} -C ../../swegener/sdcc

../../netwide-assembler/nasm :
	git clone --depth=1 https://github.com/netwide-assembler/nasm ../../netwide-assembler/nasm
	(cd ../../netwide-assembler/nasm ; ./autogen.sh)
	(cd ../../netwide-assembler/nasm ; ./configure)
	${MAKE} -C ../../netwide-assembler/nasm

clean :
	rm -rf makefile.gen
