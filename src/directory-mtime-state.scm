
%run guile

%var directory-mtime-state

%use (directory-files-rec) "./directory-files-rec.scm"
%use (file-mtime) "./file-mtime.scm"
%use (list->hashset) "./ihashset.scm"

;; returns set of all files from the directory and their modification times

(define (directory-mtime-state dir)
  (define files (map car (directory-files-rec dir)))

  (define with-mtimes (map cons files (map file-mtime files)))

  (list->hashset with-mtimes))
