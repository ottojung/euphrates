
%run guile

%use (dprint#p) "./dprint-p.scm"

%var dprint

(define dprint
  (lambda args
    (apply (dprint#p) args)))


