
(cond-expand
 (guile
  (define-module (euphrates base64-alphabet)
    :export (base64/alphabet))))


;; Specified by RFC 1421, 2045, 2152, 4648 $4, 4880
(define base64/alphabet
  #(#\A #\B #\C #\D #\E #\F #\G #\H
    #\I #\J #\K #\L #\M #\N #\O #\P
    #\Q #\R #\S #\T #\U #\V #\W #\X
    #\Y #\Z #\a #\b #\c #\d #\e #\f
    #\g #\h #\i #\j #\k #\l #\m #\n
    #\o #\p #\q #\r #\s #\t #\u #\v
    #\w #\x #\y #\z #\0 #\1 #\2 #\3
    #\4 #\5 #\6 #\7 #\8 #\9 #\+ #\/))
