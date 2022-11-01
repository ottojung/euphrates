
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (assert) "./src/assert.scm"
%use (define-type9 type9-get-record-descriptor) "./src/define-type9.scm"

(define-type9 mybox0
  (make-mybox0) mybox0?
  )

(define-type9 mybox1
  (make-mybox1 a) mybox1?
  (a mybox1-a)
  )

(define-type9 mybox1m
  (make-mybox1m a) mybox1m?
  (a mybox1m-a set-mybox1m-val1!)
  )

(define-type9 mybox
  (make-mybox val1 val2) mybox?
  (val1 mybox-val1 set-mybox-val1!)
  (val2 mybox-val2)
  )

(define obj1
  (make-mybox 1 2))

(define obj2
  (make-mybox 1 2))

(assert= obj1 obj2)
(assert (not (eq? obj1 obj2)))

(assert=
 "#<r2m :: mybox a: 1 b: 2>"
 (with-output-to-string
   (lambda _ (write obj1))))

(define desc1
  (type9-get-record-descriptor obj1))

(assert desc1)
(assert= 'mybox (cdr (assoc 'name desc1)))
