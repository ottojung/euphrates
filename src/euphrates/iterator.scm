;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-type9 <iterator>
  (iterator:construct
   iterator:generator
   iterator:done?
   )

  iterator?

  (generator iterator:generator iterator:generator-set!)
  (done? iterator:done? iterator:done?-set!)
  )


(define (iterator:make generator)
  (define done? #f)
  (iterator:construct generator done?))


(define-syntax iterator:next
  (syntax-rules ()
    ((_ iterator default)
     (let ()
       (define iterator* iterator)
       (define generator
         (iterator:generator iterator*))
       (define done?
         (iterator:done? iterator*))

       (if done?
           default
           (let ()
             (define-values (obj new-done?) (generator))
             (if new-done?
                 (begin
                   (iterator:generator-set! iterator (lambda _ (values #t #t)))
                   (iterator:done?-set! iterator #t)
                   default)
                 obj)))))))
