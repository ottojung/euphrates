#lang racket

(require syntax/parse/define
         (for-syntax racket/base
                     racket/syntax))

(require compatibility/defmacro)

(require mzlib/etc) ;; this-expression-file-name, this-expression-source-directory
(provide (all-from-out mzlib/etc))

(provide (all-defined-out))

(define 1+ add1)
(define 1- sub1)

(define [string-null? s] (not (non-empty-string? s)))

(define [throw type . args]
  (error type "~a" args))

(define [catch-any body handler]
  (with-handlers ((exn:fail? handler))
    (body)))

(define [make-hash-table] (make-hash))

(define dynamic-thread-mutex-make-p
  (make-parameter
   (lambda () (make-semaphore 1))))
(define dynamic-thread-mutex-lock!-p
  (make-parameter semaphore-wait))
(define dynamic-thread-mutex-unlock!-p
  (make-parameter semaphore-post))

;; (ATOMIC BOX

(define make-atomic-box
  box)
(define atomic-box?
  box?)
(define atomic-box-ref
  unbox)
(define atomic-box-set!
  set-box!)
(define atomic-box-compare-and-set!
  box-cas!)

;; ATOMIC BOX)

(define cons* list*)

(define [procedure-get-minimum-arity proc]
  (let [[mask (procedure-arity-mask proc)]]
    (let lp2 [[count 0]]
      (if (bitwise-bit-set? mask count)
          count
          (lp2 (add1 count))))))

(define [call-with-blocked-asyncs thunk]
  ;; TODO: print system message that this does not work
  (thunk))

(define [time-get-monotonic-nanoseconds-timestamp]
  (ceiling
   (* 1000000
      (current-inexact-milliseconds))))

(define [get-u8 from] (read-byte from))
(define [put-u8 to byte] (write-byte byte to))

