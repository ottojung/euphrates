
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates raisu) raisu))
   (import
     (only (euphrates string-to-words) string->words))
   (import
     (only (euphrates with-ignore-errors)
           with-ignore-errors!))
   (import
     (only (euphrates with-output-stringified)
           with-output-stringified))
   (import
     (only (scheme base)
           begin
           cadr
           cond-expand
           current-error-port
           current-output-port
           let
           parameterize
           quote))))



(let () ;; with-ignore-errors
  (assert=
   "error:"
   (cadr
    (string->words
     (with-output-stringified
       (parameterize ((current-error-port (current-output-port)))
         (with-ignore-errors!
          (raisu 'test "arg1" "arg2"))))))))
