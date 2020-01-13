
(eval-when (load eval compile)
  (define current-dir (dirname (current-filename)))
  (define suffix "/my-lisp-std/test")
  (define target-dir (substring
                      current-dir
                      0
                      (- (string-length current-dir)
                         (string-length suffix))))
  ;; USAGE:

  (add-to-load-path target-dir))

;; OR

;; (use-modules [srfi srfi-98]) ;; get-environment-variable
;; (add-to-load-path
;;  (string-join
;;   (list
;;    (get-environment-variable "HOME")
;;    "lib")
;;   "/"))

;; OR
;; set GUILE_LOAD_PATH+=$HOME/lib

;; then:
(use-modules [my-lisp-std common])
(use-modules [ice-9 threads])
(use-modules [ice-9 textual-ports])
(use-modules [[srfi srfi-18]
              #:select [make-mutex mutex-lock! mutex-unlock!]
              #:prefix srfi::])

