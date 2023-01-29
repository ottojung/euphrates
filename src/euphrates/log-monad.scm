;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
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
  (define-module (euphrates log-monad)
    :export (log-monad)
    :use-module ((euphrates dprint) :select (dprint))
    :use-module ((euphrates monad-make-no-cont) :select (monad-make/no-cont))
    :use-module ((euphrates monadfinobj) :select (monadfinobj?))
    :use-module ((euphrates monadstate) :select (monadstate-args monadstate-qval monadstate-qvar))
    :use-module ((euphrates tilda-a) :select (~a))
    :use-module ((euphrates words-to-string) :select (words->string)))))



(define (log-monad-show-values monad-input)
  (words->string (map ~a (monadstate-args monad-input))))

(define log-monad
  (monad-make/no-cont
   (lambda (monad-input)
     (if (monadfinobj? monad-input)
         (dprint "(return ~a)\n" (log-monad-show-values monad-input))
         (dprint "(~a = ~a = ~a)\n"
                 (monadstate-qvar monad-input)
                 (log-monad-show-values monad-input)
                 (monadstate-qval monad-input)))
     monad-input)))
