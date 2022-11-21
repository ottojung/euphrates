
%run guile

%var hashmap-constructor
%var hashmap-predicate

%for (COMPILER "guile")
(define hashmap-constructor make-hash-table)
(define hashmap-predicate hash-table?)
%end

%for (COMPILER "racket")
(define hashmap-constructor make-hash)
(define hashmap-predicate hash?)
%end
