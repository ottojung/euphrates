
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates assq-or-star) assq-or*))
   (import
     (only (scheme base) begin cond-expand quote))))

(assert= 5 (assq-or* '(xxx) '((xxx . 5))))

(assert= 5 (assq-or* '(xxx) '((xxx . 5) (yyy . 7) (zzz . 11))))

(assert= 5 (assq-or* '(xxx) '((yyy . 7) (xxx . 5) (zzz . 11))))

(assert= #f (assq-or* '(mmm) '((yyy . 7) (xxx . 5) (zzz . 11))))

(assert= 13 (assq-or* '(mmm) '((yyy . 7) (xxx . 5) (zzz . 11)) 13))

(assert= 5 (assq-or* '(xxx iii) '((yyy . 7) (xxx (ooo . 17) (iii . 5) (ttt . 19)) (zzz . 11))))

(assert= 23 (assq-or* '(xxx mmm) '((yyy . 7) (xxx (ooo . 17) (iii . 5) (ttt . 19)) (zzz . 11)) 23))

(assert= #f (assq-or* '(xxx mmm) '((yyy . 7) (xxx (ooo . 17) (iii . 5) (ttt . 19)) (zzz . 11))))

(assert= '((yyy . 7)) (assq-or* '() '((yyy . 7))))
