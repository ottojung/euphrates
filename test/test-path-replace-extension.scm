
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates path-replace-extension)
           path-replace-extension))
   (import (only (scheme base) begin cond-expand))))

(assert=
 "file.c"
 (path-replace-extension "file.h" ".c"))

(assert=
 "file.b.c"
 (path-replace-extension "file.b.a" ".c"))

(assert=
 "file.c"
 (path-replace-extension "file" ".c"))

(assert=
 ".c"
 (path-replace-extension "" ".c"))
