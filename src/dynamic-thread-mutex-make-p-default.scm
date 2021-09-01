
%run guile

%var dynamic-thread-mutex-make#p-default

%use (sys-mutex-make) "./sys-mutex-make.scm"

(define dynamic-thread-mutex-make#p-default
  sys-mutex-make)
