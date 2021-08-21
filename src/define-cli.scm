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

%use (CFG-CLI->CFG-lang) "./compile-cfg-cli.scm"
%use (get-command-line-arguments) "./get-command-line-arguments.scm"
%use (make-cfg-machine*) "./cfg-machine.scm"
%use (flatten-syntax-f-arg) "./flatten-syntax-f.scm"
%use (hashmap) "./hashmap.scm"
%use (hashmap-ref hashmap-set!) "./ihashmap.scm"
%use (~a) "./tilda-a.scm"
%use (list-init) "./list-init.scm"
%use (list-last) "./list-last.scm"
%use (CFG-AST->CFG-CLI-help) "./compile-cfg-cli-help.scm"

%var make-cli/f/basic
%var make-cli/f
%var make-cli
%var make-cli-with-handler
%var lambda-cli
%var define-cli:current-hashmap
%var define-cli:lookup
%var with-cli
%var define-cli:raisu/p
%var define-cli:raisu/default-exit

(define (tostring x)
  (cond
   ((number? x) (number->string x))
   ((symbol? x) (symbol->string x))
   (else x)))

(define (make-cli/f/basic cli-decl synonyms)
  ((compose make-cfg-machine*
            (CFG-CLI->CFG-lang synonyms))
   cli-decl))

(define (define-cli:raisu/default-exit type . args)
  (case type
    ((NO-MATCH)
     (display (car args) (current-error-port))
     (newline (current-error-port)))
    (else
     (display "Bad arguments. " (current-error-port))
     (display args (current-error-port))
     (newline (current-error-port))))
  (exit 1))

(define define-cli:raisu/p
  (make-parameter define-cli:raisu/default-exit))

(define (define-cli:raisu . args)
  (apply (define-cli:raisu/p) args))

