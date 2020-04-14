
GUILEDIR = guile
RACKETDIR = racket

TESTFILES = $(shell ls sharedtest/)

DIRPREFIX =
DIRSUFFIX = euphrates

ifeq ($(DIRPREFIX),$(GUILEDIR))
END := scm
else
END := rkt
endif

CURRENT_GIT_COMMIT = $(shell git rev-parse HEAD)

DIR = $(DIRPREFIX)/$(DIRSUFFIX)

TESTFILE =
