
(define-module (euphrates common)
  #:export (
            EUPHRATES_GUILE_EXPORT_LIST
            )

  #:use-module [ice-9 format]
  #:use-module [ice-9 binary-ports]
  #:use-module [ice-9 hash-table]
  #:use-module [ice-9 threads]
  #:use-module [ice-9 popen]
  #:use-module [ice-9 ftw]
  #:use-module [ice-9 match]
  #:use-module [ice-9 atomic]
  #:use-module [srfi srfi-1]
  #:use-module [srfi srfi-9] ;; records
  #:use-module [srfi srfi-11] ;; let-values
  #:use-module [srfi srfi-13]
  #:use-module [srfi srfi-16]
  #:use-module [srfi srfi-18]
  #:use-module [srfi srfi-19] ;; time
  #:use-module [srfi srfi-42]
  #:use-module [srfi srfi-111] ;; box

  #:re-export (let-values)
  #:re-export (make-atomic-box
               atomic-box?
               atomic-box-ref
               atomic-box-set!
               ;; atomic-box-swap! ;; racket doesn't have this
               ;; atomic-box-compare-and-swap!) ;; racket doesn't have this
               )
  #:re-export (box unbox box? set-box!)
  )

(define null (list))

(define [procedure-get-minimum-arity proc]
  (let [[ret (procedure-minimum-arity proc)]]
    (if ret (car ret) #f)))

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

(define [catch-any body handler]
  (catch #t body handler))

(define [printf fmt . args]
  (local-print fmt args))

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

(define call-with-new-sys-thread call-with-new-thread)
(define cancel-sys-thread cancel-thread)
(define sys-thread-exited? thread-exited?)
(define sys-thread-sleep usleep)

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

(define [hash-table->alist h] (hash-map->list cons h))

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

(define [string-endswith? str suffix]
  (string-suffix? suffix str))
(define [string-startswith? str prefix]
  (string-prefix? prefix str))
(define (string-trim-chars str chars-arg direction)
  (define chars (if (string? chars-arg)
                    (string->list chars-arg)
                    chars-arg))
  (define (pred c)
    (memq c chars))
  (case direction
    ((left) (string-trim str pred))
    ((right) (string-trim-right str pred))
    ((both) (string-trim-both str pred))))

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
(define [run-comprocess#full p-stdout p-stderr command . args]
  "Run process in background
   Input port is represented by `comprocess-pipe'
   NOTE: in guile p-stdout == p-stderr doesn't work!

   type ::= output-port? -> output-port? -> string -> list of string -> process
  "

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
             (let lp ()
               (let ((status (waitpid#no-throw#no-hang pid)))
                 (case status
                   ((running)
                    (sleep)
                    (lp))
                   (else
                    (set-comprocess-status! p status)
                    (set-comprocess-exited?! p #t))))))))))

    p))

(define [run-comprocess command . args]
  (apply run-comprocess#full
         (cons* (current-output-port)
                (current-error-port)
                command args)))

(define [kill-comprocess p force?]
  (kill (comprocess-pid p) (if force? SIGKILL SIGTERM)))

;; racket compatibility
(define system*/exit-code system*)

