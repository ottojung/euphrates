;;;; Copyright (C) 2022  Otto Jung
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

%var make-prefixtree
%var prefixtree-set!
%var prefixtree-ref
%var prefixtree-ref-closest
%var prefixtree-ref-furthest
%var prefixtree->tree

%use (prefixtree prefixtree? prefixtree-value set-prefixtree-value! prefixtree-children set-prefixtree-children!) "./prefixtree-obj.scm"
%use (list-find-first) "./list-find-first.scm"

(define prefixtree-novalue (vector 'novalue))

(define (make-prefixtree value)
  (prefixtree value '()))

(define (prefixtree-set! this key-sequence value)
  (let loop ((this this) (key-sequence key-sequence))
    (if (null? key-sequence)
        (set-prefixtree-value! this value)
        (let* ((key (car key-sequence))
               (children (prefixtree-children this))
               (existing (list-find-first
                          (lambda (child-pair)
                            (define child-key (car child-pair))
                            (equal? key child-key))
                          #f children)))
          (if existing
              (loop (cdr existing) (cdr key-sequence))
              (let ((new (make-prefixtree prefixtree-novalue)))
                (set-prefixtree-children! this (cons (cons key new) children))
                (loop new (cdr key-sequence))))))))

(define (prefixtree-ref this key-sequence default)
  (let loop ((this this) (key-sequence key-sequence))
    (if (null? key-sequence)
        (let ((value (prefixtree-value this)))
          (if (eq? value prefixtree-novalue) default value))
        (let* ((key (car key-sequence))
               (children (prefixtree-children this))
               (existing (list-find-first
                          (lambda (child-pair)
                            (define child-key (car child-pair))
                            (equal? key child-key))
                          #f children)))
          (if existing
              (loop (cdr existing) (cdr key-sequence))
              default)))))

(define (prefixtree-ref-closest this key-sequence)
  (let loop ((this this) (key-sequence key-sequence))
    (if (null? key-sequence)
        (let ((value (prefixtree-value this)))
          (if (eq? value prefixtree-novalue) '() (list value)))
        (let* ((key (car key-sequence))
               (children (prefixtree-children this))
               (existing (list-find-first
                          (lambda (child-pair)
                            (define child-key (car child-pair))
                            (equal? key child-key))
                          #f children)))
          (if existing
              (loop (cdr existing) (cdr key-sequence))
              (apply
               append
               (map (lambda (child) (loop (cdr child) key-sequence))
                    children)))))))

(define (prefixtree-ref-furthest this key-sequence)
  (let loop ((this this) (key-sequence key-sequence))
    (if (null? key-sequence)
        (prefixtree-value this)
        (let* ((key (car key-sequence))
               (children (prefixtree-children this))
               (existing (list-find-first
                          (lambda (child-pair)
                            (define child-key (car child-pair))
                            (equal? key child-key))
                          #f children)))
          (if existing
              (let ((rec (loop (cdr existing) (cdr key-sequence))))
                (if (eq? rec prefixtree-novalue)
                    (prefixtree-value this)
                    rec))
              (prefixtree-value this))))))

(define (prefixtree->tree this)
  (let loop ((this this))
    (define value0 (prefixtree-value this))
    (define value (if (eq? value0 prefixtree-novalue) '? value0))
    (cons value
          (map
           (lambda (child-pair)
             (let ((rec (loop (cdr child-pair))))
               (cons (cons (car child-pair)
                           (car rec))
                     (cdr rec))))
           (prefixtree-children this)))))

