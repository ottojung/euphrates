
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (assert) "./src/assert.scm"
%use (list->hashset) "./src/hashset.scm"
%use (deserialize/human serialize/human) "./src/serialization-human.scm"

(use-modules (ice-9 pretty-print))

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
