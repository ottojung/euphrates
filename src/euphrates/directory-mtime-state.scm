
(cond-expand
 (guile
  (define-module (euphrates directory-mtime-state)
    :export (directory-mtime-state)
    :use-module ((euphrates directory-files-rec) :select (directory-files-rec))
    :use-module ((euphrates file-mtime) :select (file-mtime))
    :use-module ((euphrates hashset) :select (list->hashset))
    :use-module ((euphrates with-ignore-errors) :select (with-ignore-errors!)))))



;; returns set of all files from the directory and their modification times

(define (directory-mtime-state dir)
  (define files (map car (directory-files-rec dir)))

  (define (safe-mtime file)
    (with-ignore-errors!
     (file-mtime file)))
  (define with-mtimes (map cons files (map safe-mtime files)))

  (list->hashset with-mtimes))
