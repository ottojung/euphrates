
%run guile

%use (read-all-port) "./read-all-port.scm"

%var read-string-file

(define [read-string-file path]
  (let* [
   [in (open-file path "r")]
   [text (read-all-port in read-char)]
   (go (close-port in))]
   text))


