
%run guile

%var string-pad-left
%var string-pad-right
%var string-pad

%use (replicate) "./replicate.scm"

(define (string-pad-left str size pad-char)
  (let* ((len (string-length str)))
    (if (>= len size) str
        (list->string
         (append (replicate (- size len) pad-char)
                 (string->list str))))))

(define (string-pad-right str size pad-char)
  (let* ((len (string-length str)))
    (if (>= len size) str
        (list->string
         (append (string->list str)
                 (replicate (- size len) pad-char))))))

(define string-pad string-pad-left)

