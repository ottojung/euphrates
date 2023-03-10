
(cond-expand
 (guile
  (define-module (test-syntax-append)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates syntax-append) :select (syntax-append)))))


(let ()
  (define-syntax cont
    (syntax-rules () ((_ arg buf) (list arg . buf))))

  (assert= (list 'arg 2 3 4 5 6 7)
           (syntax-append (cont 'arg) (2 3) (4 5 6 7))))

(let ()
  (define-syntax cont
    (syntax-rules () ((_ arg buf) (list arg . buf))))

  (assert= (list 'arg 1 2 3 4 5 6 7 8 9)
           (syntax-append (cont 'arg) (1 2 3) (4 5 6 7) (8 9))))

(let ()
  (define-syntax cont
    (syntax-rules () ((_ arg buf) (list arg . buf))))

  (assert= (list 'arg 1 2 3 4 5 6 7 8 9)
           (syntax-append (cont 'arg) (1 2 3) (4 5) (6 7) (8 9))))
