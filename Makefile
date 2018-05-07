DESTDIR=

BINDIR=/usr/bin
MANDIR=/usr/share/man/man1
SHAREDIR=/usr/share/project-meta
ETCDIR=/etc/project-meta
COMPDIR=/etc/bash_completion.d

.PHONY: all ignore install update sync upload stat help pkg

all:
	pod2man project-meta | gzip > project-meta.1.gz
	pod2html project-meta > project-meta.html

install: update

update:
	@install -d -m 0755 -o root -g root $(DESTDIR)/$(SHAREDIR)
	@install -d -m 0755 -o root -g root $(DESTDIR)/$(SHAREDIR)/license.d
	@install -d -m 0755 -o root -g root $(DESTDIR)/$(SHAREDIR)/template.d
	@install -d -m 0755 -o root -g root $(DESTDIR)/$(MANDIR)
	@install -d -m 0755 -o root -g root $(DESTDIR)/$(COMPDIR)

	install    -m 0755 -o root -g root project-meta $(DESTDIR)/$(BINDIR)

	install    -m 0644 -o root -g root project-meta.1.gz $(DESTDIR)/$(MANDIR)

	install    -m 0644 -o root -g root PROJECT-META.sample.yml $(DESTDIR)/$(SHAREDIR)
	install    -m 0644 -o root -g root license.d/*.txt $(DESTDIR)/$(SHAREDIR)/license.d
	install    -m 0644 -o root -g root template.d/*.tt $(DESTDIR)/$(SHAREDIR)/template.d

	install    -m 0644 -o root -g root project-meta.bash_completion $(DESTDIR)/$(COMPDIR)/project-meta

sync:
	svn update

upload:
	cadaver --rcfile=cadaverrc

pkg: all
	./make-package-debian

stat:
	svn log|egrep '^r[[:digit:]]'|egrep -v '^r1[[:space:]]'|awk '{print $$3}'|sort|uniq -c                 |gnuplot -p -e 'set style fill solid 1.00 border 0; set style histogram; set style data histogram; set xtics rotate by 0; set style line 7 linetype 0 linecolor rgb "#222222"; set grid ytics linestyle 7; set xlabel "User contributor" font "bold"; set ylabel "Number of commit" font "bold"; plot "/dev/stdin" using 1:xticlabels(2) title "commit" linecolor rgb "#666666"'
	(echo '0 2015'; svn log|egrep '^r[[:digit:]]'|awk '{print $$5}'|cut -f 1 -d '-'|sort|uniq -c)|sort -k 2|gnuplot -p -e 'set style fill solid 1.00 border 0; set style histogram; set style data histogram; set xtics rotate by 0; set style line 7 linetype 0 linecolor rgb "#222222"; set grid ytics linestyle 7; set xlabel "Year"             font "bold"; set ylabel "Number of commit" font "bold"; plot "/dev/stdin" using 1:xticlabels(2) title "commit" linecolor rgb "#666666"'

help:
	@echo "Possibles targets:"
	@echo " * all     : make manual"
	@echo " * install : complete install"
	@echo " * update  : update install (do not update cron file)"
	@echo " * sync    : sync with official repository"
	@echo " * upload  : upload on public dav forge space"
	@echo " * stat    : svn stat with gnuplot graph"
	@echo " * pkg     : build Debian package"
	@echo "ignore - svn rules to ignore some files"

ignore: svnignore.txt
	svn propset svn:ignore -F svnignore.txt .
