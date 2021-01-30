
%run guile

%var raisu

;; One-way exceptions (non-recoverable / not continuable)

%for (COMPILER "guile")

(define (raisu x . xs)
  (apply throw (cons x xs)))

%end
%for (COMPILER "racket")

(define (raisu x . xs)
  (raise (cons x xs)))

%end
