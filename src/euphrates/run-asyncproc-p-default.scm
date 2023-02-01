
(cond-expand
 (guile
  (define-module (euphrates run-asyncproc-p-default)
    :export (run-asyncproc/p-default)
    :use-module ((euphrates asyncproc-input-text-p) :select (asyncproc-input-text/p))
    :use-module ((euphrates asyncproc-stderr) :select (asyncproc-stderr))
    :use-module ((euphrates asyncproc-stdout) :select (asyncproc-stdout))
    :use-module ((euphrates asyncproc) :select (asyncproc asyncproc-args asyncproc-command set-asyncproc-exited?! set-asyncproc-pid! set-asyncproc-pipe! set-asyncproc-status!))
    :use-module ((euphrates call-with-finally) :select (call-with-finally))
    :use-module ((euphrates catch-any) :select (catch-any))
    :use-module ((euphrates conss) :select (conss))
    :use-module ((euphrates dynamic-thread-get-delay-procedure) :select (dynamic-thread-get-delay-procedure))
    :use-module ((euphrates dynamic-thread-spawn) :select (dynamic-thread-spawn))
    :use-module ((euphrates file-delete) :select (file-delete))
    :use-module ((euphrates make-temporary-fileport) :select (make-temporary-fileport))
    :use-module ((euphrates read-string-file) :select (read-string-file))
    )))


(cond-expand
 (guile


  (use-modules (ice-9 popen))

  (define-syntax with-ignore-errors!*
    (syntax-rules ()
      ((_ . bodies)
       (catch-any
        (lambda _ . bodies)
        (lambda errors 0)))))

  ;; Run process in background
  ;; Input port is represented by `asyncproc-pipe'
  (define [run-asyncproc/p-default command . args]
    (define p-stdout0 (or (asyncproc-stdout) (current-output-port)))
    (define-values (p-stdout p-stdout-file)
      (if (file-port? p-stdout0)
          (values p-stdout0 #f)
          (make-temporary-fileport)))
    (define p-stderr0 (or (asyncproc-stderr) (current-error-port)))
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
          (file-delete p-stdout-file))
        (when p-stderr-file
          (with-ignore-errors!* (close-port p-stderr))
          (with-ignore-errors!* (display (read-string-file p-stderr-file) p-stderr0))
          (file-delete p-stderr-file))))

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

    (define p (asyncproc command args #f #f #f #f))

    (parameterize [[current-output-port p-stdout]
                   [current-error-port p-stderr]]
      (let* [[pipe (apply open-pipe*
                          (conss OPEN_WRITE
                                 (asyncproc-command p)
                                 (asyncproc-args p)))]
             [pid (hashq-ref port/pid-table pipe)]
             [re-status #f]]
        (set-asyncproc-pipe! p pipe)
        (set-asyncproc-pid! p pid)

        (dynamic-thread-spawn
         (lambda _
           (let ((sleep (dynamic-thread-get-delay-procedure)))
             (call-with-finally
              (lambda _
                (when (asyncproc-input-text/p)
                  (display (asyncproc-input-text/p) pipe)
                  (close-port pipe))

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
                (set-asyncproc-status! p re-status)
                (set-asyncproc-exited?! p #t)
                (with-ignore-errors!* (close-pipe pipe)))))))))

    p)

 ))
