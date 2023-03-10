
(cond-expand
 (guile
  (define-module (euphrates append-posix-path)
    :export (append-posix-path)
    :use-module ((euphrates absolute-posix-path-q) :select (absolute-posix-path?))
    :use-module ((euphrates remove-common-prefix) :select (remove-common-prefix))
    :use-module ((euphrates raisu) :select (raisu)))))



(define [append-posix-path2 a b]
  (if (= (string-length a) 0)
      b
      (let ((b
             (if (absolute-posix-path? b)
                 (let ((cl (remove-common-prefix b a)))
                   (if (equal? cl b)
                       (raisu 'append-posix-path-disjoint `(args: ,a ,b))
                       cl))
                 b)))
        (if (char=? #\/ (string-ref a (1- (string-length a))))
            (string-append a b)
            (string-append a "/" b)))))

(define [append-posix-path . paths]
  (if (null? paths) "/"
      (let loop ((paths paths))
        (if (null? (cdr paths)) (car paths)
            (append-posix-path2 (car paths) (loop (cdr paths)))))))

