
(cond-expand
 (guile
  (define-module (test-with-ignore-errors)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates raisu) :select (raisu))
    :use-module ((euphrates string-to-words) :select (string->words))
    :use-module ((euphrates with-ignore-errors) :select (with-ignore-errors!)))))


(let () ;; with-ignore-errors
  (assert=
   "error:"
   (cadr
    (string->words
     (with-output-to-string
       (lambda ()
         (parameterize ((current-error-port (current-output-port)))
           (with-ignore-errors!
            (raisu 'test "arg1" "arg2")))))))))
