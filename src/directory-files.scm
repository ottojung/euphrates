
%run guile

%var directory-files

;; Returns object like this:
;;   ((fullname name)
;;    (fullname name)
;;     ....

%use (directory-files-depth-iter) "./directory-files-depth-iter.scm"

%for (COMPILER "guile")

(use-modules (ice-9 ftw))

(define directory-files
  (case-lambda
    ((directory) (directory-files directory #f))
    ((directory include-directories?)
     (define iter
       (directory-files-depth-iter include-directories? 1 directory))

     (let loop ((buf '()))
       (define x (iter))
       (if x
           (let ((full (car x))
                 (name (cadr x)))
             (loop (cons (list full name) buf)))
           buf)))))

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
