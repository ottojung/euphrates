
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (assert) "./src/assert.scm"
%use (list->hashset) "./src/hashset.scm"
%use (deserialize/short serialize/short) "./src/serialization-short.scm"

(use-modules (ice-9 pretty-print))

(define obj1
  `(hello there "short"))

(define s1
  (serialize/short obj1))
(define d1
  (deserialize/short s1))

(assert= s1 '(list 'hello 'there "short"))
(assert (equal? d1 obj1))
(assert (not (eq? d1 obj1)))

(define obj2
  `(hello there ,(list->hashset '(1 2 3)) how are you?))

(define s2
  (serialize/short obj2))
(define d2
  (deserialize/short s2))

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
