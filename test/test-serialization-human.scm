
%run guile

%use (list->hashset) "./src/ihashset.scm"
%use (serialize/human) "./src/serialization-human.scm"

(use-modules (ice-9 pretty-print))

(define obj1
  `(hello there "human"))

(define s1
  (serialize/human obj1))

(pretty-print s1)

(define obj2
  `(hello there ,(list->hashset '(1 2 3)) how are you?))

(define s2
  (serialize/human obj2))

(pretty-print s2)
