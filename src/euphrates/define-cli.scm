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

(cond-expand
 (guile
  (define-module (euphrates define-cli)
    :export (make-cli/f/basic make-cli/f make-cli make-cli-with-handler lambda-cli with-cli define-cli:raisu/p define-cli:raisu/default-exit define-cli:show-help)
    :use-module ((euphrates compile-cfg-cli) :select (CFG-CLI->CFG-lang))
    :use-module ((euphrates get-command-line-arguments) :select (get-command-line-arguments))
    :use-module ((euphrates cfg-machine) :select (make-cfg-machine))
    :use-module ((euphrates syntax-flatten-star) :select (syntax-flatten*))
    :use-module ((euphrates hashmap) :select (make-hashmap hashmap-ref hashmap-set!))
    :use-module ((euphrates tilda-a) :select (~a))
    :use-module ((euphrates list-init) :select (list-init))
    :use-module ((euphrates list-last) :select (list-last))
    :use-module ((euphrates compile-cfg-cli-help) :select (CFG-AST->CFG-CLI-help))
    :use-module ((euphrates immutable-hashmap) :select (alist->immutable-hashmap immutable-hashmap-ref/first immutable-hashmap-foreach))
    :use-module ((euphrates define-pair) :select (define-pair)))))



(define (tostring x)
  (cond
   ((number? x) (number->string x))
   ((symbol? x) (symbol->string x))
   (else x)))

(define (make-cli/f/basic cli-decl synonyms)
  ((compose make-cfg-machine
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

(define define-cli:current-values/p
  (make-parameter #f))

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

  (define (handle-default d)
    (cons (tostring (car d)) (tostring (cadr d))))

  (define (handle-exclusive h H)
    (lambda (excl)
      (define names (map tostring excl))
      (define-pair (true-key true-value0)
        (immutable-hashmap-ref/first h names '(#f . #f)))
      (define true-value
        (if (equal? #t true-value0) true-key true-value0))

      (for-each
       (lambda (name)
         (if (equal? name true-value)
             (hashmap-set! H name true-value)
             (hashmap-set! H name #f)))
       names)))

  (define all-synonyms (append exclusives synonyms))
  (define M (make-cli/f/basic cli-decl all-synonyms))

  ;; returns #f on success and #t on failure
  (lambda (H T)
    (define h0
      (alist->immutable-hashmap (map handle-default defaults)))

    (define-values (h R) (M h0 T))

    (immutable-hashmap-foreach
     (lambda (key value)
       (hashmap-set! H key value))
     h)

    (for-each (handle-exclusive h H) exclusives)
    (for-each (handle-type H) types)

    (not R)))

(define-syntax make-cli-with-handler-helper
  (syntax-rules (:default :example :help :type :exclusive :synonym)
    ((_ f cli-decl defaults examples helps types exclusives synonyms (:synonym x . xs))
     (make-cli-with-handler-helper
      f cli-decl defaults examples helps types exclusives ((quote x) . synonyms) xs))
    ((_ f cli-decl defaults examples helps types exclusives synonyms (:exclusive x . xs))
     (make-cli-with-handler-helper
      f cli-decl defaults examples helps types ((quote x) . exclusives) synonyms xs))
    ((_ f cli-decl defaults examples helps types exclusives synonyms (:help (x . ys) . xs))
     (make-cli-with-handler-helper
      f cli-decl defaults examples ((cons (quote x) (list . ys)) . helps) types exclusives synonyms xs))
    ((_ f cli-decl defaults examples helps types exclusives synonyms (:help x . xs))
     (make-cli-with-handler-helper
      f cli-decl defaults examples (x . helps) types exclusives synonyms xs))
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
(define (define-cli:lookup H x)
  (hashmap-ref H (~a x) #f))

(define-syntax-rule (define-cli:let1 H x)
  (define-cli:lookup H (quote x)))

(define-syntax define-cli:let-list
  (syntax-rules (/ :)
    [(_ f H bodies ()) (let () . bodies)]
    [(_ f H bodies (/ . as)) (define-cli:let-list f H bodies as)]
    [(_ f H bodies (: . as)) (define-cli:let-list f H bodies as)]
    [(_ f H bodies (a . as))
     (let [[a (f H a)]] (define-cli:let-list f H bodies as))]))

(define-syntax define-cli:let-list-wrapper
  (syntax-rules ()
    ((_ (H bodies) args)
     (define-cli:let-list define-cli:let1 H bodies args))))

(define-syntax-rule (define-cli:let-tree H T . bodies)
  (syntax-flatten* (define-cli:let-list-wrapper (H bodies)) T))

(define (define-cli:show-help)
  (define cli-decl (list-ref (define-cli:current-values/p) 0))
  (define helps (list-ref (define-cli:current-values/p) 3))
  (define types (list-ref (define-cli:current-values/p) 4))
  (define defaults (list-ref (define-cli:current-values/p) 1))
  (define-cli:raisu 'NO-MATCH
    ((CFG-AST->CFG-CLI-help helps types defaults) cli-decl)))

(define-syntax make-cli/lambda-cli/wrapper
  (syntax-rules ()
    ((_ cli-decl defaults examples helps types exclusives synonyms bodies)
     (let* ((H (make-hashmap))
            (M (make-cli/f (quote cli-decl) defaults examples helps types exclusives synonyms)))
       (lambda (args)
         (define errors (M H args))
         (parameterize ((define-cli:current-values/p (list (quote cli-decl) defaults examples helps types exclusives synonyms)))
           (define-cli:let-tree H cli-decl
             (if errors
                 (define-cli:show-help)
                 (let () . bodies)))))))))

(define-syntax-rule (lambda-cli cli-decl . args)
  (make-cli-with-handler make-cli/lambda-cli/wrapper cli-decl . args))

(define-syntax-rule (with-cli cli-decl . args)
  ((lambda-cli cli-decl . args)
   (get-command-line-arguments)))