(define (make-cli/f cli-decl defaults examples helps types exclusives synonyms)
  (define (member/typed x lst)
    (let loop ((lst lst))
      (if (null? lst) #f
          (if (equal? (tostring x) (tostring (car lst)))
              (car lst)
              (loop (cdr lst))))))

  (define (handle-type/1 name type)
    (lambda (value)
      (if (not value)
          (values #f #f)
          (case type
            ((number)
             (let ((n (string->number (tostring value))))
               (if n
                   (values n #f)
                   (values #f (list 'BAD-TYPE-OF-ARGUMENT value 'FOR name 'EXPECTED type)))))
            ((symbol)
             (values (string->symbol (tostring value)) #f))
            (else
             (unless (list? type)
               (values #f (list 'EXPECTED-LIST-AS-TYPE type 'FOR name)))
             (let ((m (member/typed value type)))
               (if m
                   (values m #f)
                   (values #f (list 'BAD-TYPE-OF-ARGUMENT value 'FOR name 'EXPECTED type)))))))))

  (define (handle-type/union name types value)
    (let loop ((types types) (errors '()))
      (if (null? types) (values #f (reverse errors))
          (let ()
            (define-values (R error)
              ((handle-type/1 name (car types)) value))
            (if error
                (loop (cdr types) (cons error errors))
                (values R #f))))))

  (define (handle-type/values name types vals)
    (let loop ((vals vals) (buf '()))
      (if (null? vals) (values (reverse buf) #f)
          (let ()
            (define-values (R error)
              (handle-type/union name types (car vals)))

            (if error
                (values #f error)
                (loop (cdr vals) (cons R buf)))))))

  (define (handle-type H)
    (lambda (p)
      (define name (tostring (car p)))
      (define types (cdr p))
      (define value (hashmap-ref H name #f))

      (define-values (R error)
        (if (list? value)
            (handle-type/values name types value)
            (handle-type/union name types value)))

      (when error
        (apply define-cli:raisu
               (append
                (list-last error)
                (list (list-init error)))))

      (hashmap-set! H name R)))

  (define (handle-default H)
    (lambda (d)
      (unless (hashmap-ref H (tostring (car d)) #f)
        (hashmap-set! H (tostring (car d)) (tostring (cadr d))))))

  (define (handle-exclusive H)
    (lambda (excl)
      (define main-name (tostring (car excl)))
      (define secondary-names (cdr excl))
      (define true-value (define-cli:lookup/H H main-name))

      (when true-value
        (unless (or (equal? true-value #t)
                    (equal? true-value main-name))
          (hashmap-set! H main-name #f)
          (hashmap-set! H true-value true-value)))))

  (define all-synonyms (append exclusives synonyms))
  (define M (make-cli/f/basic cli-decl all-synonyms))

  (lambda (H T)
    (define _123 (for-each (handle-default H) defaults))
    (define R (M H T))

    (unless R
      (define-cli:raisu 'NO-MATCH
        ((CFG-AST->CFG-CLI-help helps types defaults) cli-decl)))

    (for-each (handle-exclusive H) exclusives)
    (for-each (handle-type H) types)

    (when #f #f)))

(define-syntax make-cli-with-handler-helper
  (syntax-rules (:default :example :help :type :exclusive :synonym)
    ((_ f cli-decl defaults examples helps types exclusives synonyms (:synonym x . xs))
     (make-cli-with-handler-helper
      f cli-decl defaults examples helps types exclusives ((quote x) . synonyms) xs))
    ((_ f cli-decl defaults examples helps types exclusives synonyms (:exclusive x . xs))
     (make-cli-with-handler-helper
      f cli-decl defaults examples helps types ((quote x) . exclusives) synonyms xs))
    ((_ f cli-decl defaults examples helps types exclusives synonyms (:help x . xs))
     (make-cli-with-handler-helper
      f cli-decl defaults examples ((quote x) . helps) types exclusives synonyms xs))
    ((_ f cli-decl defaults examples helps types exclusives synonyms (:type (x . ys) . xs))
     (make-cli-with-handler-helper
      f cli-decl defaults examples helps ((list (quote x) . ys) . types) exclusives synonyms xs))
    ((_ f cli-decl defaults examples helps types exclusives synonyms (:default (x y) . xs))
     (make-cli-with-handler-helper
      f cli-decl ((list (quote x) y) . defaults) examples helps types exclusives synonyms xs))
    ((_ f cli-decl defaults examples helps types exclusives synonyms bodies)
     (f
      cli-decl
      (list . defaults) (list . examples) (list . helps)
      (list . types) (list . exclusives) (list . synonyms)
      bodies))))
(define-syntax-rule (make-cli-with-handler f cli-decl . args)
  (make-cli-with-handler-helper f cli-decl () () () () () () args))

(define-syntax make-cli/f/wrapper
  (syntax-rules ()
    ((_ cli-decl defaults examples helps types exclusives synonyms ())
     (make-cli/f (quote cli-decl) defaults examples helps types exclusives synonyms))))
(define-syntax-rule (make-cli cli-decl . args)
  (make-cli-with-handler make-cli/f/wrapper cli-decl . args))

(define define-cli:current-hashmap
  (make-parameter #f))
(define (define-cli:lookup/H H x)
  (hashmap-ref H (~a x) #f))
(define (define-cli:lookup x)
  (define-cli:lookup/H (define-cli:current-hashmap) x))

(define-syntax-rule (define-cli:let1 x)
  (define-cli:lookup (quote x)))

(define-syntax define-cli:let-list
  (syntax-rules ()
    [(_ f bodies ()) (begin . bodies)]
    [(_ f bodies (a . as))
     (let [[a (f a)]] (define-cli:let-list f bodies as))]))

(define-syntax-rule (define-cli:let-list-wrapper bodies args)
  (define-cli:let-list define-cli:let1 bodies args))

(define-syntax-rule (define-cli:let-tree T . bodies)
  (flatten-syntax-f-arg define-cli:let-list-wrapper bodies T))

(define-syntax make-cli/lambda-cli/wrapper
  (syntax-rules ()
    ((_ cli-decl defaults examples helps types exclusives synonyms bodies)
     (let* ((H (hashmap))
            (M (make-cli/f (quote cli-decl) defaults examples helps types exclusives synonyms)))
       (lambda (args)
         (when (M H args)
           (parameterize ((define-cli:current-hashmap H))
             (define-cli:let-tree cli-decl . bodies))))))))

(define-syntax-rule (lambda-cli cli-decl . args)
  (make-cli-with-handler make-cli/lambda-cli/wrapper cli-decl . args))

(define-syntax-rule (with-cli cli-decl . args)
  ((lambda-cli cli-decl . args)
   (get-command-line-arguments)))
