
(cond-expand
 (guile
  (define-module (euphrates command-line-arguments-p)
    :export (command-line-argumets/p))))


;; access with (get-command-line-arguments)
(define command-line-argumets/p
  (make-parameter #f))
