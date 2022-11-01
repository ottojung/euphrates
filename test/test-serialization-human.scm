
%run guile

%use (list->hashset) "./src/ihashset.scm"
%use (deserialize/human serialize/human) "./src/serialization-human.scm"

(use-modules (ice-9 pretty-print))

(define obj1
  `(hello there "human"))

(define s1
  (serialize/human obj1))
(define d1
  (deserialize/human s1))

(pretty-print s1)
(pretty-print d1)

(define obj2
  `(hello there ,(list->hashset '(1 2 3)) how are you?))

(define s2
  (serialize/human obj2))
(define d2
  (deserialize/human s2))

(pretty-print s2)
(pretty-print d2)
