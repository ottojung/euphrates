
(cond-expand
 (guile
  (define-module (euphrates asyncproc)
    :export (asyncproc asyncproc? asyncproc-command asyncproc-args asyncproc-pipe set-asyncproc-pipe! asyncproc-pid set-asyncproc-pid! asyncproc-status set-asyncproc-status! asyncproc-exited? set-asyncproc-exited?!)
    :use-module ((euphrates define-type9) :select (define-type9)))))



(define-type9 <asyncproc>
  (asyncproc command args pipe pid status exited?) asyncproc?
  (command asyncproc-command)
  (args asyncproc-args)
  (pipe asyncproc-pipe set-asyncproc-pipe!)
  (pid asyncproc-pid set-asyncproc-pid!)
  (status asyncproc-status set-asyncproc-status!)
  (exited? asyncproc-exited? set-asyncproc-exited?!)
  )
