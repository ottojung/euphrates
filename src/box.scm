
%run guile

%var make-box
%var box?
%var box-ref
%var box-set!

%for (COMPILER "guile")

(use-modules (srfi srfi-111))

(define make-box (@ (srfi srfi-111) box))
(define box? (@ (srfi srfi-111) box?))
(define box-ref (@ (srfi srfi-111) unbox))
(define box-set! (@ (srfi srfi-111) set-box!))

%end
%for (COMPILER "racket")

(define make-box box)
(define box? box?)
(define box-ref unbox)
(define box-set! set-box!)

%end


