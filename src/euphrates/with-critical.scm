
%run guile

%var with-critical

(define-syntax-rule (with-critical critical-func . bodies)
  (critical-func
   (lambda [] . bodies)))