(define string-endswith? string-suffix?)
(define string-startswith? string-prefix?)
(define (string-trim-chars str chars-arg direction)
  (define (regs cc)
    (let lp ((left cc))
      (if (null? left)
          (list)
          (if (null? (cdr left))
              (list (car left)) ;; last char
              (list* (car left) #\| (lp (cdr left)))))))
  (define chars (if (string? chars-arg)
                    (string->list chars-arg)
                    chars-arg))
  (define reg (regexp (apply string (regs chars))))
  (case direction
    ((left) (string-trim str reg #:left? #t #:right? #f #:repeat? #t))
    ((right) (string-trim str reg #:left? #f #:right? #t #:repeat? #t))
    ((both) (string-trim str reg #:left? #t #:right? #t #:repeat? #t))))

(define fold foldl)
(define and-map andmap)
(define or-map ormap)
(define hash-table->alist hash->list)
(define [hash-get-handle h key]
  (if (hash-has-key? h key)
      (cons key (hash-ref h key))
      #f))

(define [getcwd] (path->string (current-directory)))
(define chdir current-directory)
(define absolute-file-name? absolute-path?)
(define file-mtime file-or-directory-modify-seconds)

(define [usleep microsecond]
  (sleep (/ microsecond (* 1000 1000))))

(define call-with-new-sys-thread thread)
(define cancel-sys-thread kill-thread)
(define sys-thread-exited? thread-dead?)
(define sys-thread-sleep usleep)

(define [string-split#simple str delim]
  (if (char? delim)
      (string-split str (string delim) #:trim? #f)
      (string-split str delim #:trim? #f)))

;; TODO: move to lib somehow
(define (words str)
  (string-split str))

(define-syntax-rule [define-eval-namespace name]
  (begin
    (define-namespace-anchor ns-anc)
    (define name (namespace-anchor->namespace ns-anc))))

;; namespace is get with `define-eval-namespace'
(define [eval-string-in-namespace str namespace]
  (eval (call-with-input-string str read)
        namespace))

(define racket-base-namespace (make-base-namespace))

(define [eval-string-base str]
  (eval-string-in-namespace str racket-base-namespace))

(define-syntax-rule [load-file-in-namespace filepath namespace]
  (eval-string-in-namespace
   (string-append "(begin\n" (file->string filepath) ")")
   namespace))

(define get-command-line-arguments
  (make-parameter
   (vector->list (current-command-line-arguments))))

(define [get-current-program-path]
  (path->string (find-system-path 'run-file)))

;; TODO: why this shit doesn't work?
;; (define-syntax [get-current-source-file-path stx]
;;   #`(path->string
;;      (build-path
;;       #,(this-expression-source-directory stx)
;;       #,(this-expression-file-name stx))))

(define-macro (get-current-source-file-path)
  '(path->string
    (build-path
     (this-expression-source-directory)
     (this-expression-file-name))))

(define [big-random-int max]
  (exact-floor (* (random) max))) ;; random in racket is bounded to 4294967087

(define-syntax-rule [with-output-to-file#clear file . bodies]
  (with-output-to-file
      #:exists 'truncate/replace
      file
      (lambda [] . bodies)))

;; Author: samth
;; source repository: https://github.com/racket/math
;; source file: https://github.com/racket/math/blob/master/math-lib/math/private/number-theory/modular-arithmetic-base.rkt
(define (modular-expt* n a b)
  (cond [(b . < . 0)  (raise-argument-error 'modular-expt "Natural" 1 a b n)]
        [else
         (let loop ([a a] [b b])
           (cond [(b . <= . 1)  (if (zero? b) (modulo 1 n) (modulo a n))]
                 [(even? b)  (define c (loop a (quotient b 2)))
                  (modulo (* c c) n)]
                 [else  (modulo (* a (loop a (sub1 b))) n)]))]))

;; Author: samth
;; source repository: https://github.com/racket/math
;; source file: https://github.com/racket/math/blob/master/math-lib/math/private/number-theory/modular-arithmetic-base.rkt
(define (modulo-expt a b n)
  (cond [(n . <= . 0)  (raise-argument-error 'modular-expt "Positive-Integer" 2 a b n)]
        [else  (modular-expt* n a b)]))


(define [close-port port]
  (cond
   [(output-port? port) (close-output-port port)]
   [(input-port? port) (close-input-port port)]
   [else (throw 'type-error `(args: port)
                `(expected type port? but got something else))]))

(define find-first findf)

;; TODOS

;;;;;;;;;;;;;;;;
;; FILESYSTEM ;;
;;;;;;;;;;;;;;;;

(define [file-or-directory-exists? path]
  (or (file-exists? path)
      (directory-exists? path)))

(define (open-file path mode)
  (match mode
    ["r" (open-input-file path #:mode 'text)]
    ["w" (open-output-file path #:mode 'text #:exists 'truncate/replace)]
    ["a" (open-output-file path #:mode 'text #:exists 'append)]
    ["rb" (open-input-file path #:mode 'binary)]
    ["wb" (open-output-file path #:mode 'binary #:exists 'truncate/replace)]
    ["ab" (open-output-file path #:mode 'binary #:exists 'append)]
    [other (throw 'open-file-mode-not-supported `(args: ,path ,mode))]))

(define [directory-files directory]
  "Returns object like this:
   ((fullname name)
    (fullname name)
     ....
  "

  (let* [[names (directory-list directory)]
         [fullnames
          (map (lambda [name]
                 (cons
                  (path->string
                   (build-path directory name))
                  name))
               names)]]
    fullnames))

(define [directory-files-rec directory]
  "Returns object like this:
   ((fullname name dirname1 dirname2 dirname3...
    (fullname name ....

   Where dirname1 is the parent dir of the file
  "

  (define (tostring path)
    (case path
      ((same) directory)
      (else (path->string path))))

  (fold-files
   (lambda [f type ctx]
     (cons (map tostring
                (cons f (reverse (explode-path f))))
           ctx))
   (list)
   directory))

(define [path-parent-directory path]
  (let-values [[[base name must-be-dir?]
                (split-path path)]]
    (if (path? base)
        (path->string base)
        (match base
          ['relative "."]
          [#f        "/"]))))

(define (make-temporary-fileport)
  (let ((filepath (make-temporary-file)))
    (values (open-file filepath "w") (path->string filepath))))

;;;;;;;;;;;;;
;; RECORDS ;;
;;;;;;;;;;;;;

(define-syntax-rule [define-rec name . fields]
  (struct name fields
          #:mutable
          #:prefab))

(define record? struct?)

;;;;;;;;;;;;;;;
;; PROCESSES ;;
;;;;;;;;;;;;;;;

(define-rec comprocess
  p
  command
  args
  pipe
  pid
  status
  exited?
  )

;; TODO: support asynchronous stdin
(define [run-comprocess#full p-stdout p-stderr command . args]
  (let-values
      [[[p stdout stdin stderr]
        (apply subprocess
               (list*
                p-stdout #f p-stderr ;; stdout stdin stderr
                'new                ;; new group, means that (kill ..) will kill its children also

                command
                args))]]
    (let [[re (comprocess p
                          command
                          args
                          stdin
                          (subprocess-pid p)
                          #f
                          #f)]]

      (define [run-in-thread]
        (subprocess-wait p)

        (when (and stdout (not p-stdout))
          (close-input-port stdout))
        (when stdin
          (close-output-port stdin))
        (when (and stderr (not p-stderr))
          (close-input-port stderr))

        (set-comprocess-exited?! re #t)
        (set-comprocess-status! re (subprocess-status p)))

      (thread run-in-thread)
      re)))

(define [run-comprocess command . args]
  (apply run-comprocess#full
         (list* (current-output-port) (current-error-port) command args)))

(define [kill-comprocess p force?]
  (subprocess-kill (comprocess-p p) force?))

