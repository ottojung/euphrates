
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates asyncproc-input-text-p)
           asyncproc-input-text/p))
   (import
     (only (euphrates asyncproc) asyncproc-status))
   (import
     (only (euphrates run-syncproc-star)
           run-syncproc*))
   (import
     (only (euphrates with-output-stringified)
           with-output-stringified))
   (import
     (only (scheme base)
           begin
           cond-expand
           define
           let
           parameterize))))


(let ()
  (define p (run-syncproc* "true"))
  (assert= 0 (asyncproc-status p)))

(let ()
  (define p (run-syncproc* "false"))
  (assert= 1 (asyncproc-status p)))

(let ()
  (define s
    (with-output-stringified
      (define p (run-syncproc* "echo" "hello" "there euphrates testcase"))
      (assert= 0 (asyncproc-status p))))
  (assert= s "hello there euphrates testcase\n"))

(let ()
  (define s
    (with-output-stringified
      (define p
        (parameterize ((asyncproc-input-text/p "hello there"))
          (run-syncproc* "cat")))
      (assert= 0 (asyncproc-status p))))
  (assert= s "hello there"))
