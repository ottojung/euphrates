
%run guile

%var dynamic-thread-yield#p
%var dynamic-thread-yield

;; This yield should also be called by thread manager while sleeping
(define dynamic-thread-yield#p (make-parameter (lambda _ #f)))
(define (dynamic-thread-yield) ((dynamic-thread-yield#p)))

