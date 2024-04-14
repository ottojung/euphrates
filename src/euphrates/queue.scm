;;;; Copyright (C) 2020, 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define queue? queue-predicate)

(define make-queue
  (case-lambda
   (() (make-queue 10))
   ((initial-size)
    (queue-constructor (make-vector initial-size) 0 0))))

(define (queue-empty? q)
  (= (queue-first q) (queue-last q)))

(define queue-peek
  (case-lambda
   ((q)
    (if (= (queue-first q) (queue-last q))
        (raisu 'empty-queue-peek)
        (vector-ref (queue-vector q) (queue-first q))))
   ((q default)
    (if (= (queue-first q) (queue-last q))
        default
        (vector-ref (queue-vector q) (queue-first q))))))

(define (queue-push! q value)
  (let* ((v (queue-vector q))
         (first (queue-first q))
         (last (queue-last q))
         (size (vector-length v))
         (last+1 (+ 1 last))
         (new-last (if (< last+1 size) last+1 0))
         (need-realloc? (= new-last first))
         (new-size (* 2 size))
         (v (if (not need-realloc?) v
                (let ((ret (make-vector new-size)))
                  (let loop ((i 0) (j first))
                    (when (< i size)
                      (vector-set! ret i (vector-ref v j))
                      (loop (+ 1 i) (if (< (+ 1 j) size) (+ 1 j) 0))))
                  (set-queue-vector! q ret)
                  ret))))
    (if need-realloc?
        (begin
          (set-queue-first! q 0)
          (set-queue-last! q size)
          (vector-set! v (- size 1) value))
        (begin
          (set-queue-last! q new-last)
          (vector-set! v last value)))))

(define queue-pop!
  (case-lambda
   ((q)
    (if (= (queue-first q) (queue-last q)) (raisu 'empty-queue-pop)
        (let* ((v (queue-vector q))
               (size (vector-length v))
               (first (queue-first q))
               (first+1 (+ 1 first))
               (new-first (if (< first+1 size) first+1 0))
               (ret (vector-ref v first)))
          (vector-set! v first #f)
          (set-queue-first! q new-first)
          ret)))
   ((q default)
    (if (= (queue-first q) (queue-last q)) default
        (let* ((v (queue-vector q))
               (size (vector-length v))
               (first (queue-first q))
               (first+1 (+ 1 first))
               (new-first (if (< first+1 size) first+1 0))
               (ret (vector-ref v first)))
          (vector-set! v first #f)
          (set-queue-first! q new-first)
          ret)))))

(define (list->queue lst)
  (queue-constructor (list->vector lst) 0 (length lst)))

(define (queue->list q)
  (define first (+ 0 (queue-first q)))
  (define v (queue-vector q))

  (unless (vector? v)
    (raisu 'bad-queue q))

  (if (queue-empty? q)
      '()
      (let loop ((i (- (queue-last q) 1)) (buf '()))
        (cond
         ((= i first) (cons (vector-ref v i) buf))
         ((< i 0) (loop (- (vector-length v) 1) buf))
         (else (loop (- i 1) (cons (vector-ref v i) buf)))))))

(define (queue->unload! q)
  (let ((lst (queue->list q)))
    (set-queue-first! q 0)
    (set-queue-last! q 0)
    (vector-fill! (queue-vector q) #f)
    lst))

(define (queue-capacity q)
  (vector-length (queue-vector q)))

;; equivalent to queue-pop! followed by queue-push!
(define (queue-rotate! q)
  (define first+ (+ 1 (queue-first q)))
  (define new-first (if (>= first+ (queue-capacity q)) 0 first+))
  (define last+ (+ 1 (queue-last q)))
  (define new-last (if (>= last+ (queue-capacity q)) 0 last+))
  (set-queue-first! q new-first)
  (set-queue-last! q new-last))

;; equivalent to queue-pop! followed by queue-push!
(define queue-peek-rotate!
  (case-lambda
   ((q)
    (let ((ret (queue-peek q)))
      (queue-rotate! q)
      ret))
   ((q default)
    (let ((ret (queue-peek q default)))
      (queue-rotate! q)
      ret))))
