
%run guile

;; list->tree
%use (assert=) "./euphrates/assert-equal.scm"
%use (list->tree) "./euphrates/list-to-tree.scm"
%use (string->words) "./euphrates/string-to-words.scm"

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
