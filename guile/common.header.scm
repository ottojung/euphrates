
(define-module [my-lisp-std common]
  :export
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
   make-unique
   generic-fold
   generic-fold-macro
   list-fold
   list-fold/rest
   lfold
   simplify-posix-path
   append-posix-path
   with-bracket
   with-bracket-dw
   alist->mdict
   mdict
   mass
   mdict-has?
   mdict->alist
   mdict-keys

   with-lock
   dom-print

   gfunc/define
   gfunc/instance
   gfunc/parameterize

   printf
   println
   global-debug-mode-filter
   debug
   stringf
   time-to-nanoseconds
   time-get-monotonic-timestamp
   port-redirect

   read-file
   write-file
   directory-tree
   directory-files
   directory-files-rec

   np-thread-fork
   np-thread-yield
   np-thread-run!
   np-thread-sleep-rate-ms
   np-thread-sleep-rate-ms-set!
   np-thread-usleep
   np-thread-cancel!
   np-thread-cancel-all!
   np-thread-lockr!
   np-thread-unlockr!

   i-thread-yield
   i-thread-dont-yield
   i-thread-yield-me
   i-thread-dont-yield-me
   i-thread-run!
   i-thread-critical!
   i-thread-critical-b!
   i-thread-critical-points
   i-thread-critical-points-print

   comprocess?
   comprocess-command
   comprocess-args
   comprocess-mode
   comprocess-pid
   comprocess-status
   comprocess-exited?
   run-comprocess
   run-comprocess-with-output-to
   kill-comprocess*
   close-comprocess

   define-rec
   ]

  :use-module [ice-9 format]
  :use-module [ice-9 binary-ports]
  :use-module [ice-9 textual-ports]
  :use-module [ice-9 hash-table]
  :use-module [ice-9 threads]
  :use-module [ice-9 popen]
  :use-module [ice-9 ftw]
  :use-module [ice-9 match]
  :use-module [srfi srfi-1]
  :use-module [srfi srfi-9] ;; records
  :use-module [srfi srfi-13]
  :use-module [srfi srfi-16]
  :use-module [srfi srfi-18]
  :use-module [srfi srfi-19] ;; time
  :use-module [srfi srfi-42]
  :use-module [srfi srfi-111] ;; box
  )

