
(cond-expand
 (guile
  (define-module (euphrates assert)
    :export (assert)
    :use-module ((euphrates raisu) :select (raisu))
    :use-module ((euphrates reversed-args-f) :select (reversed-args-f))
    :use-module ((euphrates assert-raw) :select (assert#raw))
    :use-module ((euphrates stringf) :select (stringf)))))



(define-syntax assert-buf
  (syntax-rules ()
    ((_ orig buf head (last-r))
     (let ((last last-r))
       (unless (reversed-args-f head last . buf)
         (raisu 'assertion-fail
                `(test: ,(cons (quote head) (reversed-args-f list last . buf)))
                `(original: ,(quote orig))))))
    ((_ orig buf head (last-r) . printf-args)
     (let ((last last-r))
       (unless (reversed-args-f head last . buf)
         (raisu 'assertion-fail
                `(test: ,(cons (quote head) (reversed-args-f list last . buf)))
                `(original: ,(quote orig))
                `(description: ,(stringf . printf-args))))))
    ((_ orig buf head (x-r . xs-r) . printf-args)
     (let ((x x-r))
       (assert-buf orig (x . buf) head xs-r . printf-args)))))

;; reduces test to normal form by hand
(define-syntax assert
  (syntax-rules ()
    ((_ (x . xs) . printf-args)
     (assert-buf (x . xs) () x xs . printf-args))
    ((_ test . printf-args)
     (assert#raw test . printf-args))))
