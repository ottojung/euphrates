
(cond-expand
 (guile
  (define-module (euphrates open-cond-obj)
    :export (open-cond-constructor open-cond-predicate open-cond-value set-open-cond-value!)
    :use-module ((euphrates define-type9) :select (define-type9)))))



(define-type9 open-cond
  (open-cond-constructor value) open-cond-predicate
  (value open-cond-value set-open-cond-value!))
