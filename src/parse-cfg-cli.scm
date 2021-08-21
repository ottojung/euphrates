;;;; Copyright (C) 2021  Otto Jung
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

;;
;; In this file we translate CFG-CLI definitions
;; into CFG-AST language.
;;

%var CFG-CLI->CFG-AST

%use (raisu) "./raisu.scm"
%use (list-split-on) "./list-split-on.scm"

(define (CFG-CLI->CFG-AST body)
  ;; Example body:
  ;;   '(run OPTS* DATE <end-statement>
  ;;     OPTS*   : --opts <opts...>*
  ;;             / --param1 <arg1>
  ;;             / --flag1
  ;;     DATE    : may  <nth> MAY-OPTS?
  ;;             / june <nth> JUNE-OPTS*
  ;;     MAY-OPTS?    : -p <x>
  ;;     JUNE-OPTS*   : -f3 / -f4)

  (define shifted-semilocons
    (let loop ((body body) (last ':))
      (if (null? body)
          (list last)
          (let ((cur (car body)))
            (if (equal? ': cur)
                (if (equal? ': last)
                    (raisu 'cannot-start-with-a-semicolon last body)
                    (cons cur (loop (cdr body) last)))
                (cons last (loop (cdr body) cur)))))))

  ;; Example shifted-semilocons:
  ;;   '(: run OPTS* DATE <end-statement>
  ;;     : OPTS*   --opts <opts...>*
  ;;             / --param1 <arg1>
  ;;             / --flag1
  ;;     : DATE    may  <nth> MAY-OPTS?
  ;;             / june <nth> JUNE-OPTS*
  ;;     : MAY-OPTS?    -p <x>
  ;;     : JUNE-OPTS*   -f3 / -f4)

  (define grouped
    (list-split-on (lambda (word) (eq? ': word)) shifted-semilocons))

  ;; Example grouped:
  ;;   '((run OPTS* DATE <end-statement>)
  ;;     (OPTS*    --opts <opts...>*
  ;;             / --param1 <arg1>
  ;;             / --flag1)
  ;;     (DATE     may  <nth> MAY-OPTS?
  ;;             / june <nth> JUNE-OPTS*)
  ;;     (MAY-OPTS?    -p <x>)
  ;;     (JUNE-OPTS*   -f3 / -f4))

  (define main-name 'MAIN)
  (define decorated-first
    (cons (cons main-name (car grouped))
          (cdr grouped)))

  ;; Example decorated-first:
  ;;   '((MAIN     run OPTS* DATE <end-statement>)
  ;;     (OPTS*    --opts <opts...>*
  ;;             / --param1 <arg1>
  ;;             / --flag1)
  ;;     (DATE     may  <nth> MAY-OPTS?
  ;;             / june <nth> JUNE-OPTS*)
  ;;     (MAY-OPTS?    -p <x>)
  ;;     (JUNE-OPTS*   -f3 / -f4))

  (define split-by-cases
    (map
     (lambda (production)
       (define name (car production))
       (define regex (cdr production))
       (cons name (list-split-on (lambda (word) (equal? '/ word)) regex)))
     decorated-first))

  ;; Example split-by-cases:
  ;;   '((MAIN   (run OPTS* DATE <end-statement>))
  ;;     (OPTS*  (--opts <opts...>*)
  ;;             (--param1 <arg1>)
  ;;             (--flag1))
  ;;     (DATE   (may  <nth> MAY-OPTS?)
  ;;             (june <nth> JUNE-OPTS*))
  ;;     (MAY-OPTS?    (-p <x>))
  ;;     (JUNE-OPTS*   (-f3) (-f4)))

  split-by-cases)
