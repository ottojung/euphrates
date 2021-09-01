
%run guile

%var dynamic-thread-critical-make#p-default

%use (dynamic-thread-mutex-make) "./dynamic-thread-mutex-make.scm"
%use (dynamic-thread-mutex-lock!#p) "./dynamic-thread-mutex-lock.scm"
%use (dynamic-thread-mutex-unlock!#p) "./dynamic-thread-mutex-unlock.scm"
%use (dynamic-thread-disable-cancel#p) "./dynamic-thread-disable-cancel-p.scm"
%use (dynamic-thread-enable-cancel#p) "./dynamic-thread-enable-cancel-p.scm"

(define (dynamic-thread-critical-make#p-default)
  (let* ((mut (dynamic-thread-mutex-make))
         (lock! (dynamic-thread-mutex-lock!#p))
         (unlock! (dynamic-thread-mutex-unlock!#p))
         (disable (dynamic-thread-disable-cancel#p))
         (enable (dynamic-thread-enable-cancel#p)))
    (lambda (thunk)
      (disable)
      (lock! mut)
      (call-with-values thunk
        (lambda vals
          (unlock! mut)
          (enable)
          (apply values vals))))))
