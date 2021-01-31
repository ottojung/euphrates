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

%use (parse-cli:IR->Regex parse-cli:make-IR) "./parse-cli.scm"
%use (get-command-line-arguments) "./get-command-line-arguments.scm"
%use (make-regex-machine) "./regex-machine.scm"
%use (flatten-syntax-f-arg) "./flatten-syntax-f.scm"
%use (hashmap) "./hashmap.scm"
%use (hashmap-ref hashmap-set! hashmap->alist) "./ihashmap.scm"
%use (debugv) "./debugv.scm"
%use (debug) "./debug.scm"
%use (~a) "./tilda-a.scm"
%use (unlines) "./unlines.scm"
%use (unwords) "./unwords.scm"
%use (conss) "./conss.scm"
%use (list-deduplicate) "./list-deduplicate.scm"
%use (list-init) "./list-init.scm"

%var make-cli/f/basic
%var make-cli/f
%var make-cli
%var lambda-cli
%var define-cli:current-hashmap
%var define-cli:lookup
%var with-cli
%var define-cli:raisu/p
%var define-cli:raisu/default-exit

(define (make-cli/f/basic cli-decl synonyms)
  ((compose make-regex-machine
            (parse-cli:IR->Regex synonyms)
            parse-cli:make-IR)
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
  (define (tostring x)
    (cond
     ((number? x) (number->string x))
     ((symbol? x) (symbol->string x))
     (else x)))


  (define (member/typed x lst)
    (let loop ((lst lst))
      (if (null? lst) #f
          (if (equal? (tostring x) (tostring (car lst)))
              (car lst)
              (loop (cdr lst))))))

  (define (handle-1-type name type)
    (lambda (value)
      (when value
        (case type
          ((number)
           (let ((n (string->number (tostring value))))
             (unless n
               (define-cli:raisu 'BAD-TYPE-OF-ARGUMENT value 'FOR name 'EXPECTED type))
             n))
          ((symbol)
           (string->symbol (tostring value)))
          (else
           (unless (list? type)
             (define-cli:raisu 'EXPECTED-LIST-AS-TYPE type 'FOR name))
           (or (member/typed value type)
               (define-cli:raisu 'BAD-TYPE-OF-ARGUMENT value 'FOR name 'EXPECTED type)))))))

  (define (handle-type H)
    (lambda (p)
      (define name (tostring (car p)))
      (define type (cadr p))
      (define value (hashmap-ref H name #f))
      (define new-value
        (if (list? value)
            (map (handle-1-type name type) value)
            ((handle-1-type name type) value)))
      (hashmap-set! H name new-value)))

  (define (handle-default H)
    (lambda (d)
      (unless (hashmap-ref H (tostring (car d)) #f)
        (hashmap-set! H (tostring (car d)) (tostring (cadr d))))))

  (define (make-help)
    (define arg-helps (filter list? helps))
    (define single-helps (filter (negate list?) helps))

    (define (flatten* T)
      (if (list? T)
          (apply append (map flatten* T))
          (list T)))

    (define flattened
      (list-deduplicate
       (flatten* cli-decl)))

    (define fH (hashmap))

    (for-each
     (lambda (name)
       (map
        (lambda (L T)
          (define A (assoc name L))
          (when A
            (hashmap-set! fH name (cons (cons T (cadr A))
                                        (hashmap-ref fH name (list))))))
        (list arg-helps types defaults)
        '(#f type default)))
     flattened)

    (define (fmt-property x)
      (if (car x)
          (string-append "[" (~a (car x)) ": " (~a (cdr x)) "]")
          (~a (cdr x))))

    (define (assoc/empty name lst)
      (let ((x (assoc name lst)))
        (if x (fmt-property x) "")))

    (define (print-list lst)
      (map (lambda (s)
             (if (list? s)
                 (let* ((name (car s))
                        (props (cdr s)))
                   (string-append
                    "\t"
                    (~a name)
                    "\t"
                    (unwords
                     (list
                      (assoc/empty #f props)
                      (assoc/empty 'type props)
                      (assoc/empty 'default props)))))
                 (string-append "\t" s)))
           lst))

    (unlines
     (conss
      "USAGE:"
      (~a cli-decl)
      ""
      (append
       (print-list (hashmap->alist fH))
       (list "")
       (print-list single-helps)))))

  (define M (make-cli/f/basic cli-decl synonyms))

  (lambda (H T)
    (define R (M H T))

    (unless R
      (define-cli:raisu 'NO-MATCH (make-help)))

    (for-each (handle-default H) defaults)
    (for-each (handle-type H) types)

    M)) ;; TODO

(define-syntax make-cli-helper
  (syntax-rules (:default :example :help :type :exclusive :synonym)
    ((_ f cli-decl defaults examples helps types exclusives synonyms (:synonym x . xs))
     (make-cli-helper
      f cli-decl defaults examples helps types exclusives ((quote x) . synonyms) xs))
    ((_ f cli-decl defaults examples helps types exclusives synonyms (:help x . xs))
     (make-cli-helper
      f cli-decl defaults examples ((quote x) . helps) types exclusives synonyms xs))
    ((_ f cli-decl defaults examples helps types exclusives synonyms (:type (x y) . xs))
     (make-cli-helper
      f cli-decl defaults examples helps ((list (quote x) y) . types) exclusives synonyms xs))
    ((_ f cli-decl defaults examples helps types exclusives synonyms (:default x . xs))
     (make-cli-helper
      f cli-decl ((quote x) . defaults) examples helps types exclusives synonyms xs))
    ((_ f cli-decl defaults examples helps types exclusives synonyms bodies)
     (f
      cli-decl
      (list . defaults) (list . examples) (list . helps)
      (list . types) (list . exclusives) (list . synonyms)
      bodies))))
(define-syntax-rule (make-cli-helper-start f cli-decl args)
  (make-cli-helper f cli-decl () () () () () () args))

(define-syntax make-cli/f/wrapper
  (syntax-rules ()
    ((_ cli-decl defaults examples helps types exclusives synonyms ())
     (make-cli/f (quote cli-decl) defaults examples helps types exclusives synonyms))))
(define-syntax-rule (make-cli cli-decl . args)
  (make-cli-helper-start make-cli/f/wrapper cli-decl args))

(define define-cli:current-hashmap
  (make-parameter #f))
(define (define-cli:lookup x)
  (hashmap-ref (define-cli:current-hashmap) x #f))

(define-syntax-rule (define-cli:let1 x)
  (let* ((s0 (symbol->string (quote x)))
         (s1 (if (string-suffix? "?" s0)
                 ((compose list->string list-init string->list) s0)
                 s0)))
    (define-cli:lookup s1)))

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
         (parameterize ((define-cli:current-hashmap H))
           (and (M H args)
                (define-cli:let-tree cli-decl . bodies))))))))

(define-syntax-rule (lambda-cli cli-decl . args)
  (make-cli-helper-start make-cli/lambda-cli/wrapper cli-decl args))

(define-syntax-rule (with-cli cli-decl . args)
  ((lambda-cli cli-decl . args)
   (get-command-line-arguments)))
