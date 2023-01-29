
(cond-expand
 (guile
  (define-module (euphrates np-thread-obj)
    :export (np-thread-obj np-thread-obj? np-thread-obj-continuation set-np-thread-obj-continuation! np-thread-obj-cancel-scheduled? set-np-thread-obj-cancel-scheduled?! np-thread-obj-cancel-enabled?)
    :use-module ((euphrates define-type9) :select (define-type9)))))



(define-type9 <np-thread-obj>
  (np-thread-obj continuation cancel-scheduled? cancel-enabled?) np-thread-obj?
  (continuation np-thread-obj-continuation set-np-thread-obj-continuation!)
  (cancel-scheduled? np-thread-obj-cancel-scheduled? set-np-thread-obj-cancel-scheduled?!)
  (cancel-enabled? np-thread-obj-cancel-enabled? set-np-thread-obj-cancel-enabled?!)
  )