(define [catch-any body handler]
  (catch #t body handler))

(define my-make-mutex (@ (srfi srfi-18) make-mutex))
(define [my-mutex-lock! mut] (mutex-lock! mut))
(define [my-mutex-unlock! mut] (mutex-unlock! mut))

(define time-get-monotonic-nanoseconds-timestamp
  (let [[time-to-nanoseconds
         (lambda [time]
           (+ (time-nanosecond time)
              (* 1000000000 (time-second time))))]]
    (lambda []
      (time-to-nanoseconds
       ((@ (srfi srfi-19) current-time) time-monotonic)))))

(define call-with-new-sys-thread call-with-new-thread)

;;;;;;;;;;;;;;;;
;; FILESYSTEM ;;
;;;;;;;;;;;;;;;;

(define [read-string-file path]
  (let* [
   [in (open-file path "r")]
   [text (get-string-all in)]
   (go (close-port in))]
   text))

(define [write-string-file path data]
  "mode ::= 'w | 'a"
  (let* [
   [out (open-file path "w")]
   [re (display data out)]
   (go (close-port out))]
   re))

(define [append-string-file path data]
  "mode ::= 'w | 'a"
  (let* [
   [out (open-file path "w")]
   [re (display data out)]
   (go (close-port out))]
   re))

(define remove-stat
  ;; Remove the `stat' object the `file-system-tree' provides
  ;; for each file in the tree.
  (match-lambda
    ((name stat)              ; flat file
     name)
    ((name stat children ...) ; directory
     (list name (map remove-stat children)))))

(define [directory-tree directory]
  "Returns object like this:
   '((dir1 (dir1/file1 dir1/file2))
     (dir2)
     (dir3 (dir3/dir2 ..
  "
  (remove-stat (file-system-tree directory)))

(define [directory-files directory]
  "Returns object like this:
   ((fullname name)
    (fullname name)
     ....
  "

  ;; Skip everything
  (define (enter? name stat result)
    (string=? name directory))

  (define (leaf name stat result)
    (cons (cons* name (basename name)) result))

  (define (down name stat result)
    result)
  (define (up name stat result)
    result)
  (define (skip name stat result)
    result)

  ;; ignore errors
  (define (error name stat errno result) result)

  (file-system-fold enter? leaf down up skip error
                    '()
                    directory))

(define [directory-files-rec directory]
  "Returns object like this:
   ((fullname name dirname1 dirname2 dirname3...
    (fullname name ....

   Where dirname1 is the parent dir of the file
  "

  ;; Don't skip anything
  (define (enter? name stat result)
    #t)

  (define current '())

  (define (leaf name stat result)
    (cons (cons* name (basename name) current)
          result))

  (define (down name stat result)
    (set! current (cons name current))
    result)
  (define (up name stat result)
    (set! current (cdr current))
    result)

  (define (skip name stat result) result)

  ;; ignore errors
  (define (error name stat errno result) result)

  (file-system-fold enter? leaf down up skip error
                    '()
                    directory))

;;;;;;;;;;;;;
;; RECORDS ;;
;;;;;;;;;;;;;

(define-syntax rec-fields
  (lambda (stx)
    (syntax-case stx ()
      [(rec-fields fiii name buf)
       (with-syntax
           [[type (datum->syntax #'name
                                 (symbol-append
                                  'define-rec:
                                  (syntax->datum #'name)))]
            [predi (datum->syntax #'name
                                  (symbol-append
                                   (syntax->datum #'name)
                                   '?))]]
         #'(define-record-type type (name . fiii) predi . buf))]
      [(rec-fields fiii name buf field . fields)
       (with-syntax

           [[gname (datum->syntax #'field
                                  (symbol-append
                                   (syntax->datum #'name)
                                   '-
                                   (syntax->datum #'field)))]
            [sname (datum->syntax #'field
                                  (symbol-append
                                   'set-
                                   (syntax->datum #'name)
                                   '-
                                   (syntax->datum #'field)
                                   '!))]]

         #'(rec-fields fiii
                       name
                       ((field gname sname) . buf)
                       .
                       fields))])))

(define-syntax-rule [define-rec name . fields]
  (rec-fields
   fields
   name
   ()
   . fields))

;;;;;;;;;;;;;;;;;;;;;;;;
;; PREEMPTIVE THREADS ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; Enable asynchronous auto-yield
;; making non-preemptive threads to preemptive ones (or `i-thread's - "interuptible threads")
;;
;; NOTE:
;; * `my-mutex-lock!' is not interruptible
;;   Use `i-thread-critical!' to ensure that no interrupt will happen before `my-mutex-unlock!'
;;   Or use `np-thread-lockr' and `np-thread-unlockr' instead
;; * `sleep' (`usleep') is not interruptible
;;   use `np-thread-usleep' instead

;; TODO: [variable interrupt frequency] use this somehow
(define global-interrupt-frequency-p (make-parameter 1000000))

(define-values
  [i-thread-yield
   i-thread-dont-yield]
  (let [[interruptor-thread #f]
        [lst (list)]
        [interruptor-finished? #t]]

    (define [interruptor-loop]
      (if (null? lst)
          (set! interruptor-finished? #t)
          (begin
            (map
             (lambda [th]
               (system-async-mark
                np-thread-yield
                th))
             lst)
            (usleep 900000) ;; TODO: [variable interrupt frequency]
            (interruptor-loop))))

    (values
     (lambda [thread]

       (when interruptor-finished?
         (set! interruptor-thread
           (call-with-new-thread interruptor-loop)))

       (system-async-mark
        (lambda []
          (unless (member thread lst)
            (set! lst (cons thread lst))))
        interruptor-thread))

     (lambda [thread]
       (unless interruptor-finished?
         (system-async-mark
          (lambda []
            (set! lst
              (filter (lambda [th] (not (equal? th thread)))
                      lst)))
          interruptor-thread))))))

(define [i-thread-yield-me]
  (i-thread-yield ((@ [ice-9 threads] current-thread))))

(define [i-thread-dont-yield-me]
  (i-thread-dont-yield ((@ [ice-9 threads] current-thread))))

(define-syntax-rule [i-thread-run! . thunk]
  (np-thread-run!
   (dynamic-wind
     i-thread-yield-me
     (lambda [] (begin . thunk))
     i-thread-dont-yield-me)))

;; For debug purposes
(define-values
  [i-thread-critical-points
   i-thread-critical-points-append!
   i-thread-critical-points-remove!
   i-thread-critical-points-print]
  (let [[lst (list)]
        [mut (my-make-mutex)]]
    (values
     (lambda [] lst)
     (lambda [st]
       (my-mutex-lock! mut)
       (set! lst (cons st lst))
       (my-mutex-unlock! mut))
     (lambda [st]
       (my-mutex-lock! mut)
       (set! lst
         (filter (lambda [el] (not (equal? el st)))
                 lst))
       (my-mutex-unlock! mut))
     (lambda []
       (format #t "--- CRITICAL POINTS ---\n")
       (for-each
        (lambda [st]
          (display-backtrace st (current-output-port)))
        lst)
       (format #t "--- END CRITICAL POINTS ---\n")))))

(define-syntax-rule [i-thread-critical! . thunk]
  "
  Will not interrupt during execution of `thunk'
  Unsafe: must finish quick!
  "
  (call-with-blocked-asyncs
   (lambda []
     (let [[st (make-stack #t)]]
       (i-thread-critical-points-append! st)
       (begin . thunk)
       (i-thread-critical-points-remove! st)))))

(define [i-thread-critical-b! thunk finally]
  "
  Same as `i-thread-critical' but also puts `thunk' and `finally' to `with-bracket' clause
  "
  (i-thread-critical! (with-bracket thunk finally)))

;;;;;;;;;;;;;;;
;; PROCESSES ;;
;;;;;;;;;;;;;;;

(define-rec comprocess
  command
  args
  mode
  pipe
  pid
  status
  exited?
  )

(define [run-comprocess#private mode command . args]
  "Run process in background
   Input and Output ports are represented by `comprocess-pipe'
   They are new, not related to `(current-input-port)' or `(current-ouput-porn)'

   type ::= mode -> string -> list of string -> process
   mode ::= OPEN_READ | OPEN_WRITE | OPEN_BOTH
  "
  (let [[p
         (comprocess
          command
          args
          mode
          #f
          #f
          #f
          #f)]]
    (call-with-new-thread
     (lambda []
       (let* [[pipe (apply open-pipe*
                           (cons* (comprocess-mode p)
                                  (comprocess-command p)
                                  (comprocess-args p)))]
              [pid (hashq-ref port/pid-table pipe)]]
         (set-comprocess-pipe! p pipe)
         (set-comprocess-pid! p pid)
         (set-comprocess-status! p (cdr (waitpid pid))) ;; NOTE: unsafe because process could have ended by now, but probability is too small because processes take long time to start
         (set-comprocess-exited?! p #t))))

    ;; wait for pipe to initialize
    (let lp []
      (unless (comprocess-pid p)
        (usleep 100)
        (lp)))
    p))

(define [run-comprocess command . args]
  (apply run-comprocess#private (cons* OPEN_READ command args)))

(define [run-comprocess-with-output-to output command . args]
  "Run process in background
   Input and Output ports are represented by `comprocess-pipe'
   Output port will be redirected to `output', input is unchanged

   type ::= port -> string -> list of string -> process
  "
  (let [[p (apply run-comprocess (cons* command args))]]
    (call-with-new-thread
     (lambda []
       (port-redirect
        (comprocess-pipe p)
        output)))
    p))

(define [close-comprocess p]
  (catch #t
    (lambda [] (close-pipe (comprocess-pipe p)))
    (lambda args #f)))


;;;;;;;;;;;;;;;;;;;;;;;
;; GENERIC FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;;;

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
                   [sem (my-make-mutex)]]
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
                  (call-with-blocked-asyncs
                   (lambda []
                     (my-mutex-lock! sem)
                     (set! internal-list (make-parameter (append (internal-list) (list (cons args func)))))
                     (my-mutex-unlock! sem))))
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

(define [alist->hash-table lst]
  (let [[h (make-hash-table)]]
    (for-each
     (lambda (pair)
       (hash-set! h (car pair) (cdr pair)))
     lst)
    h))

(define [hash->mdict h]
  (letin
   [unique (make-unique)]
   (make-procedure-with-setter
    (lambda [key]
      (let [[g (hash-ref h key unique)]]
        (if (unique g)
            (throw 'mdict-key-not-found key h)
            g)))
    (lambda [new] h))))

(define [alist->mdict alist]
  (hash->mdict (alist->hash-table alist)))

(define-syntax mdict-c
  (syntax-rules ()
    [(mdict-c carry) (alist->mdict carry)]
    [(mdict-c carry key value . rest)
     (mdict-c (cons (cons key value) carry) . rest)]))

(define-syntax-rule [mdict . entries]
  (mdict-c '() . entries))

(define [mdict-has? h-func key]
  (let [[h (set! (h-func) 0)]]
    (hash-get-handle h key)))

(define [mdict->alist h-func]
  (let [[h (set! (h-func) 0)]]
    (hash-map->list cons h)))

(define [mass *mdict key value]
  (let* [[new (alist->hash-table (mdict->alist *mdict))]
         [new-f (hash->mdict new)]
         (do (hash-set! new key value))]
    new-f))

(define [mdict-keys h-func]
  (map car (mdict->alist h-func)))
