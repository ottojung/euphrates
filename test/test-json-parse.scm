
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates call-with-input-string)
           call-with-input-string))
   (import (only (euphrates json-parse) json-parse))
   (import
     (only (scheme base)
           begin
           cond-expand
           define
           lambda
           let
           quote))))


;; json-parse

(let ()
  (let ()
    (define inp "{ \"hello\": true, \"bye\": null }")
    (define parsed
      (call-with-input-string
       inp (lambda (p) (json-parse p))))
    (assert= '(("bye" . null) ("hello" . #t))
             parsed)))
