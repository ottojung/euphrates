
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates syntax-map) syntax-map))
   (import
     (only (scheme base)
           _
           begin
           cond-expand
           cons
           define-syntax
           let
           list
           quote
           syntax-rules))))



(let () ;; syntax-map
  (define-syntax cont
    (syntax-rules ()
      ((_ arg buf) (list arg . buf))))

  (define-syntax mapper
    (syntax-rules ()
      ((_ (cont ctxarg) x)
       (cont ctxarg (cons 'p x)))))

  (assert=
   '(arg (p . 1) (p . 2) (p . 3) (p . 4) (p . 5))
   (syntax-map (cont 'arg) mapper (1 2 3 4 5))))
