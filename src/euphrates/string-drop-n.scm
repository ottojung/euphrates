
%run guile

%var string-drop-n

(define (string-drop-n n str)
  (substring str (min (max 0 n) (string-length str)) (string-length str)))
