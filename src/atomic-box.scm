
%run guile

%var make-atomic-box
%var atomic-box?
%var atomic-box-ref
%var atomic-box-set!
%var atomic-box-compare-and-set!

%for (COMPILER "guile")

(use-modules (ice-9 atomic))

(define make-atomic-box (@ (ice-9 atomic) make-atomic-box))
(define atomic-box? (@ (ice-9 atomic) atomic-box?))
(define atomic-box-ref (@ (ice-9 atomic) atomic-box-ref))
(define atomic-box-set! (@ (ice-9 atomic) atomic-box-set!))

(define (atomic-box-compare-and-set! box expected desired)
  (let ((ret (atomic-box-compare-and-swap! box expected desired)))
    (eq? ret expected)))

%end

%for (COMPILER "racket")

(define make-atomic-box box)
(define atomic-box? box?)
(define atomic-box-ref unbox)
(define atomic-box-set! set-box!)
(define atomic-box-compare-and-set! box-cas!)

%end


