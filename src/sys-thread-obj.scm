
%run guile

%var sys-thread-obj
%var sys-thread-obj?
%var sys-thread-obj-handle
%var set-sys-thread-obj-handle!
%var sys-thread-obj-cancel-scheduled?
%var set-sys-thread-obj-cancel-scheduled?!
%var sys-thread-obj-cancel-enabled?
%var set-sys-thread-obj-cancel-enabled?!

%use (define-type9) "./define-type9.scm"

(define-type9 <sys-thread-obj>
  (sys-thread-obj handle cancel-scheduled? cancel-enabled?) sys-thread-obj?
  (handle sys-thread-obj-handle set-sys-thread-handle!)
  (cancel-scheduled? sys-thread-obj-cancel-scheduled? set-sys-thread-obj-cancel-scheduled?!)
  (cancel-enabled? sys-thread-obj-cancel-enabled? set-sys-thread-obj-cancel-enabled?!)
  )
