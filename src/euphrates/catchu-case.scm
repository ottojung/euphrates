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

(cond-expand
 (guile
  (define-module (euphrates catchu-case)
    :export (catchu-case))))

;; Use together with `raisu'.
;; Note that there is no "else" case (because that does not seem to be very portable).


(cond-expand
 (guile

  (define-syntax catchu-case-single
    (syntax-rules ()
      ((_ invokebody ((symbolic-error-key . args) . bodies))
       (catch
    symbolic-error-key
    (lambda _ invokebody)
    (lambda args-all
          (apply (lambda args . bodies)
         (cdr args-all)))))))

  (define-syntax catchu-case
    (syntax-rules ()
      ((_ invokebody case1)
       (catchu-case-single invokebody case1))
      ((_ invokebody case1 . cases-rest)
       (catchu-case-single
    (catchu-case invokebody . cases-rest)
    case1))))

  ))
