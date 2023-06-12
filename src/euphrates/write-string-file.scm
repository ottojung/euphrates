



(define [write-string-file path data]
  (let* [[out (open-file-port path "w")]
         [re (display data out)]
         (go (close-port out))]
    re))
