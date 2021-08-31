;;;; Copyright (C) 2021  Otto Jung
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

;; Expects its procedure to return list of new values for received arguments.
%var profun-op-apply

%use (raisu) "./raisu.scm"

(define profun-op-apply
  (lambda (args ctx)
    (and (not ctx)
         (let* ((procedure (car args))
                (arguments (cdr args))
                (result (apply procedure arguments)))
           (cond
            ((eq? #f result)
             #f)
            ((pair? result)
             (cons (cons #t result) #t))
            (else
             (cons #t #t)))))))
