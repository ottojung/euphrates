
(define-library
  (euphrates directory-mtime-state)
  (export directory-mtime-state)
  (import
    (only (euphrates directory-files-rec)
          directory-files-rec))
  (import (only (euphrates file-mtime) file-mtime))
  (import (only (euphrates hashset) list->hashset))
  (import
    (only (euphrates with-ignore-errors)
          with-ignore-errors!))
  (import
    (only (scheme base) begin car cons define map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/directory-mtime-state.scm")))
    (else (include "directory-mtime-state.scm"))))
