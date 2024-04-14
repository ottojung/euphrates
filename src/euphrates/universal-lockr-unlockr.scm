;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




;; Like uni-spinlock but use arbitary variables as lock target
;; and do sleep when wait
(define-values (universal-lockr! universal-unlockr!)
  (let ((critical (make-uni-spinlock-critical))
        (h (make-hashmap)))
    (values
     (lambda (resource)
       (let ((sleep (dynamic-thread-get-delay-procedure)))
         (let lp ()
           (when
               (with-critical
                critical
                (let ((r (hashmap-ref h resource #f)))
                  (if r
                      #t
                      (begin
                        (hashmap-set! h resource #t)
                        #f))))
             (sleep)
             (lp)))))
     (lambda (resource)
       (with-critical
        critical
        (hashmap-delete! h resource))))))
