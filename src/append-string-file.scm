
%run guile

%var append-string-file

%use (open-file-port) "./open-file-port.scm"

(define [append-string-file path data]
  (let* [[out (open-file-port path "a")]
         [re (display data out)]
         (go (close-port out))]
    re))

