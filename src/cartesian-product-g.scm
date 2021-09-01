
%run guile

%use (cartesian-product) "./cartesian-product.scm"
%use (cartesian-map) "./cartesian-map.scm"

%var cartesian-product/g/reversed
%var cartesian-product/g

(define (cartesian-product/g/reversed lists)
  (if (or (null? lists) (null? (cdr lists))) lists
      (let loop ((ret (cartesian-map list (cadr lists) (car lists)))
                 (lists (cddr lists)))
        (if (null? lists) ret
            (loop (cartesian-product (car lists) ret)
                  (cdr lists))))))

(define (cartesian-product/g lists)
  (cartesian-product/g/reversed (reverse lists)))
