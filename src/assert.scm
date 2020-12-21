
%run guile

%use (reversed-args) "./reversed-args.scm"
%use (reversed-args-f) "./reversed-args-f.scm"
%use (assert#raw) "./assert-raw.scm"

%var assert

(define-syntax assert-buf
  (syntax-rules ()
    ((_ orig buf (last-r))
     (let ((last last-r))
       (unless (reversed-args last . buf)
         (throw 'assertion-fail
                `(test: ,(quote orig))
                `(test!: ,(reversed-args-f list last . buf))))))
    ((_ orig buf (last-r) . printf-args)
     (let ((last last-r))
       (unless (reversed-args last . buf)
         (throw 'assertion-fail
                `(test: ,(quote orig))
                `(test!: ,(reversed-args-f list last . buf))
                `(description: ,(stringf . printf-args))))))
    ((_ orig buf (x-r . xs-r) . printf-args)
     (let ((x x-r))
       (assert-buf orig (x . buf) xs-r . printf-args)))))

;; reduces test to normal form by hand
(define-syntax assert
  (syntax-rules ()
    ((_ (x . xs) . printf-args)
     (assert-buf (x . xs) () (x . xs) . printf-args))
    ((_ test . printf-args)
     (assert#raw test . printf-args))))
