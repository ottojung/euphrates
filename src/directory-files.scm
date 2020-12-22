
%run guile

%var directory-files

;; Returns object like this:
;;   ((fullname name)
;;    (fullname name)
;;     ....

%for (COMPILER "guile")

(use-modules (ice-9 ftw))

(define directory-files
  (case-lambda
    ((directory) (directory-files directory #f))
    ((directory include-directories?)

     ;; Skip everything
     (define (enter? name stat result)
       (string=? name directory))

     (define (leaf name stat result)
       (cons (list name (basename name)) result))

     (define (down name stat result)
       result)
     (define (up name stat result)
       result)
     (define (skip name stat result)
       (if include-directories?
           (cons (list name (basename name)) result)
           result))

     ;; ignore errors
     (define (error name stat errno result) result)

     (file-system-fold enter? leaf down up skip error
                       '()
                       directory))))

%end

%for (COMPILER "racket")

(define directory-files
  (case-lambda
    ((directory) (directory-files directory #f))
    ((directory include-directories?)

     (define dirs
       (unless include-directories? (make-hash)))

     (define (down? dir)
       (unless include-directories?
         (let-values (((base name dunno)
                       (split-path dir)))
           (hash-set! dirs name #t)))
       #f)

     (define paths
       (sequence->list
        (in-directory directory down?)))

     (define mapped
       (map
        (lambda (path)
          (let-values
              (((base name dunno)
                (split-path path)))
            (cons path name)))
        paths))

     (define filtered
       (if include-directories?
           mapped
           (filter
            (lambda (pair)
              (not (hash-ref dirs (cdr pair) #f)))
            mapped)))

     (define (stringify pair)
       (list (path->string (car pair))
             (path->string (cdr pair))))

     (map stringify filtered))))

%end
