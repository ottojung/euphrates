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

;; NOTE: do not use np-thread-make-env,
;;       use np-thread-parameterize-env instead.
%var np-thread-make-env

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

%use (make-unique) "./make-unique.scm"
%use (with-critical) "./with-critical.scm"
%use (make-queue queue-empty? queue-peek queue-push! queue-pop!) "./queue.scm"
%use (raisu) "./raisu.scm"
%use (dynamic-thread-cancel-tag) "./dynamic-thread-cancel-tag.scm"
%use (dynamic-thread-get-wait-delay) "./dynamic-thread-get-wait-delay.scm"
%use (sys-usleep) "./sys-usleep.scm"
%use (make-box box-ref box-set!) "./box.scm"
%use (nano->micro/unit micro->nano/unit) "./unit-conversions.scm"
%use (time-get-monotonic-nanoseconds-timestamp) "./time-get-monotonic-nanoseconds-timestamp.scm"

%use (np-thread-obj np-thread-obj? np-thread-obj-continuation set-np-thread-obj-continuation! np-thread-obj-cancel-scheduled? set-np-thread-obj-cancel-scheduled?! np-thread-obj-cancel-enabled? set-np-thread-obj-cancel-enabled?!) "./np-thread-obj.scm"

;; Disables critical zones because in non-interruptible mode
;; user can assure atomicity by just not calling yield during its evalution.
;; Locks still work as previusly,
;; but implementation must be changed,
;; because system mutexes will not allow to do yield
;; while waiting on mutex.
(define (np-thread-make-no-critical . args)
  (lambda (fn) (fn)))

(define (np-thread-make-env make-critical)

  (define thread-queue (make-queue 16))
  (define current-thread #f)
  (define critical (make-critical))
  (define start-point #f)

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
       (set! current-thread head)
       (if (not head) 'np-thread-empty-list
           (if (and (np-thread-obj-cancel-scheduled? head)
                    (np-thread-obj-cancel-enabled? head))
               (loop (queue-pop! thread-queue #f))
               head)))))

  (define [np-thread-end]
    (let [[p (np-thread-list-switch)]]
      (if (eq? p 'np-thread-empty-list)
          (let ((sp start-point))
            (set! start-point #f)
            (sp))
          (begin
            ((np-thread-obj-continuation p))
            (np-thread-end)))))

  (define [np-thread-run! thunk]
    (call-with-current-continuation
     (lambda [k]
       (set! start-point k)
       (when thunk
         (set! current-thread (make-np-thread-obj thunk))
         (thunk))
       (np-thread-end)))
    (values))

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
        (np-thread-run! #f)))

  ;; Note: puts the thread TO THE END of the queue,
  ;; so when you yield, you don't go to the last forked thread,
  ;; you go to the first one.
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
      (unless current-thread
        (np-thread-yield))
      ret))

  (define (np-thread-cancel! chosen)
    (unless (np-thread-obj? chosen)
      (raisu 'type-error 'np-thread-cancel! chosen))

    (set-np-thread-obj-cancel-scheduled?! chosen #t))

  (define (np-thread-make-critical)
    (lambda (fn)
      (if current-thread
          (let* [[me current-thread]]
            (set-np-thread-obj-cancel-enabled?! me #f)
            (let ((result (fn)))
              (set-np-thread-obj-cancel-enabled?! me #t)
              result))
          (fn))))

  (define [np-thread-disable-cancel]
    (when current-thread
      (let ((me current-thread))
        (set-np-thread-obj-cancel-enabled?! me #f))))
  (define [np-thread-enable-cancel]
    (when current-thread
      (let ((me current-thread))
        (set-np-thread-obj-cancel-enabled?! me #t))))

  ;; Basically the ./universal-usleep.scm
  (define (np-thread-usleep micro-seconds)
    (let* ((nano-seconds (micro->nano/unit micro-seconds))
           (start-time (time-get-monotonic-nanoseconds-timestamp))
           (end-time (+ start-time nano-seconds))
           (sleep-rate (dynamic-thread-get-wait-delay))
           (yield np-thread-yield))
      (let lp ()
        (yield)
        (let ((t (time-get-monotonic-nanoseconds-timestamp)))
          (unless (> t end-time)
            (let ((s (min sleep-rate (nano->micro/unit (- end-time t)))))
              (sys-usleep s)
              (lp)))))))

  (define np-thread-mutex-make
    (lambda () (make-box #f)))

  ;; Basically, a spinlock.
  ;; Wasteful if many threads are waiting on the same lock.
  (define np-thread-mutex-lock!
    (lambda (mut)
      (let lp ()
        (when
            (with-critical
             critical
             (if (box-ref mut)
                 #t
                 (begin
                   (box-set! mut #t)
                   #f)))
          (np-thread-yield)
          (lp)))))

  (define (np-thread-mutex-unlock! mut)
    (with-critical
     critical
     (box-set! mut #f)))

  (values
   np-thread-run!
   np-thread-fork
   np-thread-cancel!
   np-thread-disable-cancel
   np-thread-enable-cancel
   np-thread-yield
   np-thread-usleep
   np-thread-mutex-make
   np-thread-mutex-lock!
   np-thread-mutex-unlock!
   np-thread-make-critical))

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
  (np-thread-make-env np-thread-make-no-critical))
