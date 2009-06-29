# Installation directories.
prefix		?= /usr/local
exec_prefix	?= $(prefix)
sbindir		?= $(exec_prefix)/sbin
datarootdir	?= $(prefix)/share
mandir		?= $(datarootdir)/man
man8dir		?= $(mandir)/man8

# Install command.
INSTALL		?= install

# Default destination directory for wrappers.
wrappersdir     ?= /opt/exec-wrapper/bin

# Current script version.
version		= 1.0.1

# Make rules.
all: exec-wrapper exec-wrapper.8

exec-wrapper: exec-wrapper.in
	sed "s,DEFAULT_DEST,${wrappersdir},g" exec-wrapper.in \
			> exec-wrapper
exec-wrapper.8: exec-wrapper.8.in
	sed "s,DEFAULT_DEST,${wrappersdir},g" exec-wrapper.8.in \
			> exec-wrapper.8

.PHONY: clean
clean:
	-rm -f exec-wrapper
	-rm -f exec-wrapper.8
	-rm -rf exec-wrapper-${version}
	-rm -f exec-wrapper-${version}.tar.bz2

.PHONY: install
install: all
	${INSTALL} -d ${DESTDIR}${wrappersdir}
	touch ${DESTDIR}${wrappersdir}/.keep
	${INSTALL} -d ${DESTDIR}${sbindir}
	${INSTALL} -m 0755 exec-wrapper ${DESTDIR}${sbindir}
	${INSTALL} -d ${DESTDIR}${man8dir}
	${INSTALL} -m 0444 exec-wrapper.8 ${DESTDIR}${man8dir}

.PHONY: uninstall
uninstall:
	-rm -f ${DESTDIR}${wrappersdir}/.keep
	-rm -f ${DESTDIR}${sbindir}/exec-wrapper
	-rm -f ${DESTDIR}${man8dir}/exec-wrapper.8

distfiles = exec-wrapper.in exec-wrapper.8.in Makefile AUTHORS COPYING \
		README INSTALL
.PHONY: dist
dist: ${distfiles}
	-rm -rf exec-wrapper-${version}
	mkdir exec-wrapper-${version}
	ln ${distfiles} exec-wrapper-${version}/
	tar chjf exec-wrapper-${version}.tar.bz2 exec-wrapper-${version}
	rm -rf exec-wrapper-${version}

