;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




;; returns a list in following shape:
;; (cons ,tag (cons ,prev ,next))
;; where ,tag is an element of ,L but ,prev and ,next are lists
;; NOTE: ,prev is reversed!
;; NOTE: returns #f if predicate did not match!
(define (list-tag predicate L)
  (if (null? L) #f
      (let* ((prevs (list-tag/prev/rev #f predicate L))
             (last-prevs (cdr (car prevs))))

        (let loop ((rest (cdr prevs)) (pp last-prevs) (buf '()))
          (if (null? rest)
              (and (not (null? buf)) buf)
              (let* ((x (car rest))
                     (tag (car x))
                     (prev (cdr x))
                     (full (cons tag (cons prev (reverse pp)))))
                (loop (cdr rest) ;; rest
                      prev ;; pp
                      (cons full buf)))))))) ;; buf


(define (list-untag L)
  (append
   (reverse (cadr (car L)))
   (let loop ((L L))
     (if (null? L) '()
         (cons (car (car L))
               (append (cddr (car L)) (loop (cdr L))))))))
