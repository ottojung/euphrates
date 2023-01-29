
(cond-expand
 (guile
  (define-module (euphrates sys-thread-obj)
    :export (sys-thread-obj sys-thread-obj? sys-thread-obj-handle set-sys-thread-obj-handle! sys-thread-obj-cancel-scheduled? set-sys-thread-obj-cancel-scheduled?! sys-thread-obj-cancel-enabled? set-sys-thread-obj-cancel-enabled?!)
    :use-module ((euphrates define-type9) :select (define-type9)))))



(define-type9 <sys-thread-obj>
  (sys-thread-obj handle cancel-scheduled? cancel-enabled?) sys-thread-obj?
  (handle sys-thread-obj-handle set-sys-thread-handle!)
  (cancel-scheduled? sys-thread-obj-cancel-scheduled? set-sys-thread-obj-cancel-scheduled?!)
  (cancel-enabled? sys-thread-obj-cancel-enabled? set-sys-thread-obj-cancel-enabled?!)
  )
