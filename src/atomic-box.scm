
%run guile

%for (COMPILER "guile")

(use-modules (ice-9 atomic))

%var make-atomic-box
(define make-atomic-box (@ (ice-9 atomic) make-atomic-box))

%var atomic-box?
(define atomic-box? (@ (ice-9 atomic) atomic-box?))

%var atomic-box-ref
(define atomic-box-ref (@ (ice-9 atomic) atomic-box-ref))

%var atomic-box-set!
(define atomic-box-set! (@ (ice-9 atomic) atomic-box-set!))

;; for racket compatibility
%var atomic-box-compare-and-set!
(define (atomic-box-compare-and-set! box expected desired)
  (let ((ret (atomic-box-compare-and-swap! box expected desired)))
    (eq? ret expected)))

%end



