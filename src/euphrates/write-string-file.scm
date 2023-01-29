
(cond-expand
 (guile
  (define-module (euphrates write-string-file)
    :export (write-string-file)
    :use-module ((euphrates open-file-port) :select (open-file-port)))))



(define [write-string-file path data]
  (let* [[out (open-file-port path "w")]
         [re (display data out)]
         (go (close-port out))]
    re))
