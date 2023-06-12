;;;; Copyright (C) 2021  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.



;; Characters that will not make shell words split.

;; Does not starts off like base64 table!
(define shell-nondisrupt/alphabet
  #(#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9
    #\a #\b #\c #\d #\e #\f #\g #\h #\i #\j
    #\k #\l #\m #\n #\o #\p #\q #\r #\s #\t
    #\u #\v #\w #\x #\y #\z #\A #\B #\C #\D
    #\E #\F #\G #\H #\I #\J #\K #\L #\M #\N
    #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X
    #\Y #\Z #\+ #\- #\, #\_ #\: #\@ #\= #\%
    #\. #\/ #\* #\? #\^ #\\ #\~))

(define (shell-nondisrupt/alphabet/index c)
  (case c
    ((#\0) 0)
    ((#\1) 1)
    ((#\2) 2)
    ((#\3) 3)
    ((#\4) 4)
    ((#\5) 5)
    ((#\6) 6)
    ((#\7) 7)
    ((#\8) 8)
    ((#\9) 9)
    ((#\a) 10)
    ((#\b) 11)
    ((#\c) 12)
    ((#\d) 13)
    ((#\e) 14)
    ((#\f) 15)
    ((#\g) 16)
    ((#\h) 17)
    ((#\i) 18)
    ((#\j) 19)
    ((#\k) 20)
    ((#\l) 21)
    ((#\m) 22)
    ((#\n) 23)
    ((#\o) 24)
    ((#\p) 25)
    ((#\q) 26)
    ((#\r) 27)
    ((#\s) 28)
    ((#\t) 29)
    ((#\u) 30)
    ((#\v) 31)
    ((#\w) 32)
    ((#\x) 33)
    ((#\y) 34)
    ((#\z) 35)
    ((#\A) 36)
    ((#\B) 37)
    ((#\C) 38)
    ((#\D) 39)
    ((#\E) 40)
    ((#\F) 41)
    ((#\G) 42)
    ((#\H) 43)
    ((#\I) 44)
    ((#\J) 45)
    ((#\K) 46)
    ((#\L) 47)
    ((#\M) 48)
    ((#\N) 49)
    ((#\O) 50)
    ((#\P) 51)
    ((#\Q) 52)
    ((#\R) 53)
    ((#\S) 54)
    ((#\T) 55)
    ((#\U) 56)
    ((#\V) 57)
    ((#\W) 58)
    ((#\X) 59)
    ((#\Y) 60)
    ((#\Z) 61)
    ((#\+) 62)
    ((#\-) 63)
    ((#\,) 64)
    ((#\_) 65)
    ((#\:) 66)
    ((#\@) 67)
    ((#\=) 68)
    ((#\%) 69)
    ((#\.) 70)
    ((#\/) 71)
    ((#\*) 72)
    ((#\?) 73)
    ((#\^) 74)
    ((#\\) 75)
    ((#\~) 76)
    (else #f)))
