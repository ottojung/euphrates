
(define-module [my-guile-std pure]
  #:pure
  #:export
  [
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
   letin-with-identity
   dom
   domid
   domf
   dom-default
   ~a
   range
   list-init
   second-to-microsecond
   microsecond-to-nanosecond
   second-to-nanosecond
   nanosecond-to-microsecond
   generate-prefixed-name
   list-bb
   with-bracket
   with-bracket-dw
   mdict
   mdict?
   mass
   mdict-has?
   mdict-keys
   ]
  #:use-module [guile]
  )

;;;;;;;;;;;;
;; SYNTAX ;;
;;;;;;;;;;;;

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

;;;;;;;;;;;;;;;;
;; SHORTHANDS ;;
;;;;;;;;;;;;;;;;

(define [~a x]
  (with-output-to-string
    (display x)))

(define [range start count]
  (if (>= count 0)
      (cons start (range (1+ start) (1- count)))
      (list)))

(define [list-init lst]
  (list-head lst (1- (length lst))))

(define [second-to-microsecond s]
  (* 1000000 s))

(define [microsecond-to-nanosecond ms]
  (* 1000 ms))

(define [second-to-nanosecond s]
  (microsecond-to-nanosecond (second-to-microsecond s)))

(define [nanosecond-to-microsecond ns]
  (quotient ns 1000))

(define-syntax-rule [generate-prefixed-name prefix name]
  (datum->syntax #'name
                 (symbol-append prefix (syntax->datum #'name))))

;;;;;;;;;;;;;
;; BRACKET ;;
;;;;;;;;;;;;;

(define [with-bracket-dw expr finally]
  (call/cc
   (lambda [k]
     (dynamic-wind
       (lambda [] 0)
       (lambda [] (expr k))
       finally))))

(define with-bracket-lf
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

                         (let lp [[st (dynamic-stack)]]
                           (unless (null? st)
                             (let [[p (car st)]]
                               ((cdr p))
                               (when (not (eq? (car p) k))
                                 (lp (cdr st))))))

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

  This is different from `with-bracket-dw' (dynamic-wind)
  because it executes `finally' before returning the control
  and it does not catch any non local jumps except the `return' and throws

  expr ::= ((Any -> Any) -> Any)
  finally ::= (-> Any)
  "
  (with-bracket-lf expr finally))

;;;;;;;;;;;;;;;;;;;;
;; HASHED RECORDS ;;
;;;;;;;;;;;;;;;;;;;;

(define [alist->hash-table lst]
  (let [[h (make-hash-table)]]
    (for-each
     (lambda (pair)
       (hash-set! h (car pair) (cdr pair)))
     lst)
    h))

(define [mdict alist]
  (letin
   [h (alist->hash-table alist)]
   [unique (lambda [x] (* x (+ x x)))] ;; for unique address
   (make-procedure-with-setter
    (lambda [key]
      (let [[g (hash-ref h key unique)]]
        (if (eq? g unique)
            (throw 'mdict-key-not-found key h)
            g)))
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

(define [mdict-keys h-func]
  (letin
   [h (set! (h-func) 0)]
   (map car (hash-map->list cons h))))

