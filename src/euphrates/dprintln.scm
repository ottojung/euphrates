
%run guile

%use (dprint) "./dprint.scm"
%use (conss) "./conss.scm"

%var dprintln

(define [dprintln fmt . args]
  (apply dprint (conss (string-append fmt "\n") args)))


