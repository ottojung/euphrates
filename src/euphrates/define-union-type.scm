;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



(define (define-union-type:no-alternative-error object)
  (raisu* :from 'define-union-type
          :type 'no-alternative
          :message "Object does not satisfy any of the alternatives."
          :args (list object)))


(define-syntax define-union-type/helper3
  (syntax-rules ()
    ((_ (name object cond-buffer) match-buffer)
     (define-syntax name
       (syntax-rules ()
         ((_ var . match-buffer)
          ((lambda (object)
             (cond . cond-buffer)) var))

         ((_ . rest)
          (syntax-error "Invalid alternatives in case of define-union-type."
                        name match-buffer)))))))


(define-syntax define-union-type/helper2
  (syntax-rules ()
    ((_ (name object match-buffer) cond-buffer)
     (syntax-reverse
      (define-union-type/helper3 (name object cond-buffer))
      match-buffer))))


(define-syntax define-union-type/helper1
  (syntax-rules ()
    ((_ object name all-alternatives match-buffer cond-buffer ())
     (syntax-reverse
      (define-union-type/helper2 (name object match-buffer))

      ((else (define-union-type:no-alternative-error object))
       . cond-buffer)))

    ((_ object name all-alternatives match-buffer cond-buffer (first-alternative . rest-alternatives))
     (define-union-type/helper1
       object name all-alternatives
       ((first-alternative . bodies) . match-buffer)
       (((first-alternative object) (let () . bodies)) . cond-buffer)
       rest-alternatives))))


(define-syntax define-union-type
  (syntax-rules (:predicate :case :alternatives)
    ((_ :predicate predicate
        :case case
        :alternatives . alternatives)

     (begin
       (define predicate
         (compose-under or . alternatives))

       (define-union-type/helper1 object case alternatives () () alternatives)))))
