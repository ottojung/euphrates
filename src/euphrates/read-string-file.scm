



(define [read-string-file path]
  (let* [[in (open-file-port path "r")]
         [text (read-all-port in read-char)]
         (go (close-port in))]
    text))
