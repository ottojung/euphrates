
(assert=
 '(1 3 5 6 7 8)
 (euphrates:list-sort
  '(3 6 5 1 7 8)
  (lambda (a b) (< a b))))

(assert=
 '(1 1 3 5 5 5 5 5 6 7 7 8 9)
 (euphrates:list-sort
  '(3 6 5 1 7 8 1 5 5 5 5 7 9)
  (lambda (a b) (< a b))))

(assert=
 '(6 8 3 5 1 7 1 5 5 5 5 7 9)
 (euphrates:list-sort
  '(3 6 5 1 7 8 1 5 5 5 5 7 9)
  (lambda (a b) (< (modulo a 2) (modulo b 2)))))
