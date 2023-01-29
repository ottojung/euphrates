
%run guile

;; properties
%use (assert=) "./euphrates/assert-equal.scm"
%use (define-property) "./euphrates/properties.scm"

(let ()

  (define object1 -3)
  (define-property absolute set-absolute! oRsDeyPCHkSMLSRztojiqnz)

  (assert= (absolute object1 #f) #f)

  (set-absolute! object1 3)

  (assert= (absolute object1 #f) 3))
