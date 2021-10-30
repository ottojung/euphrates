
%run guile

%var read-string-file

%use (read-all-port) "./read-all-port.scm"
%use (open-file-port) "./open-file-port.scm"

(define [read-string-file path]
  (let* [[in (open-file-port path "r")]
         [text (read-all-port in read-char)]
         (go (close-port in))]
    text))
