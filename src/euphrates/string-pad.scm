
(cond-expand
 (guile
  (define-module (euphrates string-pad)
    :export (string-pad-L string-pad-R)
    :use-module ((euphrates replicate) :select (replicate)))))



(define (string-pad-L str size pad-char)
  (let* ((len (string-length str)))
    (if (>= len size) str
        (list->string
         (append (replicate (- size len) pad-char)
                 (string->list str))))))

(define (string-pad-R str size pad-char)
  (let* ((len (string-length str)))
    (if (>= len size) str
        (list->string
         (append (string->list str)
                 (replicate (- size len) pad-char))))))

