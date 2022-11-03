;;;; Copyright (C) 2022  Otto Jung
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

%run guile

%var profun-accept
%var profun-accept?

%use (define-type9) "./define-type9.scm"
%use (raisu) "./raisu.scm"

(define-type9 profun-accept-obj
  (profun-accept-constructor alist context context-changed?) profun-accept-obj?
  (alist profun-accept-alist)
  (context profun-accept-ctx)
  (context-changed? profun-accept-ctx-changed?)
  )

(define (profun-accept)
  (profun-accept-constructor '() #f #f))

(define (profun-accept? o)
  (profun-accept-obj? o))

(define (profun-set variable-index variable-value current-return-value)
  (unless (profun-accept-obj? current-return-value)
    (raisu 'current-return-value-must-be-a-profun-accept-obj current-return-value))
  (unless (and (integer? variable-index) (<= 0 variable-index))
    (raisu 'variable-index-must-be-a-nonnegative-integer current-return-value))

  (let* ((alist (profun-accept-alist current-return-value))
         (ctx (profun-accept-ctx current-return-value))
         (ctx-changed? (profun-accept-ctx-changed? current-return-value))
         (additional (cons variable-index variable-value))
         (new-alist (cons additional alist)))
    (profun-accept-constructor new-alist ctx ctx-changed?)))

(define (profun-ctx-set new-context current-return-value)
  (unless (profun-accept-obj? current-return-value)
    (raisu 'current-return-value-must-be-a-profun-accept-obj current-return-value))

  (let* ((alist (profun-accept-alist current-return-value)))
    (profun-accept-constructor alist new-context #t)))
