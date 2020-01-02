(define-module [my-guile-std common]
  :export
  [
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
   mdict-keys
   with-bracket
   ]
  :re-export
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
   ]

  :use-module [my-guile-std pure]
  :use-module [ice-9 format]
  :use-module [ice-9 textual-ports]
  :use-module [srfi srfi-1]
  :use-module [srfi srfi-13]
  :use-module [ice-9 hash-table]
  :use-module [srfi srfi-18]
  :use-module [srfi srfi-42]
  :use-module [srfi srfi-16]
  )

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

;;;;;;;;;;;;;
;; FILE IO ;;
;;;;;;;;;;;;;

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

