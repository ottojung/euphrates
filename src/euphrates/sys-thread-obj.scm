



(define-type9 <sys-thread-obj>
  (sys-thread-obj handle cancel-scheduled? cancel-enabled?) sys-thread-obj?
  (handle sys-thread-obj-handle set-sys-thread-handle!)
  (cancel-scheduled? sys-thread-obj-cancel-scheduled? set-sys-thread-obj-cancel-scheduled?!)
  (cancel-enabled? sys-thread-obj-cancel-enabled? set-sys-thread-obj-cancel-enabled?!)
  )
