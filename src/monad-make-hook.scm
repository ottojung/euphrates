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

%run guile

%var monad-make/hook

%use (monad-make/no-cont/no-fin) "./monad-make-no-cont-no-fin.scm"
%use (monadstate-current/p) "./monadstate-current-p.scm"
%use (monadstate-args monadstate-qtags monadstate-ret) "./monadstate.scm"

(define monad-make/hook/undefined-list
  (list (when #f #f)))

(define-syntax monad-make/hook
  (syntax-rules ()
    ((_ tags-name args-list-name . bodies)
     (monad-make/no-cont/no-fin
      (lambda (monad-input)
        (call-with-values
            (lambda _
              (parameterize ((monadstate-current/p monad-input))
                (let ((tags-name (monadstate-qtags monad-input)))
                  (apply (lambda args-list-name . bodies)
                         (monadstate-args monad-input)))))
          (lambda results
            (if (equal? results monad-make/hook/undefined-list)
                (monadstate-ret monad-input '())
                (monadstate-ret monad-input results)))))))))
