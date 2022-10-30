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

%use (catchu-case) "./catchu-case.scm"
%use (monad-do/generic) "./monad-do.scm"
%use (raisu) "./raisu.scm"

(define-syntax monad-ask/helper
  (syntax-rules ()
    ((_ var default-value default-value-provided? . tags)
     (begin
       (define var
         (let ((qtags (list 'ask . tags))
               (val (quote var)))
           (define result
             (monad-do/generic (var val qtags)))
           (catchu-case
            (result)
            (('incorrect-number-of-arguments-returned-by-monad
              actual-length expected-length)
             (cond
              ((< actual-length 1)
               (raisu 'monad-ask-did-not-receive-a-value val qtags))
              ((> actual-length 1)
               (raisu 'monad-ask-received-too-many-values val qtags actual-length))
              (else
               (raisu 'impossible-case-for-monad-ask val qtags actual-length)))))))
       (when #f #f)))))

(define-syntax monad-ask
  (syntax-rules (:default)
    ((_ var :default default-value . tags)
     (monad-ask/helper var default-value #t . tags))
    ((_ var . tags)
     (monad-ask/helper var #f #f . tags))))
