;;;; Copyright (C) 2019, 2020, 2021  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

%run guile

;; Do not export make-env, use parameterize instead ;; %var np-thread-make-env
%var np-thread-parameterize-env
%var with-np-thread-env#non-interruptible

;; Do not export run ;; %var np-thread-global-run!
%var np-thread-global-spawn
%var np-thread-global-cancel
%var np-thread-global-disable-cancel
%var np-thread-global-enable-cancel
%var np-thread-global-yield
%var np-thread-global-sleep
%var np-thread-global-mutex-make
%var np-thread-global-mutex-lock!
%var np-thread-global-mutex-unlock!
%var np-thread-global-critical-make

%use (define-type9) "./define-type9.scm"
%use (make-unique) "./make-unique.scm"
%use (universal-usleep) "./universal-usleep.scm"
%use (universal-lockr! universal-unlockr!) "./universal-lockr-unlockr.scm"
%use (with-critical) "./with-critical.scm"
%use (make-queue queue-empty? queue-peek queue-push! queue-pop!) "./queue.scm"
%use (raisu) "./raisu.scm"
%use (dynamic-thread-cancel-tag) "./dynamic-thread-cancel-tag.scm"

%use (dynamic-thread-spawn#p) "./dynamic-thread-spawn-p.scm"
%use (dynamic-thread-cancel#p) "./dynamic-thread-cancel-p.scm"
%use (dynamic-thread-disable-cancel#p) "./dynamic-thread-disable-cancel-p.scm"
%use (dynamic-thread-enable-cancel#p) "./dynamic-thread-enable-cancel-p.scm"
%use (dynamic-thread-yield#p) "./dynamic-thread-yield-p.scm"
%use (dynamic-thread-sleep#p) "./dynamic-thread-sleep-p.scm"
%use (dynamic-thread-mutex-make#p) "./dynamic-thread-mutex-make-p.scm"
%use (dynamic-thread-mutex-lock!#p) "./dynamic-thread-mutex-lock-p.scm"
%use (dynamic-thread-mutex-unlock!#p) "./dynamic-thread-mutex-unlock-p.scm"
%use (dynamic-thread-critical-make#p) "./dynamic-thread-critical-make-p.scm"

%use (np-thread-obj np-thread-obj-continuation set-np-thread-obj-continuation! np-thread-obj-cancel-scheduled? set-np-thread-obj-cancel-scheduled?! np-thread-obj-cancel-enabled? set-np-thread-obj-cancel-enabled?!) "./np-thread-obj.scm"

;; Disables critical zones because in non-interruptible mode
;; user can assure atomicity by just not calling yield during its evalution.
;; Locks still work as previusly,
;; but implementation must be changed,
;; because system mutexes will not allow to do yield
;; while waiting on mutex.
(define (make-no-critical . args)
  (lambda (fn) (fn)))

(define (np-thread-make-env make-critical)

  (define thread-queue (make-queue 16))
  (define current-thread #f)
  (define critical (make-critical))
  (define start-point (lambda _ (values)))

  (define (make-np-thread-obj thunk)
    (np-thread-obj thunk #f #t))

  (define (np-thread-list-add th)
    (with-critical
     critical
     (queue-push! thread-queue th)))

  (define (np-thread-list-switch)
    (with-critical
     critical
     (let loop ((head (queue-pop! thread-queue #f)))
       (if (not head) 'np-thread-empty-list
           (if (and (np-thread-obj-cancel-scheduled? head)
                    (np-thread-obj-cancel-enabled? head))
               (begin
                 (loop (queue-pop! thread-queue #f)))
               (begin
                 (set! current-thread head)
                 head))))))

  (define [np-thread-end]
    (let [[p (np-thread-list-switch)]]
      (if (eq? p 'np-thread-empty-list)
          (start-point)
          (begin
            ((np-thread-obj-continuation p))
            (np-thread-end)))))

  (define [np-thread-run! thunk]
    (call-with-current-continuation
     (lambda [k]
       (set! start-point k)
       (set! current-thread (make-np-thread-obj thunk))
       (thunk)
       (np-thread-end))))

  (define [np-thread-yield]
    (if current-thread
        (let [[me current-thread]]
          (when (and (np-thread-obj-cancel-scheduled? me)
                     (np-thread-obj-cancel-enabled? me))
            (raisu dynamic-thread-cancel-tag))

          (call-with-current-continuation
           (lambda (k)
             (set-np-thread-obj-continuation! me k)
             (np-thread-list-add me)
             (np-thread-end))))
        (np-thread-run! np-thread-yield)))

  (define [np-thread-fork thunk]
    (let ((first? #t)
          (ret #f))
      (call-with-current-continuation
       (lambda (k)
         (set! ret (make-np-thread-obj k))
         (np-thread-list-add ret)))
      (unless first?
        (thunk)
        (np-thread-end))
      (set! first? #f)
      ret))

  ;; Terminates np-thread
  ;; If no arguments given, current thread will be terminated
  ;; But if thread is provided, it will be removed from thread list (equivalent to termination if that thread is not the current one)
  ;; Therefore, don't provide current thread as argument unless you really mean to
  (define np-thread-cancel!#unsafe
    (case-lambda
      [[] (np-thread-end)]
      [[chosen] 0]))

  (define (np-thread-cancel! chosen)
    (set-np-thread-obj-cancel-scheduled?! chosen #t)
    (when (np-thread-obj-cancel-enabled? chosen)
      (np-thread-cancel!#unsafe chosen)))

  (define (np-thread-make-critical)
    (lambda (fn)
      (when current-thread
        (let* [[me current-thread]]
          (set-np-thread-obj-cancel-enabled?! me #f)
          (fn) ;; NOTE: must not evaluate non-local jumps
          (set-np-thread-obj-cancel-enabled?! me #t))
        (np-thread-yield))))

  (define [np-thread-disable-cancel]
    (when current-thread
      (let ((me current-thread))
        (set-np-thread-obj-cancel-enabled?! me #f))))
  (define [np-thread-enable-cancel]
    (when current-thread
      (let ((me current-thread))
        (set-np-thread-obj-cancel-enabled?! me #t))))

  (values
   np-thread-run!
   np-thread-fork
   np-thread-cancel!
   np-thread-disable-cancel
   np-thread-enable-cancel
   np-thread-yield
   universal-usleep
   make-unique
   universal-lockr!
   universal-unlockr!
   np-thread-make-critical))

(define (np-thread-parameterize-env make-critical thunk)
  (define-values
      (np-thread-run!
       np-thread-fork
       np-thread-cancel!
       np-thread-disable-cancel
       np-thread-enable-cancel
       np-thread-yield
       universal-usleep
       make-unique
       universal-lockr!
       universal-unlockr!
       np-thread-make-critical)
    (np-thread-make-env make-critical))
  (parameterize ((dynamic-thread-spawn#p np-thread-fork)
                 (dynamic-thread-cancel#p np-thread-cancel!)
                 (dynamic-thread-disable-cancel#p np-thread-disable-cancel)
                 (dynamic-thread-enable-cancel#p np-thread-enable-cancel)
                 (dynamic-thread-yield#p np-thread-yield)
                 (dynamic-thread-sleep#p universal-usleep)
                 (dynamic-thread-mutex-make#p make-unique)
                 (dynamic-thread-mutex-lock!#p universal-lockr!)
                 (dynamic-thread-mutex-unlock!#p universal-unlockr!)
                 (dynamic-thread-critical-make#p np-thread-make-critical))
    (np-thread-run! thunk)))

(define-syntax with-np-thread-env#non-interruptible
  (syntax-rules ()
    ((_ . bodies)
     (np-thread-parameterize-env
      make-no-critical
      (lambda () . bodies)))))

(define-values
    (np-thread-global-run!
     np-thread-global-spawn
     np-thread-global-cancel
     np-thread-global-disable-cancel
     np-thread-global-enable-cancel
     np-thread-global-yield
     np-thread-global-sleep
     np-thread-global-mutex-make
     np-thread-global-mutex-lock!
     np-thread-global-mutex-unlock!
     np-thread-global-critical-make)
  (np-thread-make-env make-no-critical))
