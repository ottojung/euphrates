
%run guile

%var np-thread-obj
%var np-thread-obj?
%var np-thread-obj-continuation
%var set-np-thread-obj-continuation!
%var np-thread-obj-cancel-scheduled?
%var set-np-thread-obj-cancel-scheduled?!
%var np-thread-obj-cancel-enabled? set-np-thread-obj-cancel-enabled?!

%use (define-dumb-record) "./define-dumb-record.scm"

(define-dumb-record <np-thread-obj>
  (np-thread-obj continuation cancel-scheduled? cancel-enabled?) np-thread-obj?
  (continuation np-thread-obj-continuation set-np-thread-obj-continuation!)
  (cancel-scheduled? np-thread-obj-cancel-scheduled? set-np-thread-obj-cancel-scheduled?!)
  (cancel-enabled? np-thread-obj-cancel-enabled? set-np-thread-obj-cancel-enabled?!)
  )
