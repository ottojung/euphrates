#lang racket

(require syntax/parse/define
         (for-syntax racket/base
                     racket/syntax))

(require compatibility/defmacro)

(define 1+ add1)
(define 1- sub1)

(define [throw type . args]
  (error (symbol->string type) "(args: ~a)" args))

(define [catch-any body handler]
  (call-with-exception-handler handler body))

(define [make-hash-table] (make-hash))

(define [my-make-mutex]
  (make-semaphore 1))

(define [my-mutex-lock! mut]
  (semaphore-wait mut))

(define [my-mutex-unlock! mut]
  (semaphore-post mut))

(define cons* list*)

(define [call-with-blocked-asyncs thunk]
  ;; TODO: print system message that this does not work
  (thunk))

(define [time-get-monotonic-nanoseconds-timestamp]
  (* 1000 1000
     (current-process-milliseconds)))

(define [get-u8 from] (read-byte from))
(define [put-u8 to byte] (write-byte byte to))

(define fold foldl)

(define [open-file filepath mode]
  (cond
   [(equal? "w" mode)
    (open-output-file filepath
                      #:mode 'text
                      #:exists-flag 'truncate)]
   [(equal? "wb" mode)
    (open-output-file filepath
                      #:mode 'binary
                      #:exists-flag 'truncate)]
   [(equal? "a" mode)
    (open-output-file filepath
                      #:mode 'text
                      #:exists-flag 'append)]
   [(equal? "ab" mode)
    (open-output-file filepath
                      #:mode 'binary
                      #:exists-flag 'append)]
   [(equal? "r" mode)
    (open-input-file filepath
                      #:mode 'text)]
   [(equal? "rb" mode)
    (open-input-file filepath
                     #:mode 'binary)]
   [else (error "incorrect file mode")]))

(define [usleep microsecond]
  (sleep (/ microsecond (* 1000 1000))))

(define call-with-new-sys-thread thread)

;; TODOS

;;;;;;;;;;;;;;;;;;;;;;;
;; GENERIC FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;;;


(define [check-list-contract check-list args]
  (or (not check-list)
      (and (= (length check-list) (length args))
           (andmap (lambda [p x] (p x)) check-list args))))

(define-simple-macro [gfunc/define name]
  #:with add-name (format-id #'name "gfunc/instantiate-~a" (syntax-e #'name))
  #:with param-name (format-id #'name "gfunc/parameterize-~a" (syntax-e #'name))
  (define-values [name add-name param-name]
    (let [[internal-list (make-parameter null)]
          [sem (make-semaphore 1)]]
      (values
       (lambda args
         (let [[m (findf (lambda [p] (check-list-contract (car p) args)) (internal-list))]]
           (if m
               (apply (cdr m) args)
               (error (format "No gfunc instance of ~a accepts arguments ~a" name args)))))
       (lambda [args func]
         (semaphore-wait sem)
         (set! internal-list (make-parameter (append (internal-list) (list (cons args func)))))
         (semaphore-post sem))
       (lambda [args func body]
         (let [[new-list (cons (cons args func) (internal-list))]]
           (parameterize [[internal-list new-list]]
             (body))))))))

(define-simple-macro [gfunc/parameterize name check-list func . body]
  #:with param-name (format-id #'name "gfunc/parameterize-~a" (syntax-e #'name))
  (param-name check-list func (lambda [] . body)))

(define-simple-macro [gfunc/instance name check-list . body]
  #:with add-name (format-id #'name "gfunc/instantiate-~a" (syntax-e #'name))
  (add-name (list . check-list) (lambda [] . body)))

;;;;;;;;;;;;;;;;
;; FILESYSTEM ;;
;;;;;;;;;;;;;;;;

(define [read-file readf filepath mode]
  (let* [[file (open-input-file filepath #:mode mode)]
         (do (file-position file eof))
         [len (file-position file)]
         (do (file-position file 0))
         [out (readf len file)]
         (do (close-input-port file))
         ]
    out))

(define [write-file writef filepath content mode]
  (let [[file (open-output-file filepath
                                #:mode mode
                                #:exists 'truncate/replace)]]
    (writef content file)
    (close-output-port file)))

(define [append-file writef filepath content mode]
  (define file (open-output-file filepath
                                 #:mode mode
                                 #:exists 'append))
  (writef content file)
  (close-output-port file))

(define [read-string-file filepath] (read-file read-string filepath 'text))
(define [read-bytes-file filepath] (bytes->list (read-file read-bytes filepath 'binary)))
(define [write-string-file filepath content] (write-file write-string filepath content 'text))
(define [append-string-file filepath content] (append-file write-string filepath content 'text))

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

;; TODO:
;; (define [directory-files-rec directory]
;;   "Returns object like this:
;;    ((fullname name dirname1 dirname2 dirname3...
;;     (fullname name ....

;;    Where dirname1 is the parent dir of the file
;;   ")

;;;;;;;;;;;;;
;; RECORDS ;;
;;;;;;;;;;;;;

(define-syntax-rule [define-rec name . fields]
  (struct name fields
          #:mutable
          #:prefab))


;;;;;;;;;;;;;;;
;; PROCESSES ;;
;;;;;;;;;;;;;;;

(define-rec comprocess
  p
  command
  args
  pid
  status
  exited?
  )

;; out-port can be #f
(define [run-comprocess#private out-port command args]
  (let-values
      [[[p stdout stdin stderr]
        (apply subprocess
               (list*
                out-port #f 'stdout ;; stdout stdin stderr
                'new                ;; new group, means that (kill ..) will kill its children also

                command
                args))]]
    (let [[re (comprocess p
                          command
                          args
                          (subprocess-pid p)
                          #f
                          #f)]]

      (define [run-in-thread]
        (subprocess-wait p)

        (when out-port
          (close-output-port out-port))
        (when stdin
          (close-output-port stdin))
        (when stdout
          (close-input-port stdout))
        (when stderr
          (close-input-port stderr))

        (set-comprocess-exited?! re #t)
        (set-comprocess-status! re (subprocess-status p)))

      (thread run-in-thread)
      re)))

(define [run-comprocess command . args]
  (apply run-comprocess#private
         (list* #f command args)))

(define run-comprocess-with-output-to
  run-comprocess#private)

(define [kill-comprocess p force?]
  (subprocess-kill p force?))

