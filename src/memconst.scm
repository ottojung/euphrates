
%run guile

%var memconst

; memoized constant function
(define-syntax-rule (memconst x)
  (let ((memory #f)
        (evaled? #f))
    (lambda argv
      (unless evaled?
        (set! evaled? #t)
        (set! memory x))
      memory)))

