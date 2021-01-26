
%run guile

%var command-line-argumets/p

;; access with (get-command-line-arguments)
(define command-line-argumets/p
  (make-parameter #f))
