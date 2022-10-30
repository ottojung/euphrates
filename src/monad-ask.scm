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

%var monad-ask

%use (monad-do/generic) "./monad-do.scm"
%use (raisu) "./raisu.scm"

(define-syntax monad-ask
  (syntax-rules ()
    ((_ var . tags)
     (begin
       (define var
         (let ((qtags (list 'ask . tags))
               (val (quote var)))
           (call-with-values
               (lambda _
                 (monad-do/generic (var val qtags)))
             (lambda results
               (when (null? results)
                 (raisu 'monad-ask-did-not-receive-a-value val qtags))
               (unless (null? (cdr results))
                 (raisu 'monad-ask-received-too-many-values val qtags (length result)))

               (car results)))))
       (when #f #f)))))
