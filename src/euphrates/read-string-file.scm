
(cond-expand
 (guile
  (define-module (euphrates read-string-file)
    :export (read-string-file)
    :use-module ((euphrates read-all-port) :select (read-all-port))
    :use-module ((euphrates open-file-port) :select (open-file-port)))))



(define [read-string-file path]
  (let* [[in (open-file-port path "r")]
         [text (read-all-port in read-char)]
         (go (close-port in))]
    text))
