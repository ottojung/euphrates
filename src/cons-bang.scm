
%run guile

%var cons!

(define-syntax cons!
  (syntax-rules ()
    ((_ head tail)
     (set! tail (cons head tail)))))
