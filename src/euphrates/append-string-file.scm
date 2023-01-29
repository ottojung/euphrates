
(cond-expand
 (guile
  (define-module (euphrates append-string-file)
    :export (append-string-file)
    :use-module ((euphrates open-file-port) :select (open-file-port)))))



(define [append-string-file path data]
  (let* [[out (open-file-port path "a")]
         [re (display data out)]
         (go (close-port out))]
    re))

