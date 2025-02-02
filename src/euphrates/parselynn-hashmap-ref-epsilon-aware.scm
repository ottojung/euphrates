;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; Handles things like FIRST(A B C).
;; Note that normally, it only makes sense to ask for FIRST(A),
;; FIRST(B), FIRST(C).
;; But this function extends the notation.
;;
;; Also, for all terminals `t`, this function returns FIRST(t) = { t }.
;;
;; Implementation-wise, it basically concatenates all FIRST sets
;; that contain an epsilon, halting on the left-most one that doesn't.
;;
(define (parselynn:hashmap-ref/epsilon-aware terminals nonterminals H symbols)
  (define ret
    (make-hashset))
  (define empty
    (make-hashset))

  (define got-epsilon? #f)
  (define (yield! x)
    (when (equal? x parselynn:epsilon)
      (set! got-epsilon? #t))
    (hashset-add! ret x))

  (define (terminal? X)
    (hashset-has? terminals X))
  (define (nonterminal? X)
    (hashset-has? nonterminals X))

  (define (get-first this)
    (cond
     ((terminal? this)
      (yield! this))
     ((equal? parselynn:end-of-input this)
      (yield! this))
     ((nonterminal? this)
      (let ()
        (define this-set
          (hashmap-ref H this empty))
        (hashset-foreach yield! this-set)))
     ((hashset? this)
      (hashset-foreach get-first this))
     (else
      (raisu-fmt
       'bad-type-of-thing-631687123612537123
       "Expected a terminal, a nonterminal, or a hashset of those, but got %s."
       this))))

  (define (fun symbol)
    (get-first (car symbols))
    (not got-epsilon?))

  (list-find-first fun symbols)

  ret)
