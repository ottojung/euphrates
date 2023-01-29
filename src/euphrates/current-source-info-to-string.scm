
%run guile

%use (remove-common-prefix) "./remove-common-prefix.scm"
%use (get-current-directory) "./get-current-directory.scm"
%use (~a) "./tilda-a.scm"

%var current-source-info->string

(define (current-source-info->string info)
  (let* ((linei (assq 'line info))
         (columni (assq 'column info))
         (filenamei (assq 'filename info))
         (cwd (string-append (get-current-directory) "/"))

         (line (or (and linei (string-append (~a (cdr linei)) ":"))
                   ""))
         (column (or (and columni (string-append (~a (cdr columni)) ":"))
                     ""))
         (filename
          (or (and filenamei
                   (string-append
                    (remove-common-prefix (cdr filenamei) cwd) ":"))
              ""))

         (alli (string-append filename line column)))
    (or (and alli (string-append alli " "))
        "")))

