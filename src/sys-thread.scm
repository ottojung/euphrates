
%run guile

%set (field "handle")
%set (field "cancel-scheduled?")
%set (field "cancel-enabled?")

%for (field @x)
%var sys-thread-@x
%var set-sys-thread-@x!
%end

%var sys-thread
%var sys-thread?

%for (LANGUAGE guile)
(use-modules (srfi srfi-9))
%end

(define-record-type <sys-thread>
  (sys-thread
%for (field @x)
   @x
%end
   ) sys-thread?

%for (field @x)
   (@x sys-thread-@x set-sys-thread-@x!)
%end

  )
