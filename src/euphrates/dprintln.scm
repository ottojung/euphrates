



(define [dprintln fmt . args]
  (apply dprint (conss (string-append fmt "\n") args)))


