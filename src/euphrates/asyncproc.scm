



(define-type9 <asyncproc>
  (asyncproc command args pipe pid status exited?) asyncproc?
  (command asyncproc-command)
  (args asyncproc-args)
  (pipe asyncproc-pipe set-asyncproc-pipe!)
  (pid asyncproc-pid set-asyncproc-pid!)
  (status asyncproc-status set-asyncproc-status!)
  (exited? asyncproc-exited? set-asyncproc-exited?!)
  )
