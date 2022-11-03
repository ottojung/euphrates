
%run guile

%var np-thread-obj
%var np-thread-obj?
%var np-thread-obj-continuation
%var set-np-thread-obj-continuation!
%var np-thread-obj-cancel-scheduled?
%var set-np-thread-obj-cancel-scheduled?!
%var np-thread-obj-cancel-enabled? set-np-thread-obj-cancel-enabled?!

%use (define-type9) "./define-type9.scm"

(define-type9 <np-thread-obj>
  (np-thread-obj continuation cancel-scheduled? cancel-enabled?) np-thread-obj?
  (continuation np-thread-obj-continuation set-np-thread-obj-continuation!)
  (cancel-scheduled? np-thread-obj-cancel-scheduled? set-np-thread-obj-cancel-scheduled?!)
  (cancel-enabled? np-thread-obj-cancel-enabled? set-np-thread-obj-cancel-enabled?!)
  )
