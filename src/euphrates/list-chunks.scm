
(cond-expand
 (guile
  (define-module (euphrates list-chunks)
    :export (list-chunks)
    :use-module ((euphrates raisu) :select (raisu))
    :use-module ((euphrates list-span-n) :select (list-span-n)))))



(define (list-chunks block-size lst)
  (let loop ((lst lst) (ret '()))
    (if (null? lst) (reverse ret)
        (call-with-values
            (lambda _ (list-span-n block-size lst))
          (lambda (left right)
            (loop right (cons left ret)))))))
