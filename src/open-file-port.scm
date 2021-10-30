
%run guile

%var open-file-port

%use (raisu) "./raisu.scm"

%for (COMPILER "guile")

(define (open-file-port path mode)
  (match mode
    ["r" (open-file path mode)]
    ["w" (open-file path mode)]
    ["a" (open-file path mode)]
    ["rb" (open-file path mode)]
    ["wb" (open-file path mode)]
    ["ab" (open-file path mode)]
    [other (raisu 'open-file-mode-not-supported `(args: ,path ,mode))]))

%end
%for (COMPILER "racket")

(define (open-file-port path mode)
  (match mode
    ["r" (open-input-file path #:mode 'text)]
    ["w" (open-output-file path #:mode 'text #:exists 'truncate/replace)]
    ["a" (open-output-file path #:mode 'text #:exists 'append)]
    ["rb" (open-input-file path #:mode 'binary)]
    ["wb" (open-output-file path #:mode 'binary #:exists 'truncate/replace)]
    ["ab" (open-output-file path #:mode 'binary #:exists 'append)]
    [other (raisu 'open-file-mode-not-supported `(args: ,path ,mode))]))

%end
