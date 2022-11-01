
%run guile

%var comprocess
%var comprocess?
%var comprocess-command
%var comprocess-args
%var comprocess-pipe
%var set-comprocess-pipe!
%var comprocess-pid
%var set-comprocess-pid!
%var comprocess-status
%var set-comprocess-status!
%var comprocess-exited?
%var set-comprocess-exited?!

%use (define-dumb-record) "./define-dumb-record.scm"

(define-dumb-record <comprocess>
  (comprocess command args pipe pid status exited?) comprocess?
  (command comprocess-command)
  (args comprocess-args)
  (pipe comprocess-pipe set-comprocess-pipe!)
  (pid comprocess-pid set-comprocess-pid!)
  (status comprocess-status set-comprocess-status!)
  (exited? comprocess-exited? set-comprocess-exited?!)
  )
