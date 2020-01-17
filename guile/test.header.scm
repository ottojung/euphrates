

(eval-when (load compile expand)
  (load "../my-guile-std/common.scm"))

(use-modules [ice-9 threads])
(use-modules [ice-9 textual-ports])
(use-modules [[srfi srfi-18]
              #:select [make-mutex mutex-lock! mutex-unlock!]
              #:prefix srfi::])

