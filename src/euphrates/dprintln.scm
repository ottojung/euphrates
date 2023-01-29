
(cond-expand
 (guile
  (define-module (euphrates dprintln)
    :export (dprintln)
    :use-module ((euphrates dprint) :select (dprint))
    :use-module ((euphrates conss) :select (conss)))))



(define [dprintln fmt . args]
  (apply dprint (conss (string-append fmt "\n") args)))


