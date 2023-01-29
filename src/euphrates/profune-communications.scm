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
  (define-module (euphrates profune-communications)
    :export (profune-communications)
    :use-module ((euphrates list-singleton-q) :select (list-singleton?))
    :use-module ((euphrates profun) :select (profun-eval-query))
    :use-module ((euphrates profune-communications-hook-p) :select (profune-communications-hook/p))
    :use-module ((euphrates profune-communicator) :select (profune-communicator-db profune-communicator-handle)))))


;;
;; Communications between a client A and a server B.
;; Messages are based on profun queries.
;; Example dialogs:
;;   (B knows how to compute square roots, A wants to know sqrt(9))
;;   A: whats, sqrt(X, Y).
;;   B: whats, value(or(X, Y)).
;;   A: its, X = 9.
;;   B: its, Y = 3.
;;   A: bye.
;;
;;   (same as above, but A is straightforward)
;;   A: whats, X = 9, sqrt(X, Y).
;;   B: its, Y = 3.
;;   A: bye.
;;
;;   (A continues)
;;   A: whats, X = 9, sqrt(X, Y).
;;   B: its, Y = 3.
;;   A: whats, Y = 4, sqrt(X, Y).
;;   B: its, X = 16.
;;   A: bye.
;;
;;   (A makes a typo)
;;   A: whats, X = 9, swrt(X, Y).
;;   B: i-dont-recognize, swrt, 2.
;;   A: whats, X = 9, sqrt(X, Y).
;;   B: its, Y = 3.
;;   A: bye.
;;
;;   (A is calling B's tegfs API -- he wants to query entries with their previews)
;;   A: listen, query("image+funny"), diropen?(#t), whats, shared-preview(E, P).
;;   B: whats, value(E).
;;   A: its, entry(E).
;;   B: its, E = ..., P = ....
;;   A: more.
;;   B: its, E = ..., P = ....
;;   A: more.
;;   B: its, false().
;;   A: bye.
;;
;; Every communicator must know these words: "whats", "its", "equals", "listen", "more", "inspect", "return", "ok", "bye", "error" and "i-dont-recognize".
;;


(define (profune-communications client-comm server-comm)
  (define hook
    (or (profune-communications-hook/p)
        (lambda _ 0)))

  (define (handle-result answer)
    (let* ((not-null (pair? answer))
           (op (and not-null (car answer)))
           (args (and not-null (cdr answer))))
      (cond
       ((not (pair? answer)) answer)
       ((null? args) answer)
       ((and (list-singleton? args)
             (pair? (car args))
             (equal? 'equals (car (car args)))
             (list-singleton? (cdr (car args))))
        (cadr (cadr answer)))
       (else
        (profun-eval-query
         (profune-communicator-db client-comm)
         (cdr answer))))))

  (lambda (question)
    (let loop ((question question))
      (define r1 (hook 'client question))
      (define answer
        (profune-communicator-handle server-comm question))
      (define r2 (hook 'server answer))
      (define response
        (profune-communicator-handle client-comm answer))

      (cond
       ((not (pair? response)) response)
       ((equal? 'error (car response))
        (if (null? (cdr response)) response
            (if (equal? (cadr response) '(did-not-ask-anything))
                (handle-result answer)
                response)))
       (else (loop response))))))
