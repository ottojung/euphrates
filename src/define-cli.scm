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
%use (make-regex-machine) "./regex-machine.scm"
%use (flatten-syntax-f-arg) "./flatten-syntax-f.scm"
%use (hashmap) "./hashmap.scm"
%use (hashmap-ref hashmap-set!) "./ihashmap.scm"
%use (debugv) "./debugv.scm"

%var make-cli/f/basic
%var make-cli/f
%var make-cli
%var lambda-cli
%var define-cli:lookup
;; %var define-cli
%var with-cli

(define-syntax-rule (with-cli declaration . args)
  0)

(with-cli
  (run --opts <opts*> --param1 <arg1> --flag1? --no-flag1? <file>
         (may <nth>)
         (june <nth>)
         (<kek*>)
         end-statement)

  :exclusive (--flag1? --no-flag1?)
  :synonym (--opts --options -o)
  :type (<opts*> '(fast -O0! -O1! -O2! -O3!))
  :type (<nth> 'number)

  :help (june "is a cool month")
  :help "general help here"
  :example (run --opts fast -O3! --flag1 some/fi.le june 30 goodbye))

(define (make-cli/f/basic cli-decl synonyms)
  ((compose make-regex-machine
            (parse-cli:IR->Regex synonyms)
            parse-cli:make-IR)
   cli-decl))

(define (make-cli/f cli-decl examples helps types exclusives synonyms)
  (define M (make-cli/f/basic cli-decl synonyms))
  M) ;; TODO

(define-syntax make-cli-helper
  (syntax-rules (:example :help :type :exclusive :synonym)
    ((_ f cli-decl examples helps types exclusives synonyms (:synonym x . xs))
     (make-cli-helper
      f cli-decl examples helps types exclusives (x . synonyms) xs))
    ((_ f cli-decl examples helps types exclusives synonyms bodies)
     (f
      cli-decl
      (quote examples) (quote helps) (quote types)
      (quote exclusives) (quote synonyms)
      bodies))))
(define-syntax-rule (make-cli-helper-start f cli-decl args)
  (make-cli-helper f cli-decl () () () () () args))

(define-syntax make-cli/f/wrapper
  (syntax-rules ()
    ((_ cli-decl examples helps types exclusives synonyms ())
     (make-cli/f (quote cli-decl) examples helps types exclusives synonyms))))
(define-syntax-rule (make-cli cli-decl . args)
  (make-cli-helper-start make-cli/f/wrapper cli-decl args))

(define define-cli:current-hashmap
  (make-parameter #f))
(define (define-cli:lookup x)
  (hashmap-ref (define-cli:current-hashmap) x #f))

(define-syntax-rule (define-cli:let1 x)
  (define-cli:lookup (symbol->string (quote x))))

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
    ((_ cli-decl examples helps types exclusives synonyms bodies)
     (let* ((H (hashmap))
            (M (make-cli/f (quote cli-decl) examples helps types exclusives synonyms)))
       (lambda (args)
         (parameterize ((define-cli:current-hashmap H))
           (and (M H args)
                (define-cli:let-tree cli-decl . bodies))))))))

(define-syntax-rule (lambda-cli cli-decl . args)
  (make-cli-helper-start make-cli/lambda-cli/wrapper cli-decl args))


