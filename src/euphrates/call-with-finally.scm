



;; Runs finally even if exception was thrown (even on thread cancel)
;; expr ::= (-> Any)
;; finally ::= (-> Any)
(define [call-with-finally expr finally]
  (let ((err #f))
    (catch-any
     expr
     (lambda errors
       (set! err errors)))
    (finally)
    (when err
      (apply raisu err))))
