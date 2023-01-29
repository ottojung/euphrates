
%run guile

%var dynamic-thread-yield#p

;; This yield should also be called by thread manager while sleeping
(define dynamic-thread-yield#p
  (make-parameter #f))
