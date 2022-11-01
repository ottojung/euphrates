
%run guile

;; json-parse
%use (assert=) "./src/assert-equal.scm"
%use (json-parse) "./src/json-parse.scm"

(let ()
  (let ()
    (define inp "{ \"hello\": true, \"bye\": null }")
    (define parsed
      (call-with-input-string
       inp (lambda (p) (json-parse p))))
    (assert= '(("bye" . null) ("hello" . #t))
             parsed)))
