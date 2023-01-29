
%run guile

%var directory-mtime-state

%use (directory-files-rec) "./directory-files-rec.scm"
%use (file-mtime) "./file-mtime.scm"
%use (list->hashset) "./hashset.scm"
%use (with-ignore-errors!) "./with-ignore-errors.scm"

;; returns set of all files from the directory and their modification times

(define (directory-mtime-state dir)
  (define files (map car (directory-files-rec dir)))

  (define (safe-mtime file)
    (with-ignore-errors!
     (file-mtime file)))
  (define with-mtimes (map cons files (map safe-mtime files)))

  (list->hashset with-mtimes))
