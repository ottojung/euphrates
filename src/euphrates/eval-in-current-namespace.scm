
%run guile

%var eval-in-current-namespace

%for (COMPILER "guile")

(define (eval-in-current-namespace body)
  (eval body (interaction-environment)))

%end

%for (COMPILER "racket")

(define (eval-in-current-namespace body)
  (eval body))

%end
