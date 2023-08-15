;;;; Copyright (C) 2022, 2023  Otto Jung
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

;; Works only with `generic-error'.

(define-syntax catchu-case-single
  (syntax-rules (else)
    ((_ invokebody ((else . args) . bodies))
     (catch-any
      (lambda _ invokebody)
      (lambda args . bodies)))
    ((_ invokebody ((symbolic-error-key . args) . bodies))
     (catch-specific
      symbolic-error-key
      (lambda _ invokebody)
      (lambda (err)
        (define args-all
          (generic-error:value/unsafe
           err generic-error:irritants-key '()))
        (apply (lambda args . bodies)
               args-all))))))

(define-syntax catchu-case
  (syntax-rules ()
    ((_ invokebody case1)
     (catchu-case-single invokebody case1))
    ((_ invokebody case1 . cases-rest)
     (catchu-case-single
      (catchu-case invokebody . cases-rest)
      case1))))
