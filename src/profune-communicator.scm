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

%var make-profune-communicator
%var profune-communicator?
%var profune-communicator-handle

%use (comp) "./comp.scm"
%use (define-type9) "./define-type9.scm"
%use (list-singleton?) "./list-singleton-q.scm"
%use (list-span-while) "./list-span-while.scm"
%use (profun-IDR-arity profun-IDR-name profun-IDR?) "./profun-IDR.scm"
%use (profun-RFC-continue-with-inserted profun-RFC-what profun-RFC?) "./profun-RFC.scm"
%use (profun-database-add-rule! profun-database-copy profun-database? profun-run-query) "./profun.scm"
%use (raisu) "./raisu.scm"
%use (stack-empty? stack-make stack-peek stack-pop! stack-push!) "./stack.scm"

(define-type9 profune-communicator
  (profune-communicator-constructor db stages) profune-communicator?
  (db profune-communicator-db)
  (stages profune-communicator-stages)
  )

(define-type9 stage
  (make-stage answer-iterator results-buffer rfc) stage?
  (answer-iterator stage-answer-iterator set-stage-answer-iterator!)
  (results-buffer stage-results-buffer set-stage-results-buffer!)
  (rfc stage-rfc set-stage-rfc!)
  )

(define (make-profune-communicator db0)
  (define db
    (if (profun-database? db0)
        (profun-database-copy db0)
        (raisu 'expected-a-profun-database db0)))
  (define stages (stack-make))

  (profune-communicator-constructor db stages))

(define (profune-communicator-handle comm commands)
  (define db (profune-communicator-db comm))
  (define stages (profune-communicator-stages comm))

  (define (current-answer-iterator)
    (stage-answer-iterator (stack-peek stages)))
  (define (current-results-buffer)
    (stage-results-buffer (stack-peek stages)))
  (define (current-RFC)
    (stage-rfc (stack-peek stages)))

  (define (set-current-answer-iterator! new)
    (set-stage-answer-iterator! (stack-peek stages) new))
  (define (set-current-results-buffer! new)
    (set-stage-results-buffer! (stack-peek stages) new))
  (define (set-current-RFC! new)
    (set-stage-rfc! (stack-peek stages) new))

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
    (set-current-results-buffer! '())
    (set-current-answer-iterator! #f))

  (define (collect-n n)
    (let loop ((i 0) (buf (current-results-buffer)))
      (if (>= i n)
          `(its (equals ,(reverse! buf)))
          (let ((r (and (current-answer-iterator)
                        ((current-answer-iterator)))))
            (cond
             ((or (pair? r) (null? r))
              (loop (+ 1 i) (cons r buf)))
             ((equal? #f r)
              (collect-finish!)
              `(its (equals ,(reverse! buf))))

             ((profun-IDR? r)
              (collect-finish!)
              (let ((name (profun-IDR-name r))
                    (arity (profun-IDR-arity r)))
                `(i-dont-recognize ,name ,arity)))
             ((profun-RFC? r)
              (set-current-results-buffer! buf)
              (set-current-RFC! r)
              `(whats ,@(profun-RFC-what r)))

             (else
              (raisu 'unexpected-result-from-profun-iterator r)
              #f))))))

  (define (handle-whats op args next)
    (define iterator
      (profun-run-query db args))
    (stack-push! stages (make-stage iterator '() #f))
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
    (unless (null? next)
      (raisu 'more-must-be-the-last-command next))
    (collect-n n))

  (define (handle-its op args next)
    (when (stack-empty? stages)
      (raisu 'did-not-ask-anything args))

    (unless (current-RFC)
      (stack-pop! stages)
      (when (stack-empty? stages)
        (raisu 'did-not-ask-anything args)))

    (set-current-answer-iterator!
     (profun-RFC-continue-with-inserted (current-RFC) args))
    (set-current-RFC! #f)

    (handle-query next))

  (define (handle-bye op args next)
    (set! db #f)
    (set! stages #f)
    (unless (and (null? args) (null? next))
      (raisu 'bye-must-not-have-any-arguments op args next)))

  (define (handle-listen op args next)
    (for-each (comp (profun-database-add-rule! db)) args)
    (handle next))

  (define (handle commands)
    (when (null? commands)
      (raisu 'expecting-more-commands-than-this))
    (unless (list? commands)
      (raisu 'commands-must-be-a-list commands))
    (unless (symbol? (car commands))
      (raisu 'commands-must-start-from-an-operation commands))
    (unless db
      (raisu 'already-said-bye-bye))

    (let ()
      (define-values (op args next)
        (split-commands commands))
      (case op
        ((listen) (handle-listen op args next))
        ((whats) (handle-whats op args next))
        ((its) (handle-its op args next))
        ((more) (handle-more op args next))
        ((bye) (handle-bye op args next))
        (else (raisu 'operation-not-supported op)))))

  (handle commands))
