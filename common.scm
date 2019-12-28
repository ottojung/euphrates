(define-module [my-guile-std common])

(export
 letin
 defloop
 apploop
 reversed-args
 fn
 fn-list
 with-return
 monoids*
 monoids-r*
 monoid-r*
 monoid*
 letin-with-full
 letin-parameterize
 letin-with-full-parameterized
 letin-with
 dom
 domid
 domf
 dom-default
 dom-print
 generate-prefixed-name
 gfunc/define
 gfunc/instance
 gfunc/parameterize
 printf
 global-debug-mode-filter
 debug
 stringf
 ~a
 range
 list-init
 read-file
 write-file
 mdict
 mdict?
 mass
 mdict-has?
 mdict-set!
 mdict-keys
 with-bracket
 )

(use-modules [ice-9 format]
             [ice-9 textual-ports]
             [srfi srfi-1]
             [srfi srfi-13]
             [ice-9 hash-table]
             [srfi srfi-18]
             [srfi srfi-42]
             [srfi srfi-16])

(define-syntax letin
  (syntax-rules ()
    [(letin body) body]
    [(letin ((a . as) b) body ...)
     (let-values [[[a . as] b]] (letin body ...))]
    [(letin (a b) body ...)
     (let [[a b]] (letin body ...))]))

