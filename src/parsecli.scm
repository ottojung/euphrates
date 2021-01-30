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

%use (make-regex-machine) "./regex-machine.scm"
%use (group-by/sequential group-by/sequential*) "./group-by-sequential.scm"
%use (raisu) "./raisu.scm"
%use (list-init) "./list-init.scm"

%var make-cli
%var parsecli:make-IR
%var parsecli:IR->Regex

(define (parsecli:make-IR body)
  (define (type-cli body)
    (if (pair? body)
        (cons 'lst (map type-cli body))
        (let ((s (symbol->string body)))
          (cond
           ((and (string-prefix? "<" s)
                 (string-suffix? "*>" s))
            (cons 'word* s))
           ((and (string-prefix? "<" s)
                 (string-suffix? ">" s))
            (cons 'word s))
           ((string-suffix? "?" s)
            (cons 'flag
                  (list->string
                   (list-init
                    (string->list s)))))
           ((string-prefix? "-" s)
            (cons 'param s))
           (else
            (cons 'const s))))))

  (define typed (map type-cli body))

  (define (singleton? lst)
    (and (not (null? lst))
         (null? (cdr lst))))

  (define (group-step predicate/ex flaten)
    (lambda (lst)
      (define gs
        (group-by/sequential*
         (lambda (x xs)
           (predicate/ex (car x)
                         (if (null? xs) 'nil (car (car xs)))))
         lst))

      (define flat
        (map
         (lambda (p)
           (if (singleton? p)
               (car p)
               (flaten p)))
         gs))

      (define self
        (group-step predicate/ex flaten))

      (map
       (lambda (p)
         (if (equal? 'lst (car p))
             (cons 'lst (self (cdr p)))
             p))
       flat)))

  (define group/param
    (group-step
     (lambda (xt yt)
       (case xt
         ((param)
          (case yt
            ((nil) (raisu 'CANNOT-END-IN-PARAM xt))
            ((word word*) #t)
            (else (raisu 'EXPECTED-PARAM-ARGUMENT xt yt))))
         (else #f)))

     (lambda (p)
       (cons 'param (cons (cdr (car p)) (car (cdr p)))))))

  (define group/flags
    (group-step
     (lambda (xt yt)
       (case xt
         ((flag param)
          (case yt
            ((flag param) #t)
            (else #f)))
         (else #f)))
     (lambda (p)
       (cons 'fg p))))

  (define group/lsts
    (group-step
     (lambda (xt yt)
       (and (equal? xt 'lst)
            (equal? yt 'lst)))
     (lambda (p)
       (cons 'or (map cdr p)))))

  (define grouped
    ((compose group/lsts group/flags group/param) typed))

  grouped)

(define (parsecli:IR->Regex IR)
  (let loop ((IR IR))
    (if (list? IR)
        (case (car IR)
          ((or) `(or ,@(map loop (cdr IR))))
          ((fg) `(* (or ,@(map loop (cdr IR)))))
          (else `(and ,@(map loop IR))))
        (case (car IR)
          ((const) `(= ,(cdr IR) ,(cdr IR)))
          ((word) `(any ,(cdr IR)))
          ((word*) `(* (any* ,(cdr IR))))
          ((flag) `(= ,(cdr IR) ,(cdr IR)))
          ((param) `(and (= ,(cadr IR) ,(cadr IR)) ,(loop (cddr IR))))
          (else (raisu 'BAD-IR-TYPE IR))))))

(define make-cli
  (compose make-regex-machine
           parsecli:IR->Regex
           parsecli:make-IR))
