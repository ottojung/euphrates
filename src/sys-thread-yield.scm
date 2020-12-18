
%run guile

%use (sys-thread-cancel-scheduled? sys-thread-cancel-enabled?) "./sys-thread.scm"
%use (sys-thread-current) "./sys-thread-current.scm"
%use (dynamic-thread-cancel-tag) "./dynamic-thread-cancel-tag.scm"

%var sys-thread-yield

(define (sys-thread-yield)
  (let ((me (sys-thread-current)))
    (when (and (sys-thread-cancel-scheduled? me)
               (sys-thread-cancel-enabled? me))
      (throw dynamic-thread-cancel-tag))))
