
(define-library
  (test-olesya-treeify)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates olesya-treeify) olesya:treeify))
  (import
    (only (scheme base)
          =
          begin
          define
          equal?
          if
          map
          quote
          unless))
  (import (only (scheme eval) eval))
  (import (only (scheme process-context) exit))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-olesya-treeify.scm")))
    (else (include "test-olesya-treeify.scm"))))
