
%run guile

%set (field "handle")
%set (field "cancel-scheduled?")
%set (field "cancel-enabled?")

%for (field @x)
%var sys-thread-obj-@x
%var set-sys-thread-obj-@x!
%end

%var sys-thread-obj
%var sys-thread-obj?

%use (define-type9) "./define-type9.scm"

(define-type9 <sys-thread-obj>
  (sys-thread-obj
%for (field @x)
   @x
%end
   ) sys-thread-obj?

%for (field @x)
   (@x sys-thread-obj-@x set-sys-thread-obj-@x!)
%end

  )
