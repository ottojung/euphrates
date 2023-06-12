



(cond-expand
 (guile

  (define (open-file-port path mode)
    (if (member mode '("r" "w" "a" "rb" "wb" "ab"))
        (open-file path mode)
        (raisu 'open-file-mode-not-supported `(args: ,path ,mode))))

  )

 (racket

  (define (open-file-port path mode)
    (match mode
       ["r" (open-input-file path #:mode 'text)]
       ["w" (open-output-file path #:mode 'text #:exists 'truncate/replace)]
       ["a" (open-output-file path #:mode 'text #:exists 'append)]
       ["rb" (open-input-file path #:mode 'binary)]
       ["wb" (open-output-file path #:mode 'binary #:exists 'truncate/replace)]
       ["ab" (open-output-file path #:mode 'binary #:exists 'append)]
       [other (raisu 'open-file-mode-not-supported `(args: ,path ,mode))]))

  ))