(define-syntax defloop
  (lambda (stx)
    (syntax-case stx ()
      [(defloop lambda-list . body)
       (with-syntax ([name (datum->syntax #'body 'loop)])
         #'(letrec ([name (lambda lambda-list . body)])
             name))])))

(define-syntax-rule [apploop args argv . body]
  ((defloop args . body) . argv))

(define-macro (reversed-args . body)
  (reverse body))

(define-syntax reversed-lambda
  (syntax-rules ()
    [(reversed-lambda body args) (lambda [] body)]
    [(reversed-lambda body args next) (lambda (next . args) body)]
    [(reversed-lambda body args x next ...) (reversed-lambda body (x . args) next ...)]))

(define-syntax fn-start
  (syntax-rules ()
    [(fn-start args body) (reversed-lambda body () . args)]
    [(fn-start args x body ...) (fn-start (x . args) body ...)]))

(define-syntax-rule [fn . argv] (fn-start () . argv))

(define-syntax fn-list-g
  (syntax-rules ()
    [(fn-list-g lst body) body]
    [(fn-list-g lst x body ...)
     (let [[x (car lst)]]
       (fn-list-g
        (cdr lst)
        body
        ...))]))

(define-syntax-rule [fn-list . args]
  (lambda [lst] (fn-list-g lst . args)))

(define-syntax with-return
  (lambda (stx)
    (syntax-case stx ()
      [(define-job . bodies)
       (with-syntax [[return (datum->syntax #'bodies 'return)]]
         #'(call/cc (lambda [return] (begin . bodies))))])))

(define-syntax monoids*
  (syntax-rules ()
    [(monoids* x) x]
    [(monoids* op x) (op x)]
    [(monoids* a op b next-op ...)
     (monoids* (op a b) next-op ...)]))

(define-syntax monoids-r*
  (syntax-rules ()
    [(monoids-r* x) x]
    [(monoids-r* op x) (op x)]
    [(monoids-r* a op b next-op ...)
     (op a (monoids-r* b next-op ...))]))

(define-syntax monoid-r*
  (syntax-rules ()
    [(monoid-r* op a) a]
    [(monoid-r* op a b ...)
     (op a (monoid-r* op b ...))]))

(define-syntax monoid*
  (syntax-rules ()
    [(monoid* op a) a]
    [(monoid* op a b c ...)
     (monoid* op (op a b) c ...)]))

;; like do syntax in haskell
(define-syntax letin-with-full
  (syntax-rules ()
    [(letin-with-full f body) body]
    [(letin-with-full f (a b) body ...)
     (f (quote a)
        (quote b)
        b
        (lambda [a]
          (letin-with-full f
                           body
                           ...)))]))

(define letin-global-monad-parameter (make-parameter #f))
(define-syntax-rule [letin-parameterize f . body]
  (parameterize [[letin-global-monad-parameter f]]
    (begin . body)))

;; with parameterization
(define-syntax-rule [letin-with-full-parameterized f . argv]
  (let [[p (letin-global-monad-parameter)]]
    (if p
        (letin-with-full (p f (quote f)) . argv)
        (letin-with-full f . argv))))

(define-syntax-rule [letin-with f . argv]
  (letin-with-full-parameterized (lambda [name result x cont] (f x cont)) . argv))

(define-syntax-rule [letin-with-identity . argv]
  (letin-with (fn x cont (cont x)) . argv))

(define-syntax-rule [dom . argv] (letin-with . argv))

(define-syntax-rule [domid . argv] (letin-with-identity . argv))

(define-syntax-rule [domf . argv] (letin-with-full . argv))

;; Short circuits with any predicate
(define [dom-default default?]
  (fn x cont
      (if (default? x)
          x
          (cont x))))

;; Logs computations
(define [dom-print name result x cont]
  (format #t "(~a = ~a = ~a)\n" name x result)
  (cont x))

(define [check-list-contract check-list args]
  (or (not check-list)
      (and (= (length check-list) (length args))
           (fold (lambda [p x c] (and c (p x))) #t check-list args))))

(define-syntax-rule [generate-prefixed-name prefix name]
  (datum->syntax #'name
                 (symbol-append prefix (syntax->datum #'name))))

(define-syntax-rule [generate-add-name name]
  (generate-prefixed-name 'gfunc/instantiate- name))

(define-syntax-rule [generate-param-name name]
  (generate-prefixed-name 'gfunc/parameterize- name))

(define-syntax gfunc/define
  (lambda (stx)
    (syntax-case stx ()
      [[gfunc/define name]
       (with-syntax ([add-name (generate-add-name name)]
                     [param-name (generate-param-name name)])
         #'(define-values [name add-name param-name]
             (let [[internal-list (make-parameter '())]
                   [sem (make-mutex)]]
               (values
                (lambda args
                  (let [[m (find (lambda [p] (check-list-contract (car p) args)) (internal-list))]]
                    (if m
                        (apply (cdr m) args)
                        (throw 'gfunc-no-instance-found
                                (string-append "No gfunc instance of "
                                               (symbol->string (syntax->datum #'name))
                                               " accepts required arguments")))))
                (lambda [args func]
                  (mutex-lock! sem)
                  (set! internal-list (make-parameter (append (internal-list) (list (cons args func)))))
                  (mutex-unlock! sem))
                (lambda [args func body]
                  (let [[new-list (cons (cons args func) (internal-list))]]
                    (parameterize [[internal-list new-list]]
                      (body))))))))])))

(define-syntax gfunc/parameterize
  (lambda (stx)
    (syntax-case stx ()
      [[gfunc/parameterize name check-list func . body]
       (with-syntax [[param-name (generate-param-name name)]]
         #'(param-name check-list func (lambda [] . body)))])))

(define-syntax gfunc/instance
  (lambda (stx)
    (syntax-case stx ()
      [[gfunc/instance name check-list func]
       (with-syntax [[add-name (generate-add-name name)]]
         #'(add-name (list . check-list) func))])))

;;;;;;;;;;;;;;;;;;;;
;; HASHED RECORDS ;;
;;;;;;;;;;;;;;;;;;;;

(define [mdict alist]
  (letin
   [h (alist->hash-table alist)]
   (make-procedure-with-setter
    (lambda [key] (hash-ref h key 'mdict-not-found))
    (lambda [new] h))))

(define [mass *mdict key value]
  (letin
   [h (set! (*mdict) #f)]
   [lst (hash-map->list cons h)]
   [new-f (mdict lst)]
   [new (set! (new-f) #f)]
   (do (hash-set! new key value))
   new-f))

(define [mdict? x]
  (and
   (procedure-with-setter? x)
   (hash-table? (set! (x) #f))))

(define [mdict-has? h-func key]
  (letin
   [h (set! (h-func) 0)]
   (hash-get-handle h key)))

(define [mdict-set! h-func key value]
  (letin
   [h (set! (h-func) 0)]
   (hash-set! h key value)))

(define [mdict-keys h-func]
  (letin
   [h (set! (h-func) 0)]
   (map car (hash-map->list cons h))))

;;;;;;;;;;;;;;;;
;; SHORTHANDS ;;
;;;;;;;;;;;;;;;;

(define-syntax-rule [stringf fmt . args]
  (with-output-to-string
    (lambda []
      (format #t fmt . args))))

(define local-print
  (let [[mu (make-mutex)]]
    (lambda [s]
      (let [[err #f]]
        (mutex-lock! mu)
        (catch #t
          (lambda []
            (display s))
          (lambda argv
            (set! err argv)))
        (mutex-unlock! mu)
        (when err (apply throw err))))))

(define-syntax-rule [printf fmt . args]
  (local-print (stringf fmt . args)))

(define global-debug-mode-filter (make-parameter #f))

(define-syntax-rule [debug fmt . args]
  (let [[p (global-debug-mode-filter)]]
    (when (or (not p) (and p (p fmt (list . args))))
      (printf fmt . args))))

(define-syntax-rule [~a x]
  (stringf "~a" x))

(define [range end]
  (list-ec (:range i end) i))

(define [list-init lst]
  (take lst (1- (length lst))))

;;;;;;;;;;;;;
;; BRACKET ;;
;;;;;;;;;;;;;

(define with-bracket-l
  (let [[dynamic-stack (make-parameter (list))]]
    (lambda [expr finally]
      (let* [[err #f] [normal? #t]
             [finally-executed? #f]
             [finally-wraped
              (lambda args
                (unless finally-executed?
                  (set! finally-executed? #t)
                  (apply finally args)))]]
        (catch #t
          (lambda []
            (call/cc
             (lambda [k]
               (parameterize
                   [[dynamic-stack
                     (cons (cons k finally-wraped) (dynamic-stack))]]
                 (expr (lambda argv
                         (set! normal? #f)
                         (take-while
                          (lambda [p]
                            ((cdr p)) ;; execute finally
                            (not (eq? (car p) k)))
                          (dynamic-stack))
                         (apply k argv)
                         ))))))
          (lambda args
            (set! err args)))
        (when normal? (finally-wraped))
        (when err (apply throw err))))))

(define [with-bracket expr finally]
  "
  Applies `return' function to expr.
  `return' is a call/cc function, but it ensures that `finally' is called.
  Also, if exception is raised, `finally' executes.
  Composable, so that if bottom one calls `return', all `finally's are going to be called in correct order.
  Returns unspecified

  expr ::= ((Any -> Any) -> Any)
  finally ::= (-> Any)
  "
  (with-bracket-l expr finally))

;;;;;;;;;;;;;;;;;;;;;;

(define* [read-file path #:optional [mode 'r]]
  (letin-with-identity
   [in (open-file path (~a mode))]
   [text (get-string-all in)]
   (do (close-port in))
   text))

(define* [write-file path data #:optional [fmt "~a"] [mode 'w]]
  "mode ::= 'w | 'a"
  (letin-with-identity
   [out (open-file path (~a mode))]
   [re (format out fmt data)]
   (do (close-port out))
   re))

