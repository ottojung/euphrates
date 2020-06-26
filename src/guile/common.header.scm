
(define-module (euphrates common)
  #:export
  (
   null
   dynamic-thread-mutex-make-p
   dynamic-thread-mutex-lock!-p
   dynamic-thread-mutex-unlock!-p
   atomic-box-compare-and-set!
   hash-has-key?
   hash-empty?
   hash-table->alist
   hash-copy
   hash-table-foreach
   catch-any
   printf
   ~a
   time-get-monotonic-nanoseconds-timestamp
   string-split#simple
   words
   big-random-int
   with-output-to-file#clear
   define-eval-namespace
   eval-string-in-namespace
   load-file-in-namespace
   get-command-line-arguments
   get-current-program-path
   get-current-source-file-path
   find-first
   format-id-base
   format-id
   begin-for-syntax
   first
   second
   third
   fourth
   fifth
   file-or-directory-exists?
   file-mtime
   remove-stat
   directory-tree
   directory-files
   directory-files-rec
   path-parent-directory
   make-directory
   make-temporary-fileport
   rec-fields
   define-rec
   sys-thread-current
   sys-thread-enable-cancel
   sys-thread-disable-cancel
   sys-thread-spawn
   sys-thread-cancel
   sys-thread-exited?
   sys-thread-yield
   sys-thread-sleep
   run-comprocess#p-default
   kill-comprocess#p-default
   system*/exit-code
   euphrates-version
   letin
   defloop
   apploop
   reversed-args-buf
   reversed-args
   reversed-args-f-buf
   reversed-args-f
   reversed-lambda
   fn-start
   fn
   fn-list-g
   fn-list
   with-return
   monoids*
   monoids-r*
   monoid-r*
   monoid*
   catch-any#as-pair
   take-common-prefix
   string-trim-chars
   lines
   unlines
   unwords
   list-intersperse
   assert
   assert-norm-buf
   assert-norm
   assert-equal
   range
   list-init
   normal->micro@unit
   micro->nano@unit
   normal->nano@unit
   nano->micro@unit
   micro->normal@unit
   nano->normal@unit
   make-unique
   generic-fold
   generic-fold-macro
   list-fold
   list-fold/rest
   lfold
   simplify-posix-path
   append-posix-path2
   append-posix-path
   path-without-extension
   path-replace-extension
   make-temporary-filename
   stringf
   dprint#p-default
   dprint#p
   dprint
   dprintln
   global-debug-mode-filter
   debug
   dom-print
   port-redirect
   cons!
   memconst
   replicate
   dynamic-thread-get-delay-procedure#default
   dynamic-thread-spawn-p
   dynamic-thread-spawn
   dynamic-thread-cancel-p
   dynamic-thread-cancel
   dynamic-thread-disable-cancel-p
   dynamic-thread-disable-cancel
   dynamic-thread-enable-cancel-p
   dynamic-thread-enable-cancel
   dynamic-thread-yield-p
   dynamic-thread-yield
   dynamic-thread-wait-delay#us-p
   dynamic-thread-sleep-p
   dynamic-thread-sleep
   dynamic-thread-get-delay-procedure-p
   dynamic-thread-get-delay-procedure
   dynamic-thread-get-yield-procedure
   dynamic-thread-cancel-tag
   dynamic-thread-mutex-make
   dynamic-thread-mutex-lock!
   dynamic-thread-mutex-unlock!
   dynamic-thread-critical-make#default
   dynamic-thread-critical-make-p
   dynamic-thread-critical-make
   make-uni-spinlock
   uni-spinlock-lock!
   uni-spinlock-unlock!
   make-uni-spinlock-critical
   with-critical
   sleep-until
   dynamic-thread-async-thunk
   dynamic-thread-async
   universal-lockr! universal-unlockr!
   universal-usleep
   monadic-bare-handle-tags
   monadic-bare
   monadic-global-parameter
   monadic-parameterize
   with-monadic-left
   with-monadic-right
   monadic
   monadic-id
   monad-arg#lazy
   monad-arg
   monad-cont
   monad-qvar
   monad-qval
   monad-qtags
   monad-last-val?
   monad-cret
   monad-ret
   monad-handle-multiple
   monad-replicate-multiple
   except-monad
   log-monad
   identity-monad
   maybe-monad
   lazy-monad
   replace-monad
   filter-monad
   call-with-finally#return-tag
   call-with-finally#return
   call-with-finally
   read-all-port
   read-string-file
   write-string-file
   append-string-file
   path-redirect
   path-rebase
   np-thread-parameterize-env
   with-np-thread-env#non-interruptible
   run-comprocess#p
   run-comprocess
   kill-comprocess#p
   kill-comprocess
   kill-comprocess-with-timeout
   check-list-contract
   gfunc/define
   gfunc/parameterize
   gfunc/instance
   shell-check-status
   shell-cmd-to-comprocess-args
   sh-async-no-log
   sh-async
   sh
   sh-re
   with-no-shell-log
   system-re
   parse-cli
   parse-cli-global-p
   parse-cli-global-default
   parse-cli!
   parse-cli-parse-or-get!
   parse-cli-get-flag
   parse-cli-get-switch
   parse-cli-get-list
   tree-future-current
   tree-future-eval-context-p
   tree-future-eval-context
   tree-future-get
   tree-future-send-message-p
   tree-future-send-message
   tree-future-run-p
   tree-future-run
   tree-future-modify
   tree-future-cancel
   with-new-tree-future-env
   tree-future-run-task-thunk
   tree-future-run-task
   tree-future-wait-task
   guile-printf
   hash->mdict
   alist->mdict
   mdict-c
   mdict
   mdict-has?
   mdict-set!
   mdict->alist
   mass
   mdict-keys
   global-interrupt-frequency-p
   i-thread-yield
   i-thread-dont-yield
   i-thread-yield-me
   i-thread-dont-yield-me
   i-thread-run!
   i-thread-critical-points
   i-thread-critical-points-append!
   i-thread-critical-points-remove!
   i-thread-critical-points-print
   i-thread-critical!
   i-thread-critical-b!
   i-thread-parameterize-env#interruptible
   with-i-thread-env#interruptible
   with-svars
   use-svars
   with-svar-package
   make-static-package
   make-package
   with-package
   )

  #:use-module [ice-9 format]
  #:use-module [ice-9 binary-ports]
  #:use-module [ice-9 hash-table]
  #:use-module [ice-9 threads]
  #:use-module [ice-9 popen]
  #:use-module [ice-9 ftw]
  #:use-module [ice-9 match]
  #:use-module [ice-9 atomic]
  #:use-module [ice-9 rdelim] ;; read-line
  #:use-module [srfi srfi-1]
  #:use-module [srfi srfi-9] ;; records
  #:use-module [srfi srfi-11] ;; let-values
  #:use-module [srfi srfi-13]
  #:use-module [srfi srfi-16]
  #:use-module [srfi srfi-18]
  #:use-module [srfi srfi-19] ;; time
  #:use-module [srfi srfi-42]
  #:use-module [srfi srfi-111] ;; box

  #:re-export (read-line)
  #:re-export (let-values)
  #:re-export (make-atomic-box
               atomic-box?
               atomic-box-ref
               atomic-box-set!
               ;; atomic-box-swap! ;; racket doesn't have this
               ;; atomic-box-compare-and-swap!) ;; racket doesn't have this
               )
  #:re-export (box unbox box? set-box!)
  #:re-export (alist->hash-table)
  )

