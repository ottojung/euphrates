
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-cancel-tag)
    :export (dynamic-thread-cancel-tag))))


(define dynamic-thread-cancel-tag
  'euphrates-dynamic-thread-cancelled)

