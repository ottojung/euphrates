
%run guile

%var dynamic-thread-disable-cancel#p

(define dynamic-thread-disable-cancel#p
  (make-parameter #f))
