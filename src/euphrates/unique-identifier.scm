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


(define-syntax with-unique-identifier-context
  (syntax-rules ()
    ((_ . bodies)
     (parameterize ((unique-identifier:deserialize/p (make-hashmap)))
       (let () . bodies)))))


(define (unique-identifier->list uid)
  (define p (unique-identifier:deserialize/p))
  (unless p
    (raisu* :from "unique-identifier"
            :type 'must-begin-serialization-first
            :message (stringf "This function can only be executed inside ~s block"
                              (~a (quote with-unique-identifier-context)))
            :args (list uid)))

  (let ()
    (define id (unique-identifier:id uid))
    (define current (hashmap-ref p id #f))

    (if current
        (list 'uid current)
        (let ()
          (define new-current (+ 1 (hashmap-count p)))
          (hashmap-set! p id new-current)
          (list 'uid new-current)))))
