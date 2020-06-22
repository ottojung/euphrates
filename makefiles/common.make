
GUILEDIR = guile
RACKETDIR = racket

INSTALL_MAKE = makefiles/install.make

TESTFILES = $(shell ls test/sharedtest/)

DIRPREFIX = src/$(BACKEND)
DIRSUFFIX = euphrates

ifeq ($(BACKEND),$(GUILEDIR))
END := scm
else
END := rkt
endif

CURRENT_GIT_COMMIT = $(shell git rev-parse HEAD)

BUILDDIR = build

DIR = $(BUILDDIR)/$(DIRPREFIX)/$(DIRSUFFIX)

TESTFILE =
