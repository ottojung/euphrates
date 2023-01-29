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

%var make-immutable-hashmap
%var immutable-hashmap?
%var immutable-hashmap-fromlist
%var immutable-hashmap->alist
%var immutable-hashmap-copy
%var immutable-hashmap-foreach
%var immutable-hashmap-map
%var alist->immutable-hashmap
%var immutable-hashmap-ref
%var immutable-hashmap-ref/first
%var immutable-hashmap-set
%var immutable-hashmap-clear
%var immutable-hashmap-count

%use (assoc/any) "./assoc-any.scm"
%use (fn) "./fn.scm"
%use (immutable-hashmap-constructor immutable-hashmap-predicate immutable-hashmap-value) "./immutable-hashmap-obj.scm"

(define immutable-hashmap? immutable-hashmap-predicate)

(define (make-immutable-hashmap)
  (immutable-hashmap-constructor '()))

(define (immutable-hashmap-fromlist lst)
  (immutable-hashmap-constructor lst))

(define (alist->immutable-hashmap L)
  (immutable-hashmap-fromlist L))
(define (immutable-hashmap->alist T)
  (define H (immutable-hashmap-value T))
  H)
(define (immutable-hashmap-copy T)
  (alist->immutable-hashmap (immutable-hashmap->alist T)))

(define (immutable-hashmap-ref T k default)
  (define H (immutable-hashmap-value T))
  (define ret (assoc k H))
  (if ret (cdr ret) default))

(define (immutable-hashmap-ref/first T keys default)
  (define H (immutable-hashmap-value T))
  (define ret (assoc/any keys H))
  (or ret default))

(define (immutable-hashmap-set T k v)
  (define H0 (immutable-hashmap-value T))
  (immutable-hashmap-fromlist
   (let loop ((H H0) (buf '()))
     (if (null? H)
         (cons (cons k v) H0)
         (let ((x (car H)))
           (if (equal? k (car x))
               (cons (cons k v) (append (reverse buf) (cdr H)))
               (loop (cdr H) (cons x buf))))))))

(define (immutable-hashmap-clear T)
  (make-immutable-hashmap))

(define (immutable-hashmap-foreach fn T)
  (define H (immutable-hashmap-value T))
  (for-each (lambda (p) (fn (car p) (cdr p))) H))

(define (immutable-hashmap-count T)
  (define H (immutable-hashmap-value T))
  (length H))

(define (immutable-hashmap-map fn T)
  (define H (immutable-hashmap-value T))
  (immutable-hashmap-fromlist
   (map
    (lambda (p)
      (define key (car p))
      (define value (cdr p))
      (define result (fn key value))
      (cons key result))
    H)))

