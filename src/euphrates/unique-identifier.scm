;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-type9 uid
  (uid:constructor id)
  unique-identifier?

  (id unique-identifier:id) ;; must not be exported.
  )


(define make-unique-identifier
  (let ((counter 0))
    (lambda _
      (set! counter (+ counter 1))
      (uid:constructor counter))))


(define unique-identifier:deserialize/p
  (make-parameter #f))


(define (add-additional H additional)
  (cond
   ((and (pair? additional)
         (list? additional))

    (for-each
     (lambda (x)
       (hashmap-set! H (~a x) 'taken))
     additional))

   ((hashset? additional)

    (hashset-foreach
     (lambda (x)
       (hashmap-set! H (~a x) 'taken))
     additional))

   (else
    (unless (list? additional)
      (raisu* :from "unique-identifier"
              :type 'bad-type-of-taken-names-list
              :message (stringf "The value of ~s must be either a ~s or a ~s"
                                (~a (quote :existing-names))
                                (~a (quote list?))
                                (~a (quote hashset?)))
              :args (list additional))))))


(define-syntax with-unique-identifier-context/helper
  (syntax-rules ()
    ((_ additional . bodies)
     (let ((H (make-hashmap)))
       (parameterize ((unique-identifier:deserialize/p (vector 0 H)))
         (add-additional H additional)
         (let () . bodies))))))


(define-syntax with-unique-identifier-context
  (syntax-rules (:existing-names)
    ((_ :existing-names additional . bodies)
     (with-unique-identifier-context/helper additional . bodies))

    ((_ . bodies)
     (with-unique-identifier-context/helper '() . bodies))))


(define (unique-identifier->string uid)
  (define p (unique-identifier:deserialize/p))
  (unless p
    (raisu* :from "unique-identifier"
            :type 'must-begin-serialization-first
            :message (stringf "This function can only be executed inside ~s block"
                              (~a (quote with-unique-identifier-context)))
            :args (list uid)))

  (define last-free (vector-ref p 0))
  (define H (vector-ref p 1))

  (define (tostr id)
    (string-append
     "uid_" (number->string id)))

  (define id (unique-identifier:id uid))

  (define (try! count)
    (define str (tostr count))
    (define current (hashmap-ref H str #f))
    (if current #f
        (let ()
          (hashmap-set! H id str)
          (vector-set! p 0 count)
          str)))

  (or (hashmap-ref H id #f)
      (let loop ((count (+ 1 last-free)))
        (or (try! count)
            (loop (+ 1 count))))))
