
%run guile

;; NOTE: use `monadic-parameterize' to change the value.
%var monadic-global/p

(define monadic-global/p
  (make-parameter #f))
