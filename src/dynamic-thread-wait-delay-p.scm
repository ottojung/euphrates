
%run guile

%var dynamic-thread-wait-delay#us#p

(define dynamic-thread-wait-delay#us#p
  (make-parameter #f))
