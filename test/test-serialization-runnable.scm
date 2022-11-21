
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (assert) "./src/assert.scm"
%use (hashset) "./src/hashset-obj.scm"
%use (list->hashset) "./src/hashset.scm"
%use (deserialize/runnable serialize/runnable) "./src/serialization-runnable.scm"

(use-modules (ice-9 pretty-print))

(define obj1
  `(hello there "runnable"))

(define s1
  (serialize/runnable obj1))
(define d1
  (deserialize/runnable s1))

(assert= s1 '(list 'hello 'there "runnable"))
(assert (equal? d1 obj1))
(assert (not (eq? d1 obj1)))

(define obj2
  `(hello there ,(list->hashset '(1 2 3)) how are you?))

(define s2
  (serialize/runnable obj2))
(define d2
  (deserialize/runnable s2))

(assert= s2
         '(list 'hello
                'there
                (hashset
                 (alist->hash-table
                  (list (cons 1 #t) (cons 2 #t) (cons 3 #t))))
                'how
                'are
                'you?))

(assert (not (eq? d2 obj2)))

(assert=
 identity
 (deserialize/runnable (serialize/runnable identity)))
