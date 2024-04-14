;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



(define (list-tag/next/rev first-tag predicate L)
  (let loop ((rest L) (buf '()) (next '()) (cur first-tag))
    (cond
     ((null? rest)
      (cons (cons cur (reverse next)) buf))
     ((predicate (car rest))
      (loop (cdr rest) ;; rest
            (if (and (null? buf) ;; first tag
                     (null? next))
                buf
                (cons (cons cur (reverse next)) buf)) ;; buf
            '() ;; next
            (car rest))) ;; cur
     (else
      (loop (cdr rest) ;; rest
            buf ;; buf
            (cons (car rest) next) ;; next
            cur)))))

;; Returns a list in following shape:
;; (cons ,tag ,next)
;; where ,tag is an element of ,L but ,next is a list
(define (list-tag/next first-tag predicate L)
  (reverse (list-tag/next/rev first-tag predicate L)))

(define (list-untag/next L)
  (cdr (apply append L))) ;; cdr because need to drop first-tag
