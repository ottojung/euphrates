;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-type9 <iterator>
  (iterator:construct
   iterator:generator
   iterator:done?
   iterator:on-done     ;; A generic finalizer that is called after this iterator is no longer needed.
   )

  iterator?

  (generator iterator:generator iterator:generator-set!)
  (done? iterator:done? iterator:done?-set!)
  (on-done iterator:on-done iterator:on-done-set!)
  )


(define (iterator:make generator on-done)
  (define done? #f)

  (unless (procedure? generator)
    (raisu* :from "iterator"
            :type 'generator-must-be-a-procedure
            :message "Generator must be a procedure."
            :args (list generator)))

  (unless (or (equal? #f on-done) (procedure? on-done))
    (raisu* :from "iterator"
            :type 'on-done-must-be-a-procedure
            :message "The on-done callback must be a procedure or false."
            :args (list on-done)))

  (iterator:construct generator done? on-done))


(define-syntax iterator:next
  (syntax-rules ()
    ((_ iterator default)
     (let ()
       (define iterator* iterator)
       (define done? (iterator:done? iterator*))

       (if done?
           default
           (let ()
             (define generator (iterator:generator iterator*))
             (define-values (obj new-done?) (generator))
             (if new-done?
                 (begin
                   (iterator:close/unsafe iterator)
                   default)
                 obj)))))))


(define (iterator:close/unsafe iterator)
  (define on-done (iterator:on-done iterator))
  (iterator:done?-set! iterator #t)
  (iterator:generator-set! iterator (lambda _ (values #t #t)))
  (iterator:on-done-set! iterator #f)
  (when on-done
    (on-done)))


(define (iterator:close iterator)
  (unless (iterator:done? iterator)
    (iterator:close/unsafe iterator)
    (when #f #f)))
