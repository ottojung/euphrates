

(let ()
  (define p (run-syncproc* "true"))
  (assert= 0 (asyncproc-status p)))

(let ()
  (define p (run-syncproc* "false"))
  (assert= 1 (asyncproc-status p)))

(let ()
  (define s
    (with-output-to-string
      (define p (run-syncproc* "echo" "hello" "there euphrates testcase"))
      (assert= 0 (asyncproc-status p))))
  (assert= s "hello there euphrates testcase\n"))

(let ()
  (define s
    (with-output-to-string
      (define p
        (parameterize ((asyncproc-input-text/p "hello there"))
          (run-syncproc* "cat")))
      (assert= 0 (asyncproc-status p))))
  (assert= s "hello there"))
