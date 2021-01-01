
%run guile

%var hashmap
%var hashmap?

%for (COMPILER "guile")
(define hashmap make-hash-table)
(define hashmap? hash-table?)
%end

%for (COMPILER "racket")
(define hashmap make-hash)
(define hashmap? hash?)
%end
