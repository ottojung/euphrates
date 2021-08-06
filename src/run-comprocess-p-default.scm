
%run guile

%var run-comprocess/p-default

%for (COMPILER "guile")

%use (comprocess comprocess? comprocess-command comprocess-args comprocess-pipe set-comprocess-pipe! comprocess-pid set-comprocess-pid! comprocess-status set-comprocess-status! comprocess-exited? set-comprocess-exited?!) "./comprocess.scm"
%use (make-temporary-fileport) "./make-temporary-fileport.scm"
%use (catch-any) "./catch-any.scm"
%use (call-with-finally) "./call-with-finally.scm"
%use (comprocess-stdout) "./comprocess-stdout.scm"
%use (comprocess-stderr) "./comprocess-stderr.scm"
%use (dynamic-thread-spawn) "./dynamic-thread-spawn.scm"
%use (dynamic-thread-get-delay-procedure) "./dynamic-thread-get-delay-procedure.scm"
%use (read-string-file) "./read-string-file.scm"
%use (conss) "./conss.scm"
%use (file-delete) "./file-delete.scm"

(use-modules (ice-9 popen))

(define-syntax with-ignore-errors!*
  (syntax-rules ()
    ((_ . bodies)
     (catch-any
      (lambda _ . bodies)
      (lambda errors 0)))))

;; Run process in background
;; Input port is represented by `comprocess-pipe'
(define [run-comprocess/p-default command . args]
  (define p-stdout0 (or (comprocess-stdout) (current-output-port)))
  (define-values (p-stdout p-stdout-file)
    (if (file-port? p-stdout0)
        (values p-stdout0 #f)
        (make-temporary-fileport)))
  (define p-stderr0 (or (comprocess-stderr) (current-error-port)))
  (define-values (p-stderr p-stderr-file)
    (if (file-port? p-stderr0)
        (values p-stderr0 #f)
        (make-temporary-fileport)))

  (define cleanup
    (lambda _
      ;; TODO: dont ignore errors?
      (when p-stdout-file
        (with-ignore-errors!* (close-port p-stdout))
        (with-ignore-errors!* (display (read-string-file p-stdout-file) p-stdout0))
        (with-ignore-errors!* (file-delete p-stdout-file)))
      (when p-stderr-file
        (with-ignore-errors!* (close-port p-stderr))
        (with-ignore-errors!* (display (read-string-file p-stderr-file) p-stderr0))
        (with-ignore-errors!* (file-delete p-stderr-file)))))

  ;; returns status
  (define (waitpid/no-throw/no-hang pid)
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
                          (conss OPEN_WRITE
                                 (comprocess-command p)
                                 (comprocess-args p)))]
             [pid (hashq-ref port/pid-table pipe)]
             [re-status #f]]
        (set-comprocess-pipe! p pipe)
        (set-comprocess-pid! p pid)

        (dynamic-thread-spawn
         (lambda _
           (let ((sleep (dynamic-thread-get-delay-procedure)))
             (call-with-finally
              (lambda _
                (let lp ()
                  (let ((status (waitpid/no-throw/no-hang pid)))
                    (case status
                      ((running)
                       (sleep)
                       (lp))
                      (else
                       (set! re-status status))))))
              (lambda _
                (cleanup)
                (set-comprocess-status! p re-status)
                (set-comprocess-exited?! p #t)
                (with-ignore-errors!* (close-pipe pipe)))))))))

    p))

%end
