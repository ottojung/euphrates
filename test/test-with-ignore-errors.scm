


(let () ;; with-ignore-errors
  (assert=
   "error:"
   (cadr
    (string->words
     (with-output-stringified
       (parameterize ((current-error-port (current-output-port)))
         (with-ignore-errors!
          (raisu 'test "arg1" "arg2"))))))))
