
(cond-expand
 (guile
  (define-module (euphrates alpha-alphabet)
    :export (alpha/alphabet))))


;; starts off like base64 table
(define alpha/alphabet
  #(#\A #\B #\C #\D #\E #\F #\G #\H
    #\I #\J #\K #\L #\M #\N #\O #\P
    #\Q #\R #\S #\T #\U #\V #\W #\X
    #\Y #\Z #\a #\b #\c #\d #\e #\f
    #\g #\h #\i #\j #\k #\l #\m #\n
    #\o #\p #\q #\r #\s #\t #\u #\v
    #\w #\x #\y #\z))

