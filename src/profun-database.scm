;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
;;;;
;;;; This program is free software; you can redistribute it and/or modify
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

%var profun-database-copy
%var profun-database?
%var profun-database-table
%var profun-database-handler
%var profun-database-handle
%var profun-database-add!
%var profun-database-get
%var make-profun-database
%var profun-database-add-rule!

%use (define-type9) "./define-type9.scm"
%use (hashmap-copy hashmap-ref hashmap-set! make-hashmap) "./hashmap.scm"
%use (list-ref-or) "./list-ref-or.scm"
%use (profun-rule-constructor) "./profun-rule.scm"
%use (profun-varname?) "./profun-varname-q.scm"
%use (make-usymbol) "./usymbol.scm"

(define-type9 <profun-database>
  (profun-database-constructor table handler) profun-database?
  (table profun-database-table)
  (handler profun-database-handler)
  )

(define (make-profun-database botom-handler)
  (profun-database-constructor (make-hashmap) botom-handler))

(define (profun-database-copy db)
  (profun-database-constructor
   (hashmap-copy (profun-database-table db))
   (profun-database-handler db)))

(define (profun-database-add-rule! db r)
  (define first (car r))
  (define name (car first))
  (define args-init (cdr first))
  (define body-init (cdr r))

  (define (ret args body-app)
    (let ((body (append body-app body-init)))
      (profun-database-add! db name args body)))

  (let lp ((buf args-init)
           (i 0)
           (aret (list))
           (bret-app (list)))
    (if (null? buf)
        (ret (reverse aret) (reverse bret-app))
        (let ((x (car buf)))
          (if (not (profun-varname? x))
              (let ((u (make-usymbol name `(arg ,i))))
                (lp (cdr buf)
                    (+ i 1)
                    (cons u aret)
                    (cons `(= ,u ,x) bret-app))) ;; NOTE: relies on =/2 to be provided by handler
              (lp (cdr buf)
                  (+ i 1)
                  (cons x aret)
                  bret-app))))))

(define (profun-database-handle db key arity)
  (let ((function ((profun-database-handler db) key arity)))
    (and function (profun-rule-constructor key 0 (list) function))))

(define (double-hashmap-ref H key1 key2)
  (define h (hashmap-ref H key1 #f))
  (and h (hashmap-ref h key2 #f)))

(define (double-hashmap-set! H key1 key2 value)
  (define h0 (hashmap-ref H key1 #f))
  (define h
    (or h0 (begin (let ((h (make-hashmap)))
                    (hashmap-set! H key1 h) h))))
  (hashmap-set! h key2 value))

(define (profun-database-get db k arity)
  (define (get db key index arity)
    (let ((r (double-hashmap-ref (profun-database-table db) key arity)))
      (and r (list-ref-or r index #f))))

  (if (pair? k)
      (get db (car k) (cdr k) arity)
      (get db k 0 arity)))

(define (profun-database-add! db name args body)
  (let* ((arity (length args))
         (table (profun-database-table db))
         (existing (or (double-hashmap-ref table name arity) '()))
         (index (length existing))
         (value (profun-rule-constructor name index args body)))

    (double-hashmap-set!
     (profun-database-table db)
     name arity
     (append existing (list value)))))
