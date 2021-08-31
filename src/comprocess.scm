
%run guile

%set (field "command")
%set (field "args")
%set (field "pipe")
%set (field "pid")
%set (field "status")
%set (field "exited?")

%for (field @x)
%var comprocess-@x
%var set-comprocess-@x!
%end

%var comprocess
%var comprocess?

%use (define-type9) "./define-type9.scm"

(define-type9 <comprocess>
  (comprocess

%for (field @x)
     @x
%end

  ) comprocess?

%for (field @x)
   (@x comprocess-@x set-comprocess-@x!)
%end

  )
