;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; FIXME: reverse alternatives.
(define-syntax define-union-type/helper1
  (syntax-rules ()
    ((_ object name all-alternatives match-buffer cond-buffer ())
     (define-syntax name
       (syntax-rules all-alternatives
         ((_ var . match-buffer)
          ((lambda (object)
             (cond . cond-buffer)) var)) ;; FIXME: add else condition.
         ((_ . rest)
          (syntax-error "Invalid alternatives in case of define-union-type."
                        name all-alternatives)))))

    ((_ object name all-alternatives match-buffer cond-buffer (first-alternative . rest-alternatives))
     (define-union-type/helper1
       object name all-alternatives
       ((first-alternative . bodies) . match-buffer)
       (((first-alternative object) . bodies) . cond-buffer)
       rest-alternatives))))


(define-syntax define-union-type
  (syntax-rules (:predicate :case :alternatives)
    ((_ :predicate predicate
        :case case
        :alternatives . alternatives)

     ;; (begin
     ;;   (define predicate
     ;;     (compose-under or . alternatives))

     (define-union-type/helper1 object case alternatives () () alternatives))))

