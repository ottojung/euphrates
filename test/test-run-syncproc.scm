
(cond-expand
 (guile
  (define-module (test-run-syncproc)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates asyncproc) :select (asyncproc-status))
    :use-module ((euphrates run-syncproc) :select (run-syncproc))
    )))

(let ()
  (define p (run-syncproc "true"))
  (assert= 0 (asyncproc-status p)))

(let ()
  (define p (run-syncproc "false"))
  (assert= 1 (asyncproc-status p)))

(let ()
  (define s
    (with-output-to-string
      (lambda _
        (define p (run-syncproc "echo" "hello" "there euphrates testcase"))
        (assert= 0 (asyncproc-status p)))))
  (assert= s "hello there euphrates testcase\n"))
