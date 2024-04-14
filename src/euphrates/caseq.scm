;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Quoted version of (case symbol ((val1 val2 ...) bodies...)...)
;; But only one case is allowed! So it's like
;;  (caseq symbol
;;    ('a (fun-a))
;;    ('b (fun-b))
;;    (else (fun-else))

(define-syntax caseq/callback
  (syntax-rules ()
    ((_ sym buf) (case sym . buf))))

(define-syntax caseq/helper
  (syntax-rules (quote else)
    ((_ sym buf)
     (syntax-reverse (caseq/callback sym) buf))
    ((_ sym buf (else . bodies))
     (caseq/helper
      sym ((else . bodies) . buf)))
    ((_ sym buf ((quote x) . bodies) . clauses)
     (caseq/helper
      sym (((x) . bodies) . buf)
      . clauses))
    ((_ sym buf (c . bodies) . clauses)
     (syntax-error "Expected a quoted symbol, but got" c))))

(define-syntax caseq
  (syntax-rules ()
    ((_ sym clause . clauses)
     (caseq/helper
      sym () clause . clauses))))
