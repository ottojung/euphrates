
%run guile

%var words

;; TODO: make single for guile + racket

%for (COMPILER "guile")

(define (words str)
  (filter
   (compose not string-null?)
   (string-split
    str
    (lambda (c)
      (case c
        ((#\newline #\space #\tab) #t)
        (else #f))))))

%end

%for (COMPILER "racket")

(define (words str)
  (string-split str))

%end

