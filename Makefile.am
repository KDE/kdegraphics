## kdegraphics/Makefile.am $Id$
## (C) 1997 Stephan Kulow

AUTOMAKE_OPTIONS = foreign 1.4
SUBDIRS = $(TOPSUBDIRS)
DISTCLEANFILES = inst-apps

install-data-local:
	@echo ""
	@echo ""
	@echo ""
	@echo "*************** Important *************************"
	@echo ""
	@echo " add "$(bindir)" to your PATH"
	@echo ""
	@echo " Please report bugs with our web form at"
	@echo " http://bugs.kde.org."
	@echo ""
	@echo " Stephan Kulow <coolo@kde.org> and all the KDE"
	@echo " developers wish you fun with the KDE."                     
	@echo "****************************************************"
	@echo ""

messages:
	make -f admin/Makefile.common package-messages

configure.in: configure.in.in subdirs
	$(MAKE) -f admin/Makefile.common configure.in

subdirs:
	$(MAKE) -f admin/Makefile.common subdirs

acinclude.m4: $(top_srcdir)/admin/acinclude.m4.in $(top_srcdir)/admin/libtool.m4.in
	@cd $(top_srcdir) && cat admin/acinclude.m4.in admin/libtool.m4.in > acinclude.m4 

MAINTAINERCLEANFILES = subdirs configure.in acinclude.m4 SUBDIRS
