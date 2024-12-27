
(define-library
  (euphrates olesya-syntax-get-referenced-names)
  (export olesya:syntax:get-referenced-names)
  (import
    (only (euphrates olesya-interpretation-return)
          olesya:return:ok:value
          olesya:return:ok?))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          begin
          cdr
          cond
          define
          for-each
          let
          list?
          null?
          reverse
          symbol?
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olesya-syntax-get-referenced-names.scm")))
    (else (include
            "olesya-syntax-get-referenced-names.scm"))))
