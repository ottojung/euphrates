;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:lr-1-compile/for-core
         get-next-token-code
         parsing-table callback-alist)

  (define table-based-code
    (parselynn:lr-parsing-table:compile
     parsing-table callback-alist))

  (define initial-stack-capacity
    1)

  `(

    ;;;;;;;;;;;;;;;;;;;
    ;;
    ;; Library.
    ;;

    (define (stack-make)
      (make-vector ,initial-stack-capacity))

    (define (parselynn:lr-shift-action:target-id x)
      x)

    (define (parselynn:token:category x)
      (vector-ref x 1))

    (define (parselynn:token:source x)
      (vector-ref x 2))

    (define (parselynn:token:value x)
      (vector-ref x 3))

    (define parselynn:end-of-input
      (quote ,parselynn:end-of-input))

    (define-syntax iterator:next
      (syntax-rules ()
        ((_ iter default)
         (iter))))

    (define initial-state
      ,(parselynn:lr-parsing-table:state:initial parsing-table))

    (define (parselynn:lr-reject-action:make)
      #f)

    (define (parselynn:lr-reject-action? obj)
      (equal? reject obj))

    ;;;;;;;;;;;;;;;;;;;
    ;;
    ;; Implementation.
    ;;

    (define reject
      (parselynn:lr-reject-action:make))

    (lambda (___scanner ___errorp)
      ,@get-next-token-code
      (define input-tokens-iterator get-next-token)
      (define error-procedure ___errorp)

      (define parse-stack
        (stack-make))

      (define state-stack
        (stack-make))

      (define parse-stack-capacity (vector-length parse-stack))
      (define parse-stack-size 0)
      (define (push-parse! x)
        (if (< parse-stack-size parse-stack-capacity)
            (begin
              (vector-set! parse-stack parse-stack-size x)
              (set! parse-stack-size (+ 1 parse-stack-size)))
            (begin
              (set! parse-stack-capacity (* 2 parse-stack-capacity))
              (let ((parse-stack-new (make-vector parse-stack-capacity)))
                (vector-copy! parse-stack-new 0 parse-stack 0 parse-stack-size)
                (set! parse-stack parse-stack-new))
              (vector-set! parse-stack parse-stack-size x)
              (set! parse-stack-size (+ 1 parse-stack-size)))))

      (define state-stack-capacity (vector-length state-stack))
      (define state-stack-size 0)
      (define (push-state! x)
        (if (< state-stack-size state-stack-capacity)
            (begin
              (vector-set! state-stack state-stack-size x)
              (set! state-stack-size (+ 1 state-stack-size)))
            (begin
              (set! state-stack-capacity (* 2 state-stack-capacity))
              (let ((state-stack-new (make-vector state-stack-capacity)))
                (vector-copy! state-stack-new 0 state-stack 0 state-stack-size)
                (set! state-stack state-stack-new))
              (vector-set! state-stack state-stack-size x)
              (set! state-stack-size (+ 1 state-stack-size)))))

      (define (state-stack-peek)
        (vector-ref state-stack (- state-stack-size 1)))

      (define (parse-stack-peek)
        (vector-ref parse-stack (- parse-stack-size 1)))

      (define (parse-pop!)
        (set! parse-stack-size (- parse-stack-size 1))
        (vector-ref parse-stack parse-stack-size))

      (define (state-discard-multiple! n)
        (set! state-stack-size (- state-stack-size n)))

      (define (process-accept)
        'ACCEPT)

      (define token #f)

      (define (do-reject)
        (if (equal? token parselynn:end-of-input)
            (error-procedure
             'end-of-input "Syntax error: unexpected end of input: ~s" token)
            (error-procedure
             'unexpected-token "Syntax error: unexpected token: ~s" token))
        reject)

      (define (loop-with-input state category source value)
        ,table-based-code)

      (define (get-input)
        (set! token
              (iterator:next input-tokens-iterator parselynn:end-of-input))

        (if (equal? token parselynn:end-of-input)
            (values token token token)
            (let ()
              (define category
                (parselynn:token:category token))

              (define source
                (parselynn:token:source token))

              (define value
                (parselynn:token:value token))

              (values category source value))))

      ;; Main parsing loop.
      (define (loop state)
        (define-values (category source value) (get-input))
        (loop-with-input state category source value))

      (if (equal? 'ACCEPT (loop initial-state))
          (parse-stack-peek)
          (do-reject)))))
