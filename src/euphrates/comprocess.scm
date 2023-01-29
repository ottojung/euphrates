
(cond-expand
 (guile
  (define-module (euphrates comprocess)
    :export (comprocess comprocess? comprocess-command comprocess-args comprocess-pipe set-comprocess-pipe! comprocess-pid set-comprocess-pid! comprocess-status set-comprocess-status! comprocess-exited? set-comprocess-exited?!)
    :use-module ((euphrates define-type9) :select (define-type9)))))



(define-type9 <comprocess>
  (comprocess command args pipe pid status exited?) comprocess?
  (command comprocess-command)
  (args comprocess-args)
  (pipe comprocess-pipe set-comprocess-pipe!)
  (pid comprocess-pid set-comprocess-pid!)
  (status comprocess-status set-comprocess-status!)
  (exited? comprocess-exited? set-comprocess-exited?!)
  )
