
(cond-expand
 (guile
  (define-module (euphrates current-source-info-to-string)
    :export (current-source-info->string)
    :use-module ((euphrates remove-common-prefix) :select (remove-common-prefix))
    :use-module ((euphrates get-current-directory) :select (get-current-directory))
    :use-module ((euphrates tilda-a) :select (~a)))))



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

