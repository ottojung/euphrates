;;;; Copyright (C) 2022, 2023  Otto Jung
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
%var profune-communicator-db
%var profune-communicator-handle

%use (comp) "./comp.scm"
%use (define-type9) "./define-type9.scm"
%use (list-and-map) "./list-and-map.scm"
%use (list-deduplicate/reverse) "./list-deduplicate.scm"
%use (list-length=<?) "./list-length-geq-q.scm"
%use (list-map-first) "./list-map-first.scm"
%use (list-singleton?) "./list-singleton-q.scm"
%use (list-span-while) "./list-span-while.scm"
%use (profun-CR-what profun-CR?) "./profun-CR.scm"
%use (profun-IDR-arity profun-IDR-name profun-IDR?) "./profun-IDR.scm"
%use (profun-RFC-what profun-RFC?) "./profun-RFC.scm"
%use (profun-abort-iter) "./profun-abort.scm"
%use (profun-database-add-rule! profun-database-copy profun-database-get-all profun-database-handle profun-database?) "./profun-database.scm"
%use (profun-error-args profun-error?) "./profun-error.scm"
%use (profun-iterator-copy profun-iterator-insert! profun-iterator-reset!) "./profun-iterator.scm"
%use (profun-iterate profun-next) "./profun.scm"
%use (raisu) "./raisu.scm"
%use (stack-empty? stack-make stack-peek stack-pop! stack-push! stack-unload!) "./stack.scm"

(define-type9 profune-communicator
  (profune-communicator-constructor db0 stages) profune-communicator?
  (db profune-communicator-db) ;; the initial state of the database
  (stages profune-communicator-stages)
  )

(define-type9 stage
  (make-stage db answer-iterator left results-buffer cont inspecting) stage?
  (db stage-db set-stage-db!)
  (answer-iterator stage-answer-iterator set-stage-answer-iterator!)
  (left stage-left set-stage-left!)
  (results-buffer stage-results-buffer set-stage-results-buffer!)
  (cont stage-cont set-stage-cont!)
  (inspecting stage-inspecting set-stage-inspecting!)
  )

(define (make-profune-communicator db0)
  (define stages (stack-make))
  (profune-communicator-constructor db0 stages))

