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
%use (profun-CR-what profun-CR?) "./profun-CR.scm"
%use (profun-IDR-arity profun-IDR-name profun-IDR?) "./profun-IDR.scm"
%use (profun-RFC-continue-with-inserted profun-RFC-eval-inserted profun-RFC-what profun-RFC?) "./profun-RFC.scm"
%use (profun-error-args profun-error?) "./profun-error.scm"
%use (profun-database-add-rule! profun-database-copy profun-database? profun-make-iterator profun-next) "./profun.scm"
%use (raisu) "./raisu.scm"
%use (stack-empty? stack-make stack-peek stack-pop! stack-push!) "./stack.scm"

(define-type9 profune-communicator
  (profune-communicator-constructor db stages) profune-communicator?
  (db profune-communicator-db)
  (stages profune-communicator-stages)
  )

(define-type9 stage
  (make-stage answer-iterator left results-buffer rfc) stage?
  (answer-iterator stage-answer-iterator set-stage-answer-iterator!)
  (left stage-left set-stage-left!)
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
  (define (current-left)
    (stage-left (stack-peek stages)))
  (define (current-results-buffer)
    (stage-results-buffer (stack-peek stages)))
  (define (current-RFC)
    (if (stack-empty? stages) #f
        (stage-rfc (stack-peek stages))))

  (define (set-current-answer-iterator! new)
    (set-stage-answer-iterator! (stack-peek stages) new))
  (define (set-current-left! new)
    (set-stage-left! (stack-peek stages) new))
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
    (set-current-left! 0)
    (set-current-results-buffer! '())
    (set-current-answer-iterator! #f))

  (define (collect-n)
    (define n (current-left))
    (define iter (current-answer-iterator))
    (let loop ((i 0) (buf (current-results-buffer)))
      (if (>= i n)
          (begin
            (set-current-left! 0)
            `(its (equals ,(reverse! buf))))
          (let ((r (and iter (profun-next iter))))
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

             ((profun-CR? r)
              (collect-finish!)
              (let ((what (profun-CR-what r)))
                (if (list? what)
                    (cons 'its what)
                    (list 'its what))))

             ((profun-RFC? r)
              (set-current-results-buffer! buf)
              (set-current-RFC! r)
              `(whats ,@(profun-RFC-what r)))

             ((profun-error? r)
              (collect-finish!)
              `(error ,(profun-error-args r)))

             (else
              (collect-finish!)
              `(error (unexpected-result-from-profun-iterator))))))))

  (define (handle-whats op args next)
    (define iterator
      (if (current-RFC)
          (profun-RFC-eval-inserted (current-RFC) args)
          (profun-make-iterator db args)))
    (stack-push! stages (make-stage iterator 1 '() #f))
    (handle-query next))

  (define (handle-query next)
    (define-values (next-op next-args next-next)
      (split-commands next))

    (case next-op
      ((#f)
       (set-current-left! 1)
       (collect-n))
      ((more)
       (if (null? next-next)
           (let ((n (get-more-s-arg next-args)))
             (set-current-left! (+ 1 n))
             (collect-n))
           `(error (operation-whats/its-must-be-last))))
      (else
       `(error (unexpected-operation ,next-op)))))

  (define (get-more-s-arg args)
    (cond
     ((null? args) 1)
     ((null? (cdr args))
      (let ((nl (car args)))
        (cond
         ((not (list-singleton? nl))
          `(error (more-s-argument-must-be-a-singleton-list)))
         ((not (and (integer? (car nl)) (<= 0 (car nl))))
          `(error (more-s-argument-must-a-natural-number)))
         (else (car nl)))))
     (else
      `(error (more-must-have-atmost-single-argument)))))

  (define (handle-more op args next)
    (define n (get-more-s-arg args))
    (cond
     ((not (null? next)) `(error (more-must-be-the-last-command)))
     ((not (number? n)) n)
     (else
      (set-current-left! n)
      (collect-n))))

  (define (handle-its-cont op args next)
    (set-current-answer-iterator!
     (profun-RFC-continue-with-inserted (current-RFC) args))
    (set-current-RFC! #f)

    (collect-n))

  (define (handle-its op args next)
    (cond
     ((stack-empty? stages)
      `(error (did-not-ask-anything)))
     ((current-RFC)
      (handle-its-cont op args next))
     (else
      (stack-pop! stages)
      (if (stack-empty? stages)
          `(error (did-not-ask-anything))
          (handle-its-cont op args next)))))

  (define (handle-bye op args next)
    (set! db #f)
    (set! stages #f)
    (if (and (null? args) (null? next))
        `(bye)
        `(error (bye-must-not-have-any-arguments))))

  (define (handle-ok op args next)
    (if (null? next)
        `(bye)
        (handle next)))

  (define (handle-listen op args next)
    (for-each (comp (profun-database-add-rule! db)) args)
    (handle next))

  (define (handle commands)
    (cond
     ((null? commands) `(ok))
     ((null? commands) `(error (expected more)))
     ((not (list? commands))
      `(error (commands-must-be-a-list)))
     ((not (symbol? (car commands)))
      `(error (commands-must-start-from-an-operation)))
     ((not db)
      `(error (already-said-bye-bye)))
     (else
      (let ()
        (define-values (op args next)
          (split-commands commands))
        (case op
          ((listen) (handle-listen op args next))
          ((whats) (handle-whats op args next))
          ((its) (handle-its op args next))
          ((more) (handle-more op args next))
          ((ok) (handle-ok op args next))
          ((bye) (handle-bye op args next))
          (else `(error (operation-not-supported ,op))))))))

  (handle commands))
