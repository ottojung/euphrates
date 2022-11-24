
%run guile

%var dynamic-thread-critical-make#p-default

%use (np-thread-global-critical-make) "./np-thread.scm"

(define dynamic-thread-critical-make#p-default
  (lambda () (lambda (section) (section))))
