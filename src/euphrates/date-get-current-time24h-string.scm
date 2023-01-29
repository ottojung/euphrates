
%run guile

%var date-get-current-time24h-string

%use (date-get-current-string) "./date-get-current-string.scm"

(define (date-get-current-time24h-string)
  (date-get-current-string "~H:~M:~S"))
