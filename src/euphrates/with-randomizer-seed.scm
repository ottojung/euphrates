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
  (define-module (euphrates with-randomizer-seed)
    :export (with-randomizer-seed)
    :use-module ((euphrates current-random-source-p) :select (current-random-source/p))
    :use-module ((euphrates fast-parameterizeable-timestamp-p) :select (fast-parameterizeable-timestamp/p))
    :use-module ((euphrates raisu) :select (raisu))
    :use-module ((euphrates srfi-27-generic) :select (make-random-source random-source-randomize!))
    :use-module ((euphrates time-get-fast-parameterizeable-timestamp) :select (time-get-fast-parameterizeable-timestamp))
    )))


(define-syntax with-randomizer-seed/norec
  (syntax-rules ()
    ((_ seed-expr . bodies)
     (let ((seed seed-expr))
       (unless (integer? seed)
         (raisu 'seed-must-be-an-integer seed))
       (let ((src (make-random-source))
             (time (let ((x (+ 100000 (inexact->exact seed))))
                     (if (< x 0) (- 0 x) x))))
         (parameterize ((current-random-source/p src))
           (parameterize ((fast-parameterizeable-timestamp/p time))
             (random-source-randomize! src))
           (let () . bodies)))))))

(define-syntax with-randomizer-seed
  (syntax-rules (:random)
    ((_ :random . bodies)
     (with-randomizer-seed/norec
      (time-get-fast-parameterizeable-timestamp)
      . bodies))
    ((_ seed-expr . bodies)
     (let ((seed seed-expr))
       (if (equal? seed 'random)
           (with-randomizer-seed :random . bodies)
           (with-randomizer-seed/norec seed . bodies))))))