(define null (list))

(define dynamic-thread-mutex-make-p
  (make-parameter
   (@ (srfi srfi-18) make-mutex)))
(define dynamic-thread-mutex-lock!-p
  (make-parameter mutex-lock!))
(define dynamic-thread-mutex-unlock!-p
  (make-parameter mutex-unlock!))

;; for racket compatibility
(define (atomic-box-compare-and-set! box expected desired)
  (let ((ret (atomic-box-compare-and-swap! box expected desired)))
    (eq? ret expected)))

(define hash-has-key? hash-get-handle)
(define (hash-empty? h)
  (= 0 (hash-count (lambda _ 0) h)))
(define [hash-table->alist h] (hash-map->list cons h))
(define [hash-copy h]
  (let [[ret (make-hash-table)]]
    (hash-for-each
     (lambda (key value)
       (hash-set! ret key value))
     h)
    ret))
(define [hash-table-foreach h procedure]
  (hash-for-each procedure h))

(define [catch-any body handler]
  (catch #t body
    (lambda err (handler err))))

(define printf
  (lambda args (apply guile-printf args)))

(define (~a x)
  (with-output-to-string
    (lambda ()
      (display x))))

(define time-get-monotonic-nanoseconds-timestamp
  (let [[time-to-nanoseconds
         (lambda [time]
           (+ (time-nanosecond time)
              (* 1000000000 (time-second time))))]]
    (lambda []
      (time-to-nanoseconds
       ((@ (srfi srfi-19) current-time) time-monotonic)))))

