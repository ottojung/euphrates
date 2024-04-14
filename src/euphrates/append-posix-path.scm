;;;; Copyright (C) 2020, 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define [append-posix-path2 a b]
  (if (= (string-length a) 0)
      b
      (let ((b
             (if (absolute-posix-path? b)
                 (let ((cl (remove-common-prefix b a)))
                   (if (equal? cl b)
                       (raisu 'append-posix-path-disjoint `(args: ,a ,b))
                       cl))
                 b)))
        (if (char=? #\/ (string-ref a (- (string-length a) 1)))
            (string-append a b)
            (string-append a "/" b)))))

(define [append-posix-path . paths]
  (if (null? paths) "/"
      (let loop ((paths paths))
        (if (null? (cdr paths)) (car paths)
            (append-posix-path2 (car paths) (loop (cdr paths)))))))

