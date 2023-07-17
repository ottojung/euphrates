
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
