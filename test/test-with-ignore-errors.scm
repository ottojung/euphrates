


(let () ;; with-ignore-errors
  (assert=
   "error:"
   (cadr
    (string->words
     (with-output-to-string
       (parameterize ((current-error-port (current-output-port)))
         (with-ignore-errors!
          (raisu 'test "arg1" "arg2"))))))))
