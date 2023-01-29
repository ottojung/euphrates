
(cond-expand
 (guile
  (define-module (test-list->tree)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-to-tree) :select (list->tree))
    :use-module ((euphrates string-to-words) :select (string->words)))))

;; list->tree

(let ()
  (define ex
    (map string->symbol
         (string->words "hello < define ex < words x > > bye")))

  (let ()
    (define (divider x xs)
      (cond
       ((equal? '< x)
        (values 'open (list x)))
       ((equal? '> x)
        (values 'close (list x)))
       (else
        (values #f #f))))

    (define r (list->tree ex divider))

    (assert=
     r
     '(hello
       (< define ex (< words x >) >)
       bye)))

  (let ()
    (define (divider x xs)
      (cond
       ((equal? '< x)
        (values 'open (list)))
       ((equal? '> x)
        (values 'close (list)))
       (else
        (values #f #f))))

    (define r (list->tree ex divider))

    (assert=
     r
     '(hello
       (define ex (words x))
       bye))))
