
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

   process?
   command:process
   args:process
   mode:process
   pipe:process
   pid:process
   status:process
   exited?:process
   run-process
   run-process-with-output-to
   kill-process*

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


;;;;;;;;;;;;;
;; FILE IO ;;
;;;;;;;;;;;;;

(define [read-string-file path [mode 'r]]
  (letin-with-identity
   [in (open-file path (~a mode))]
   [text (get-string-all in)]
   (do (close-port in))
   text))

(define [write-string-file path data [fmt "~a"] [mode 'w]]
  "mode ::= 'w | 'a"
  (letin-with-identity
   [out (open-file path (~a mode))]
   [re (format out fmt data)]
   (do (close-port out))
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


