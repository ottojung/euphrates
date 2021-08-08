
%run guile

%var directory-files-rec

;; Returns object like this:
;;    ((fullname name dirname1 dirname2 dirname3...
;;     (fullname name ....
;;
;;  where dirname1 is the parent dir of the file

%for (COMPILER "guile")

(use-modules (ice-9 ftw))

(define [directory-files-rec directory]
  ;; Don't skip anything
  (define (enter? name stat result)
    #t)

  (define current '())

  (define (leaf name stat result)
    (cons (cons* name (basename name) current)
          result))

  (define (down name stat result)
    (set! current (cons name current))
    result)
  (define (up name stat result)
    (set! current (cdr current))
    result)

  (define (skip name stat result) result)

  ;; ignore errors
  (define (error name stat errno result) result)

  (file-system-fold enter? leaf down up skip error
                    '()
                    directory))

%end

%for (COMPILER "racket")

(define [directory-files-rec directory]
  (define (tostring path)
    (case path
      ((same) directory)
      (else (path->string path))))

  (fold-files
   (lambda [f type ctx]
     (cons (map tostring
                (cons f (reverse (explode-path f))))
           ctx))
   '()
   directory))

%end
