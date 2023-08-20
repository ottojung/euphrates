
(define-module (update-to-generated-parsers)
  :use-module ((euphrates directory-files) :select (directory-files))
  :use-module ((euphrates path-get-basename) :select (path-get-basename))
  :use-module ((euphrates pretty-print) :select (pretty-print))
  :use-module ((euphrates read-list) :select (read-list))
  :use-module ((euphrates stringf) :select (stringf))
  )

(define files
  (map car (directory-files "scripts/generated")))

(for-each
 (lambda (file)
   (define name (path-get-basename file))
   (define target-file
     (stringf "test/data/~a" name))

   (define code
     (call-with-input-file file read-list))

   (define (pp x) (pretty-print x) (newline))

   (call-with-output-file
       target-file
     (lambda (p)
       (parameterize ((current-output-port p))
         (for-each pp code)))))
 files)
