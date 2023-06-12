

;; json-parse

(let ()
  (let ()
    (define inp "{ \"hello\": true, \"bye\": null }")
    (define parsed
      (call-with-input-string
       inp (lambda (p) (json-parse p))))
    (assert= '(("bye" . null) ("hello" . #t))
             parsed)))
