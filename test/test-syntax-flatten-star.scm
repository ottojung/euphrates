
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates syntax-flatten-star)
           syntax-flatten*))
   (import
     (only (scheme base)
           _
           begin
           cond-expand
           define-syntax
           let
           list
           quote
           syntax-rules))))



(let () ;; syntax-flatten-star
  (define-syntax cont
    (syntax-rules () ((_ arg buf) (list arg (quote buf)))))

  (assert= (list 'arg '(a b c g h d h e))
           (syntax-flatten* (cont 'arg) ((a b (c (g h) d) (h) e)))))