(define (profune-communicator-handle comm commands)
  (define stages (profune-communicator-stages comm))

  (define (reset-db! stage)
    (define new (profune-communicator-db comm))
    (set-stage-db! stage new)
    new)

  (define (current-db/not-empty)
    (define stage (stack-peek stages))
    (define get0 (stage-db stage))
    (or get0 (reset-db! stage)))

  (define (current-db)
    (if (stack-empty? stages)
        (let ((stage (push-stage! #f #f)))
          (reset-db! stage))
        (current-db/not-empty)))

  (define (copy-db db0)
    (if (profun-database? db0)
        (profun-database-copy db0)
        (raisu 'expected-a-profun-database db0)))

  (define (copy-db! stage)
    (define new (copy-db (profune-communicator-db comm)))
    (set-stage-db! stage new)
    new)

  (define (current-db/copy/not-empty)
    (define stage (stack-peek stages))
    (define get0 (stage-db stage))
    (or get0 (copy-db! stage)))

  (define (current-db/copy)
    (if (stack-empty? stages)
        (let ((stage (push-stage! #f #f)))
          (copy-db! stage))
        (current-db/copy/not-empty)))

  (define (current-answer-iterator)
    (if (stack-empty? stages)
        (begin
          (push-stage! #f #f)
          #f)
        (stage-answer-iterator (stack-peek stages))))
  (define (current-left)
    (if (stack-empty? stages)
        (begin
          (push-stage! #f #f)
          #f)
        (stage-left (stack-peek stages))))
  (define (current-results-buffer)
    (if (stack-empty? stages)
        (begin
          (push-stage! #f #f)
          #f)
        (stage-results-buffer (stack-peek stages))))
  (define (current-CONT)
    (if (stack-empty? stages)
        (begin
          (push-stage! #f #f)
          #f)
        (stage-cont (stack-peek stages))))
  (define (current-inspecting)
    (if (stack-empty? stages)
        (begin
          (push-stage! #f #f)
          #f)
        (stage-inspecting (stack-peek stages))))

  (define (set-current-answer-iterator! new)
    (set-stage-answer-iterator! (stack-peek stages) new))
  (define (set-current-left! new)
    (set-stage-left! (stack-peek stages) new))
  (define (set-current-results-buffer! new)
    (set-stage-results-buffer! (stack-peek stages) new))
  (define (set-current-CONT! new)
    (set-stage-cont! (stack-peek stages) new))
  (define (set-current-inspecting! new)
    (set-stage-inspecting! (stack-peek stages) new))

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
    )

  (define (format-single-answer buf)
    (cond
     ((null? buf) '((false)))
     ((null? (car buf)) '((true)))
     (else
      (map
       (lambda (p)
         `(= ,(car p) ,(cdr p)))
       (car buf)))))

  (define (collect-ret n buf)
    (if (= n 1)
        `(its ,@(format-single-answer buf))
        `(its (equals ,(reverse! buf)))))

  (define (collect-n)
    (define n (current-left))
    (define iter (current-answer-iterator))
    (let loop ((i 0) (buf (current-results-buffer)))
      (if (>= i n)
          (begin
            (set-current-left! 0)
            (collect-ret n buf))
          (let ((r (and iter (profun-next iter))))
            (cond

             ((or (pair? r) (null? r))
              (loop (+ 1 i) (cons r buf)))

             ((equal? #f r)
              (collect-finish!)
              (collect-ret n buf))

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
              (let ((iter (profun-abort-iter r)))
                (set-current-CONT! iter)
                (push-stage! iter #f)
                `(whats ,@(profun-RFC-what r))))

             ((profun-error? r)
              (collect-finish!)
              `(error ,(profun-error-args r)))

             (else
              (collect-finish!)
              `(error (unexpected-result-from-profun-iterator))))))))

  (define (push-stage! iterator inspected)
    (define maybe-db
      (if (stack-empty? stages)
          #f
          (stage-db (stack-peek stages))))
    (define stage (make-stage maybe-db iterator 1 '() #f inspected))
    (stack-push! stages stage)
    stage)

  (define (handle-whats op args next)
    (define inspected (current-inspecting))
    (define copy (and inspected (profun-iterator-copy inspected)))

    (define iter
      (cond
       (inspected
        (profun-iterator-reset! inspected args)
        inspected)
       (else
        (profun-iterate (current-db) args))))

    (set-current-answer-iterator! iter)
    (set-current-inspecting! copy)

    (handle-query next))

  (define (handle-inspect op args next)
    (define (cont iter)
      (define copy (profun-iterator-copy iter))
      (push-stage! copy copy)
      (handle next))

    (cond
     ((not (null? args))
      `(error (inspect-must-have-0-arguments but-it-has ,(length args))))
     ((current-CONT) (cont (current-CONT)))
     ((current-answer-iterator) (cont (current-answer-iterator)))
     (else
      `(error (nothing-to-inspect use-a-whats-first)))))

  (define (handle-return op args next)
    (cond
     ((not (null? args))
      `(error (return must have 0 arguments but it has ,(length args))))
     ((stack-empty? stages)
      `(error (nowhere to return)))
     (else
      (stack-pop! stages)
      (handle next))))

  (define (handle-reset op args next)
    (cond
     ((not (null? args))
      `(error (reset must have 0 arguments but it has ,(length args))))
     (else
      (stack-unload! stages)
      (handle next))))

  (define (handle-push op args next)
    (cond
     ((not (null? args))
      `(error (push must have 0 arguments but it has ,(length args))))
     (else
      (push-stage! #f #f)
      (handle next))))

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
     ((not (current-answer-iterator)) `(error (nothing-to-show use-a-whats-first)))
     ((not (null? next)) `(error (more-must-be-the-last-command)))
     ((not (number? n)) n)
     (else
      (set-current-left! n)
      (collect-n))))

  (define (handle-its-cont op args next)
    (profun-iterator-insert! (current-CONT) args)
    (set-current-answer-iterator! (current-CONT))
    (set-current-CONT! #f)

    (collect-n))

  (define (handle-its op args next)
    (cond
     ((stack-empty? stages)
      `(error (did-not-ask-anything)))
     ((current-CONT)
      (handle-its-cont op args next))
     (else
      (stack-pop! stages)
      (handle-its op args next))))

  (define (validate-rule rule)
    (define list-of-lists?
      (and (list? rule)
           (list-and-map
            (lambda (clause)
              (and (list? clause)
                   (list-length=<? 2 clause)))
            rule)))
    (define names
      (and list-of-lists? (map car rule)))
    (define not-symbol-names
      (and names (filter (negate symbol?) names)))
    (define names-are-symbols?
      (null? not-symbol-names))
    (define names+arities
      (and names-are-symbols?
           (map (lambda (clause)
                  (cons (car clause) (length (cdr clause))))
                (cdr rule))))
    (define db (current-db))
    (define not-found-names
      (and names-are-symbols?
           (list-deduplicate/reverse
            (filter
             identity
             (map
              (lambda (p)
                (define name (car p))
                (define arity (cdr p))
                (define exs
                  (or (profun-database-get-all db name arity)
                      (profun-database-handle db name arity)))
                (if exs #f p))
              names+arities)))))

    (cond
     ((not list-of-lists?)
      `(error (rule-has-a-bad-type "It should be a list of lists, but is not" ,rule)))
     ((not names-are-symbols?)
      `(error (rule-has-non-list-clauses "All rule clauses should be symbols, but some are not" ,not-symbol-names ,rule)))
     ((not (null? not-found-names))
      ;; NOTE: bans recursion
      `(error (rule-uses-undefined-predicates "Rule uses names that are not present in the database, this is not allowed" ,not-found-names ,rule)))
     (else #f)))

  (define (validate-all-rules rules)
    (list-map-first validate-rule #f rules))

  (define (handle-listen op args next)
    (define db (current-db/copy))
    (or (validate-all-rules args)
        (begin
          (for-each (comp (profun-database-add-rule! db)) args)
          (handle next))))

  (define (handle commands)
    (cond
     ((null? commands) `(ok))
     ((not (symbol? (car commands)))
      `(error (commands-must-start-from-an-operation)))
     (else
      (let ()
        (define-values (op args next)
          (split-commands commands))
        (case op
          ((listen) (handle-listen op args next))
          ((whats) (handle-whats op args next))
          ((its) (handle-its op args next))
          ((inspect) (handle-inspect op args next))
          ((return) (handle-return op args next))
          ((reset) (handle-reset op args next))
          ((push) (handle-push op args next))
          ((more) (handle-more op args next))
          (else `(error (operation-not-supported ,op))))))))

  (define (handle-start commands)
    (cond
     ((not (list? commands))
      `(error (commands-must-be-a-list)))
     (else
      (handle commands))))

  (handle-start commands))
