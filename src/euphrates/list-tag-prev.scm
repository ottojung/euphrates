;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



(define (list-tag/prev/rev last-tag predicate L)
  (let loop ((rest L) (buf '()) (prev '()) (cur #f))
    (cond
     ((null? rest)
      (cons (cons last-tag prev) buf))
     ((predicate (car rest))
      (loop (cdr rest) ;; rest
            (cons (cons (car rest) prev) buf) ;; buf
            '() ;; prev
            #f)) ;; cur
     (else
      (loop (cdr rest) ;; rest
            buf ;; buf
            (cons (car rest) prev) ;; prev
            cur)))))

;; Returns a list in following shape:
;; (cons ,tag ,prev)
;; where ,tag is an element of ,L but ,prev is a list
;; NOTE: ,prev is reversed!
(define (list-tag/prev last-tag predicate L)
  (reverse (list-tag/prev/rev last-tag predicate L)))
