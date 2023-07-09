;;;; Copyright (C) 2023  Otto Jung
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

(define called-once-memory/p
  (make-parameter #f))

(define-syntax with-called-once-extent
  (syntax-rules ()
    ((_ . bodies)
     (parameterize ((called-once-memory/p (make-box #f)))
       (let () . bodies)))))

(define-syntax assert-called-once
  (syntax-rules ()
    ((_)
     (let* ((mem (called-once-memory/p)))
       (cond
        ((not mem)
         (raisu 'assert-called-once-not-initialized
                "The extent of assert-called-once is not specified. Use `with-called-once-extent'"))
        ((box-ref mem)
         (raisu 'assert-failed
                "Called many times what supposed to be called once"))
        (else
         (box-set! mem #t)
         (when #f #t)))))))
