;;;; Copyright (C) 2020, 2021, 2022, 2023  Otto Jung
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




(define-type9 <profun-database>
  (profun-database-constructor rules handler table falsy?) profun-database?
  (rules profun-database-rules)
  (handler profun-database-handler)
  (table profun-database-table) ;; hashed version of `rules`
  (falsy? profun-database-falsy?) ;; if true, predicates not mentioned in table or handler will be represented by relations, instead of returning an IDR.
  )

(define (make-profun-database/generic falsy? botom-handler lst-of-rules)
  (define ret (profun-database-constructor lst-of-rules botom-handler (make-hashmap) falsy?))
  (for-each (lambda (rule) (profun-database-add-rule! ret rule)) lst-of-rules)
  ret)

(define (make-profun-database botom-handler lst-of-rules)
  (make-profun-database/generic #f botom-handler lst-of-rules))

(define (make-falsy-profun-database botom-handler lst-of-rules)
  (make-profun-database/generic #t botom-handler lst-of-rules))

(define (profun-database-copy db)
  (profun-database-constructor
   (profun-database-rules db)
   (profun-database-handler db)
   (hashmap-copy (profun-database-table db))
   (profun-database-falsy? db)))

(define (profun-database-extend db0 rules)
  (define db (profun-database-copy db0))
  (for-each (lambda (rule) (profun-database-add-rule! db rule)) rules)
  db)

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
  (define handler (profun-database-handler db))
  (define function (profun-handler-get handler key arity))
  (and function (profun-rule-constructor key 0 (list) function)))

(define (double-hashmap-ref H key1 key2)
  (hashmap-ref H (cons key1 key2) #f))

(define (double-hashmap-set! H key1 key2 value)
  (hashmap-set! H (cons key1 key2) value))

(define (profun-database-get-all db key arity)
  (define table (profun-database-table db))
  (double-hashmap-ref table key arity))

(define (profun-database-get db k v arity)
  (define (get db key index arity)
    (let ((r (double-hashmap-ref (profun-database-table db) key arity)))
      (and r (list-ref-or r index #f))))

  (get db k (or v 0) arity))

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
