
%run guile

%use (dprint) "./dprint.scm"

%var dprintln

(define [dprintln fmt . args]
  (apply dprint (cons* (string-append fmt "\n") args)))


