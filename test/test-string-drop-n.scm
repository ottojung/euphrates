
(cond-expand
 (guile
  (define-module (test-string-drop-n)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates string-drop-n) :select (string-drop-n)))))


(let () ;; string-drop-n
  (assert= "hello" (string-drop-n 0 "hello"))
  (assert= "ello" (string-drop-n 1 "hello"))
  (assert= "llo" (string-drop-n 2 "hello"))
  (assert= "lo" (string-drop-n 3 "hello"))
  (assert= "o" (string-drop-n 4 "hello"))
  (assert= "" (string-drop-n 5 "hello"))
  (assert= "" (string-drop-n 6 "hello"))
  (assert= "" (string-drop-n 612381238 "hello"))
  (assert= "hello" (string-drop-n -1 "hello"))
  (assert= "" (string-drop-n 0 ""))
  (assert= "" (string-drop-n 5 "")))
