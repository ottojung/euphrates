
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates assert) assert))
   (import
     (only (euphrates define-type9)
           define-type9
           type9-get-record-descriptor))
   (import
     (only (euphrates with-output-stringified)
           with-output-stringified))
   (import
     (only (scheme base)
           assoc
           begin
           cdr
           cond-expand
           define
           eq?
           not
           quote))
   (import (only (scheme write) write))))



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

(define-type9 myboxc
  (make-myboxc val1 val2) myboxc?
  (val1 myboxc-val1 set-myboxc-val1!)
  (val2 myboxc-val2)
  )

(define obj1
  (make-mybox 1 2))

(define obj2
  (make-mybox 1 2))

(assert (mybox? obj1))
(assert (mybox? obj2))
(assert= obj1 obj2)
(assert (not (eq? obj1 obj2)))

(assert (not (mybox1? obj1)))
(assert (not (mybox1m? obj1)))
(assert (not (myboxc? obj1)))

(assert= 'mybox mybox)
(assert= 'mybox0 mybox0)
(assert= 'mybox1 mybox1)
(assert= 'mybox1m mybox1m)

(assert=
 "#<r2m :: mybox a: 1 b: 2>"
 (with-output-stringified
   (write obj1)))

(define desc1
  (type9-get-record-descriptor obj1))

(assert desc1)
(assert= 'mybox (cdr (assoc 'name desc1)))
