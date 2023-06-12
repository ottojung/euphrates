



(define [append-string-file path data]
  (let* [[out (open-file-port path "a")]
         [re (display data out)]
         (go (close-port out))]
    re))

