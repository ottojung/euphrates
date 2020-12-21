
%run guile

%var big-random-int

%for (COMPILER "guile")

(define big-random-int
  (let ((initialized? #f))
    (lambda (max)
      (unless initialized?
        ;; NOTE: in guile, random is deterministic by default
        ;; while rackets is non-deterministic by default
        ;; It would be ok if they both were deterministic,
        ;; but it is easier to change guile, so there it is.
        ;; TODO: deterministic random at will
        (set! initialized? #t)
        (set! *random-state* (random-state-from-platform)))
      (random max))))

%end

%for (COMPILER "racket")

(define [big-random-int max]
  (exact-floor (* (random) max))) ;; random in racket is bounded to 4294967087

%end
