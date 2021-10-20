
%run guile

%var monadic-parameterize
%var with-monadic-left
%var with-monadic-right

%use (monadic-global/p) "./monadic-global-p.scm"

(define-syntax monadic-parameterize
  (syntax-rules ()
    ((_ f . body)
     (parameterize ((monadic-global/p f))
       (begin . body)))))

(define-syntax with-monadic-left
  (syntax-rules ()
    ((_ f . body)
     (let ((current-monad (monadic-global/p)))
       (let ((new-monad
              (lambda (old-monad old-monad-quoted)
                (let ((applied (if current-monad
                                   (current-monad old-monad old-monad-quoted)
                                   old-monad)))
                  (compose f applied)))))
         (parameterize ((monadic-global/p new-monad))
           (begin . body)))))))

(define-syntax with-monadic-right
  (syntax-rules ()
    ((_ f . body)
     (let ((current-monad (monadic-global/p)))
       (let ((new-monad
              (lambda (old-monad old-monad-quoted)
                (let ((applied (if current-monad
                                   (current-monad old-monad old-monad-quoted)
                                   old-monad)))
                  (compose applied f)))))
         (parameterize ((monadic-global/p new-monad))
           (begin . body)))))))
