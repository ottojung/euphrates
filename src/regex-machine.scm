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

%run guile

%use (hashmap hashmap?) "./hashmap.scm"
%use (hashmap->alist hashmap-ref hashmap-set! hashmap-clear! hashmap-foreach hashmap-copy) "./ihashmap.scm"

%var make-regex-machine

(define (match-kleene-star hash pattern cont buf)
  (let loop ((buf buf))
    (if (null? buf) (cont buf)
        (match1 hash
                (car pattern)
                (lambda (ret)
                  (if ret
                      (or (cont ret)
                          (loop ret))
                      (cont buf)))
                buf))))

(define (match-and-star hash pattern cont buf)
  (match-kleene-star hash (list (cons 'and pattern)) cont buf))

(define (match-and hash pattern cont buf)
  (let loop ((pattern pattern) (buf buf))
    (if (null? pattern) (cont buf)
        (match1 hash (car pattern)
                (lambda (ret)
                  (if ret
                      (loop (cdr pattern) ret)
                      (cont #f)))
                buf))))

(define (match-or hash pattern cont buf)
  (let loop ((pattern pattern))
    (if (null? pattern) (cont #f)
        (match1 hash (car pattern)
                (lambda (ret)
                  (if ret
                      (or (cont ret)
                          (loop (cdr pattern)))
                      (loop (cdr pattern))))
                buf))))

(define (match-any hash pattern cont buf)
  (cont
   (and (not (null? buf))
        (begin
          (for-each
           (lambda (name)
             (hashmap-set! hash name (car buf)))
           pattern)
          (cdr buf)))))

(define (match-any* hash pattern cont buf)
  (cont
   (and (not (null? buf))
        (begin
          (for-each
           (lambda (name)
             (hashmap-set! hash name
                           (cons (car buf)
                                 (hashmap-ref hash name (list)))))
           pattern)
          (cdr buf)))))

(define (match-equal hash pattern cont buf)
  (cont
   (and (not (null? buf))
        (not (null? pattern))
        (equal? (car pattern) (car buf))
        (begin
          (for-each
           (lambda (name)
             (hashmap-set! hash name (car buf)))
           (cdr pattern))
          (cdr buf)))))

(define (match1 hash pattern cont buf)
  (define (go func)
    (func hash (cdr pattern) cont buf))
  (case (car pattern)
    ((=) (go match-equal))
    ((any) (go match-any))
    ((any*) (go match-any*))
    ((and) (go match-and))
    ((or) (go match-or))
    ((*) (go match-kleene-star))
    ((and*) (go match-and-star))
    (else (go (car pattern)))))

(define (make-regex-machine pattern)
  (lambda (H T)
    (match1 H pattern null? T)))



