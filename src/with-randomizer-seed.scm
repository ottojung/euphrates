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

%var with-randomizer-seed

%use (current-random-source/p) "./current-random-source-p.scm"
%use (fast-parameterizeable-timestamp/p) "./fast-parameterizeable-timestamp-p.scm"
%use (time-get-fast-parameterizeable-timestamp) "./time-get-fast-parameterizeable-timestamp.scm"
%use (make-random-source random-source-randomize!) "./srfi-27-generic.scm"
%use (raisu) "./raisu.scm"

(define-syntax with-randomizer-seed
  (syntax-rules (:random)
    ((_ :random . bodies)
     (with-randomizer-seed
      (time-get-fast-parameterizeable-timestamp)
      . bodies))
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
