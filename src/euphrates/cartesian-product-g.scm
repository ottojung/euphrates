



(define (cartesian-product/g/reversed lists)
  (cond
   ((null? lists) '())
   ((null? (cdr lists)) (map list (car lists)))
   (else
    (let loop ((ret (cartesian-map list (cadr lists) (car lists)))
               (lists (cddr lists)))
      (if (null? lists) ret
          (loop (cartesian-product (car lists) ret)
                (cdr lists)))))))

(define (cartesian-product/g lists)
  (cartesian-product/g/reversed (reverse lists)))
