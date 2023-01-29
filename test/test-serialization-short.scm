
%run guile

%use (assert=) "./euphrates/assert-equal.scm"
%use (assert) "./euphrates/assert.scm"
%use (define-type9) "./euphrates/define-type9.scm"
%use (list->hashset) "./euphrates/hashset.scm"
%use (deserialize/short serialize/short) "./euphrates/serialization-short.scm"

(use-modules (ice-9 pretty-print))

(define obj1
  `(hello there "short"))

(define s1
  (serialize/short obj1))
(define d1
  (deserialize/short s1))

(assert= s1 '(hello there "short"))

(assert (equal? d1 obj1))
(assert (not (eq? d1 obj1)))

(define obj2
  `(hello there ,(list->hashset '(1 2 3)) how are you?))

(define s2
  (serialize/short obj2))
(define d2
  (deserialize/short s2))

(assert= s2
         '(hello
           there
           (@hashset
            (value (@hash-table
                    ((1 . #t) (2 . #t) (3 . #t)))))
           how
           are
           you?))

(assert (not (eq? d2 obj2)))

(assert= '(hello quote "short")
         (serialize/short `(hello quote "short")))

(assert= '(hello (@quote @bye) "short")
         (serialize/short `(hello @bye "short")))

(define-type9 type1
  (type1-constructor fielda filedb) type1?
  (fileda type1-fielda)
  (filedb type1-fieldb)
  )

(define inst (type1-constructor 1 2))

(assert= `(hello (@type1 (fielda 1) (filedb 2)) "short")
         (serialize/short `(hello ,inst "short")))
