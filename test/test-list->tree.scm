
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates list-to-tree) list->tree))
   (import
     (only (euphrates string-to-words) string->words))
   (import
     (only (scheme base)
           <
           >
           begin
           cond
           cond-expand
           define
           else
           equal?
           let
           list
           map
           quote
           string->symbol
           values))))


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
