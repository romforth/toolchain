# Makefile : build a toolchain for romforth
#
# Copyright (c) 2025 Charles Suresh <romforth@proton.me>
# SPDX-License-Identifier: AGPL-3.0-only
# Please see the LICENSE file for the Affero GPL 3.0 license details

all : ../bin makefile.gen linkbin makeauto.gen
	./linkbin

../bin :
	mkdir ../bin

makefile.gen : genmakefile make_list.tsv
	./genmakefile make_list.tsv > makefile.gen
	$(MAKE) -f makefile.gen

makeauto.gen : genmakefile autogen_list.tsv
	./genmakefile -a autogen_list.tsv > makeauto.gen
	$(MAKE) -f makeauto.gen

../../swegener/sdcc :
	git clone --depth=1 https://github.com/swegener/sdcc ../../swegener/sdcc
	(cd ../../swegener/sdcc ; ./configure --disable-pic14-port --disable-pic16-port)
	${MAKE} -C ../../swegener/sdcc

clean :
	rm -rf makefile.gen makeauto.gen
