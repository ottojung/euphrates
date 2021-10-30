
%run guile

%var write-string-file

%use (open-file-port) "./open-file-port.scm"

(define [write-string-file path data]
  (let* [[out (open-file-port path "w")]
         [re (display data out)]
         (go (close-port out))]
    re))
