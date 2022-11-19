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

%var profune-communications
%var make-profune-communicator

;;
;; Communications between a client A and a server B.
;; Messages are based on profun queries.
;; Example dialogs:
;;   (B knows how to compute square roots, A wants to know sqrt(9))
;;   A: whats, sqrt(X, Y).
;;   B: whats, value(or(X, Y)).
;;   A: its, X = 9.
;;   B: its, Y = 3.
;;
;;   (same as above, but A is straightforward)
;;   A: whats, X = 9, sqrt(X, Y).
;;   B: its, Y = 3.
;;
;;   (A makes a typo)
;;   A: whats, X = 9, swrt(X, Y).
;;   B: i-dont-recognize, swrt, 2.
;;   A: whats, X = 9, sqrt(X, Y).
;;   B: its, Y = 3.
;;
;;   (A is calling B's tegfs API -- he wants to query entries with their previews)
;;   A: listen, query("image+funny"), diropen?(#t), whats, shared-preview(E, P).
;;   B: whats, value(E).
;;   A: its, entry(E).
;;   B: its, E = ..., P = ....
;;   A: more.
;;   B: its, E = ..., P = ....
;;   A: more.
;;   B: its, false.
;;
;; Every communicator must know these words: "whats", "its", "listen", "more", and "i-dont-recognize".
;;

%use (comp) "./comp.scm"
%use (list-singleton?) "./list-singleton-q.scm"
%use (list-span-while) "./list-span-while.scm"
%use (profun-IDR-arity profun-IDR-name profun-IDR?) "./profun-IDR.scm"
%use (profun-RFC-continuation profun-RFC-what profun-RFC?) "./profun-RFC.scm"
%use (profun-database-add-rule! profun-database-copy profun-run-query) "./profun.scm"
%use (raisu) "./raisu.scm"

(define (make-profune-communicator db0)
  (define db (profun-database-copy db0))
  (define current-answer-iterator #f)
  (define current-results-buffer '())
  (define current-continuation #f)

  (define (split-commands commands)
    (if (null? commands)
        (values #f '() '())
        (let ()
          (define op (car commands))
          (define rest (cdr commands))
          (define-values (args next)
            (list-span-while pair? rest))
          (values op args next))))

  (define (collect-finish!)
    (set! current-results-buffer '())
    (set! current-answer-iterator #f))

  (define (collect-n n)
    (let loop ((i 0) (buf current-results-buffer))
      (if (>= i n)
          `(its (equals ,(reverse! buf)))
          (let ((r (and current-answer-iterator
                        (current-answer-iterator))))
            (cond
             ((or (pair? r) (null? r))
              (loop (+ 1 i) (cons r buf)))
             ((equal? #f r)
              (collect-finish!)
              `(its (equals ,(reverse! buf))))

             ((profun-IDR? r)
              (collect-finish!)
              `(i-dont-recognize ,(profun-IDR-name r) ,(profun-IDR-arity r)))
             ((profun-RFC? r)
              (set! current-results-buffer buf)
              (set! current-continuation (profun-RFC-continuation r))
              `(whats ,@(profun-RFC-what r)))

             (else
              (raisu 'unexpected-result-from-profun-iterator r)
              #f))))))

  (define (handle-whats op args next)
    (set! current-answer-iterator
          (profun-run-query db args))
    (handle-query next))

  (define (handle-query next)
    (define-values (next-op next-args next-next)
      (split-commands next))

    (case next-op
      ((#f)
       (collect-n 1))
      ((more)
       (unless (null? next-next)
         (raisu 'operation-whats/its-must-be-last next))
       (let ((n (get-more-s-arg next-args)))
         (collect-n (+ 1 n))))
      (else
       (raisu 'unexpected-op next-op))))

  (define (get-more-s-arg args)
    (cond
     ((null? args) 1)
     ((null? (cdr args))
      (let ((nl (car args)))
        (unless (list-singleton? nl)
          (raisu 'more-s-argument-must-be-a-singleton-list nl))
        (unless (and (integer? (car nl)) (<= 0 (car nl)))
          (raisu 'more-s-argument-must-a-natural-number nl))
        (car nl)))
     (else (raisu 'more-must-have-atmost-single-argument args))))

  (define (handle-more op args next)
    (define n (get-more-s-arg args))
    (collect-n n))

  (define (handle-its op args next)
    (unless current-continuation
      (raisu 'did-not-ask-anything op args))

    (set! current-answer-iterator
          (current-continuation '() args))
    (set! current-continuation #f)

    (handle-query next))

  (define (handle commands)
    (if (null? commands)
        (raisu 'TODO)
        (let ()
          (define-values (op args next)
            (split-commands commands))

          (case op
            ((listen)
             (for-each (comp (profun-database-add-rule! db)) args)
             (handle next))
            ((whats)
             (handle-whats op args next))
            ((its)
             (handle-its op args next))
            ((more)
             (handle-more op args next))
            (else
             (raisu 'not-implemented-ccc))))))

  handle)
