
GUILEDIR = guile
RACKETDIR = racket

INSTALL_MAKE = makefiles/install.make

TESTFILES = $(shell ls test/sharedtest/)

DIRPREFIX = src/$(TARGET)
DIRSUFFIX = euphrates

ifeq ($(TARGET),$(GUILEDIR))
END := scm
else
END := rkt
endif

CURRENT_GIT_COMMIT = $(shell git rev-parse HEAD)

BUILDDIR = build

DIR = $(BUILDDIR)/$(DIRPREFIX)/$(DIRSUFFIX)

TESTFILE =
