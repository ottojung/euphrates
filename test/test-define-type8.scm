
%run guile

%use (define-type8) "./src/define-type8.scm"

(define-type8 mybox0
  (make-mybox0) mybox0?
  )

(define-type8 mybox1
  (make-mybox1 a) mybox1?
  (a mybox1-a)
  )

(define-type8 mybox1m
  (make-mybox1m a) mybox1m?
  (a mybox1m-a set-mybox1m-val1!)
  )

(define-type8 mybox
  (make-mybox val1 val2) mybox?
  (val1 mybox-val1 set-mybox-val1!)
  (val2 mybox-val2)
  )
