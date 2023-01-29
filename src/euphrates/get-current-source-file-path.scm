
%run guile

%var get-current-source-file-path

%for (COMPILER "guile")

(define-syntax-rule [get-current-source-file-path]
  (cdr
   (assq
    'filename
    (current-source-location))))

%end

%for (COMPILER "racket")

(define-macro (get-current-source-file-path)
  '(path->string
    (build-path
     (this-expression-source-directory)
     (this-expression-file-name))))

%end