(define string-split#simple string-split)

;; TODO: move to lib somehow
(define (words str)
  (filter
   (compose not string-null?)
   (string-split
    str
    (lambda (c)
      (case c
        ((#\newline #\space #\tab) #t)
        (else #f))))))

(define big-random-int
  (let ((initialized? #f))
    (lambda (max)
      (unless initialized?
        ;; NOTE: in guile, random is deterministic by default
        ;; while rackets is non-deterministic by default
        ;; It would be ok if they both were deterministic,
        ;; but it is easier to change guile, so there it is.
        ;; TODO: deterministic random at will
        (set! initialized? #t)
        (set! *random-state* (random-state-from-platform)))
      (random max))))

(define-syntax-rule [with-output-to-file#clear file . bodies]
  (with-output-to-file
      file
      (lambda [] . bodies)))

;; for racket compatibility
(define-syntax-rule [define-eval-namespace name]
  (define name 'not-used))

;; namespace is get with `define-eval-namespace'
(define [eval-string-in-namespace str namespace]
  (eval-string str))

(define-syntax-rule [load-file-in-namespace filepath namespace]
  (load filepath))

(define get-command-line-arguments
  (make-parameter
   (let [[ret (command-line)]]
     (if (< (length ret) 2)
         (list)
         (cdr ret)))))

(define [get-current-program-path]
  (let [[ret (command-line)]]
    (if (null? ret)
        'unknown-current-program-path
        (car ret))))

(define-syntax-rule [get-current-source-file-path]
  (cdr
   (assq
    'filename
    (current-source-location))))

(define find-first find)

(define-syntax format-id-base
  (lambda (stx1)
    (syntax-case stx1 ()
      [(format-id stx fmt args)
       (with-syntax [[ret
                      #'(datum->syntax
                         stx
                         (string->symbol
                          (with-output-to-string
                            (lambda []
                              (apply
                               format
                               (cons*
                                #t
                                fmt
                                args))))))]]
         #'ret)])))

(define-syntax-rule [format-id stx fmt . args]
  (format-id-base stx fmt (list . args)))

(define-syntax-rule [begin-for-syntax . args]
  (begin . args))

(define first car)
(define (second x) (list-ref x 1))
(define (third x) (list-ref x 2))
(define (fourth x) (list-ref x 3))
(define (fifth x) (list-ref x 4))

;;;;;;;;;;;;;;;;
;; FILESYSTEM ;;
;;;;;;;;;;;;;;;;

(define file-or-directory-exists? file-exists?)

(define [file-mtime filepath]
  (stat:mtime (stat filepath)))

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

;; Returns object like this:
;;   ((fullname name)
;;    (fullname name)
;;     ....
(define directory-files
  (case-lambda
    ((directory) (directory-files directory #f))
    ((directory include-directories?)

     ;; Skip everything
     (define (enter? name stat result)
       (string=? name directory))

     (define (leaf name stat result)
       (cons (list name (basename name)) result))

     (define (down name stat result)
       result)
     (define (up name stat result)
       result)
     (define (skip name stat result)
       (if include-directories?
           (cons (list name (basename name)) result)
           result))

     ;; ignore errors
     (define (error name stat errno result) result)

     (file-system-fold enter? leaf down up skip error
                       '()
                       directory))))

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

(define path-parent-directory dirname)
(define make-directory mkdir)

(define (make-temporary-fileport)
  (let ((port (mkstemp! (string-copy "/tmp/myfile-XXXXXX"))))
    (chmod port (logand #o666 (lognot (umask))))
    (values port (port-filename port))))

;;;;;;;;;;;;;
;; RECORDS ;;
;;;;;;;;;;;;;

(define-syntax rec-fields
  (lambda (stx)
    (syntax-case stx ()
      [(rec-fields fiii name buf export-buf)
       (with-syntax
           [[type (datum->syntax #'name
                                 (symbol-append
                                  'define-rec:
                                  (syntax->datum #'name)))]
            [predi (datum->syntax #'name
                                  (symbol-append
                                   (syntax->datum #'name)
                                   '?))]]
         #'(begin
             (define-record-type type
               (name . fiii)
               predi
               . buf)
             (export name predi . export-buf)))]
      [(rec-fields fiii name buf export-buf field . fields)
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
                       (gname sname . export-buf)
                       .
                       fields))])))

(define-syntax-rule [define-rec name . fields]
  (rec-fields
   fields
   name
   ()
   ()
   . fields))

;;;;;;;;;;;;;;;;
;; sys thread ;;
;;;;;;;;;;;;;;;;

(define-rec sys-thread
  handle
  cancel-scheduled?
  cancel-enabled?
  )

(define sys-thread-current
  (make-parameter
   (sys-thread #f #f #f)))

(define (sys-thread-enable-cancel)
  (let ((me (sys-thread-current)))
    (set-sys-thread-cancel-enabled?! me #t)))
(define (sys-thread-disable-cancel)
  (let ((me (sys-thread-current)))
    (set-sys-thread-cancel-enabled?! me #f)))

(define (sys-thread-spawn thunk)
  (let ((th (sys-thread #f #f #t)))
    (set-sys-thread-handle!
     th
     (call-with-new-thread thunk))
    th))

(define (sys-thread-cancel th)
  (set-sys-thread-cancel-scheduled?! th #t))
(define (sys-thread-exited? th)
  (thread-exited? (sys-thread-handle th)))

(define (sys-thread-yield)
  (let ((me (sys-thread-current)))
    (when (and (sys-thread-cancel-scheduled? me)
               (sys-thread-cancel-enabled? me))
      (throw dynamic-thread-cancel-tag))))
(define (sys-thread-sleep us)
  (usleep us)
  (sys-thread-yield))

;;;;;;;;;;;;;;;
;; PROCESSES ;;
;;;;;;;;;;;;;;;

(define-rec comprocess
  command
  args
  pipe
  pid ;; #f or integer
  status ;; #f or integer or 'not-available
  exited?
  )

;; TODO: support asynchronous stdin
;; TODO: why comprocess test doesn't work anymore? Last worked on commit: 63756176ec8d544d4135d88c46fa747666d438b3
(define [run-comprocess#p-default command . args]
  "Run process in background
   Input port is represented by `comprocess-pipe'
   NOTE: in guile p-stdout == p-stderr doesn't work!

   type ::= output-port? -> output-port? -> string -> list of string -> process
  "

  (define p-stdout (current-output-port))
  (define p-stderr (current-error-port))

  ;; returns status
  (define (waitpid#no-throw#no-hang pid)
    (catch-any
     (lambda ()
       (let* ((w (waitpid pid WNOHANG)) ;; TODO: track pid to prevent accidental reuse of same pid
              (ret-pid (car w))
              (status (cdr w)))
         (case ret-pid
           ((0) 'running)
           (else (status:exit-val status)))))
     (lambda errors
       'not-available)))

  (let [[p
         (comprocess
          command
          args
          #f
          #f
          #f
          #f)]]

    (parameterize [[current-output-port p-stdout]
                   [current-error-port p-stderr]]
      (let* [[pipe (apply open-pipe*
                          (cons* OPEN_WRITE
                                 (comprocess-command p)
                                 (comprocess-args p)))]
             [pid (hashq-ref port/pid-table pipe)]]
        (set-comprocess-pipe! p pipe)
        (set-comprocess-pid! p pid)

        (dynamic-thread-spawn
         (lambda ()
           (let ((sleep (dynamic-thread-get-delay-procedure)))
             (call-with-finally
              (lambda _
                (let lp ()
                  (let ((status (waitpid#no-throw#no-hang pid)))
                    (case status
                      ((running)
                       (sleep)
                       (lp))
                      (else
                       (set-comprocess-status! p status)
                       (set-comprocess-exited?! p #t))))))
              (lambda _
                (catch-any
                 (lambda () (close-pipe pipe))
                 (lambda _ 0)))))))))

    p))

(define [kill-comprocess#p-default p force?]
  (kill (comprocess-pid p) (if force? SIGKILL SIGTERM)))

;; racket compatibility
(define system*/exit-code system*)

