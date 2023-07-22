
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates assq-set-value-star)
           assq-set-value*))
   (import
     (only (scheme base) begin cond-expand quote))))

(assert= '((xxx . 2))
         (assq-set-value* '(xxx) 2 '((xxx . 5))))

(assert= '((xxx . 2) (yyy . 7) (zzz . 11))
         (assq-set-value* '(xxx) 2 '((xxx . 5) (yyy . 7) (zzz . 11))))

(assert= '((xxx . 5) (yyy . 2) (zzz . 11))
         (assq-set-value* '(yyy) 2 '((xxx . 5) (yyy . 7) (zzz . 11))))

(assert= '((xxx . 5) (yyy . 7) (zzz . 11) (mmm . 2))
         (assq-set-value* '(mmm) 2 '((xxx . 5) (yyy . 7) (zzz . 11))))

(assert= '((xxx . 5) (yyy (iii . 2)) (zzz . 11))
         (assq-set-value* '(yyy iii) 2 '((xxx . 5) (yyy . 7) (zzz . 11))))

(assert= '((xxx . 5) (yyy (iii (ooo . 2))) (zzz . 11))
         (assq-set-value* '(yyy iii ooo) 2 '((xxx . 5) (yyy . 7) (zzz . 11))))

(assert= 2
         (assq-set-value* '() 2 '((xxx . 5) (yyy . 7) (zzz . 11))))
