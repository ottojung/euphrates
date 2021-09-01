
%run guile

%var dynamic-thread-enable-cancel#p

(define dynamic-thread-enable-cancel#p
  (make-parameter #f))
