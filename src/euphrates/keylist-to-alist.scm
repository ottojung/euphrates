;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (keylist->alist keylist)
  (define (gkeyword? x) (or (fkeyword? x) (rkeyword? x)))

  (unless (list? keylist)
    (raisu* :type 'type-error
            :message "Expected a keylist, but got something else"
            :args (list keylist)))

  (let loop ((rest keylist)
             (previous 0)
             (counter 0))
    (if (null? rest)
        (if (gkeyword? previous)
            (raisu* :type 'type-error
                    :message "Input keylist has a dangling key"
                    :args (list previous keylist))
            '())
        (let ((current (car rest)))
          (if (gkeyword? previous)
              (if (gkeyword? current)
                  (raisu* :type 'type-error
                          :message "Input keylist has two consequtive keys"
                          :args (list previous current keylist))
                  (cons (cons previous current)
                        (loop (cdr rest)
                              counter
                              counter)))
              (if (gkeyword? current)
                  (loop (cdr rest) current counter)
                  (cons (cons counter current)
                        (loop (cdr rest)
                              (+ 1 counter)
                              (+ 1 counter)))))))))
