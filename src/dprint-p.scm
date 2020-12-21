
%run guile

%use (dprint#p-default) "./dprint-p-default.scm"

%var dprint#p

(define dprint#p
  (make-parameter dprint#p-default))

