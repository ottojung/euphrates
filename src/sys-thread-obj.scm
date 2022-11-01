
%run guile

%var sys-thread-obj
%var sys-thread-obj?
%var sys-thread-obj-handle
%var set-sys-thread-obj-handle!
%var sys-thread-obj-calcel-scheduled?
%var set-sys-thread-obj-calcel-scheduled?!
%var sys-thread-obj-calcel-enabled?
%var set-sys-thread-obj-calcel-enabled?!

%use (define-dumb-record) "./define-dumb-record.scm"

(define-dumb-record <sys-thread-obj>
  (sys-thread-obj handle cancel-scheduled? cancel-enabled?) sys-thread-obj?
  (handle sys-thread-obj-handle set-sys-thread-handle!)
  (cancel-scheduled? sys-thread-obj-calcel-scheduled? set-sys-thread-obj-calcel-scheduled?!)
  (cancel-enabled? sys-thread-obj-calcel-enabled? set-sys-thread-obj-calcel-enabled?!)
  )
