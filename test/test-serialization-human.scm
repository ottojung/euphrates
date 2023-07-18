
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates assert) assert))
   (import (only (euphrates hashset) list->hashset))
   (import
     (only (euphrates serialization-human)
           deserialize/human
           serialize/human))
   (import
     (only (scheme base)
           begin
           cond-expand
           cons
           define
           eq?
           equal?
           list
           not
           quasiquote
           quote
           unquote))))



(define obj1
  `(hello there "human"))

(define s1
  (serialize/human obj1))
(define d1
  (deserialize/human s1))

(assert= s1 '(list 'hello 'there "human"))
(assert (equal? d1 obj1))
(assert (not (eq? d1 obj1)))

(define obj2
  `(hello there ,(list->hashset '(1 2 3)) how are you?))

(define s2
  (serialize/human obj2))
(define d2
  (deserialize/human s2))

(assert= s2
         '(list 'hello
                'there
                (hashset
                 (value (alist->hash-table
                         (list (cons 1 #t) (cons 2 #t) (cons 3 #t)))))
                'how
                'are
                'you?))

(assert (not (eq? d2 obj2)))
