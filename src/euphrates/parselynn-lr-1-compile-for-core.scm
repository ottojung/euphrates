;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:lr-1-compile/for-core
         get-next-token-code
         parsing-table callback-alist)

  (define table-based-code
    (parselynn:lr-parsing-table:compile
     parsing-table callback-alist))

  `(

    ;;;;;;;;;;;;;;;;;;;
    ;;
    ;; Library.
    ;;

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

      ;; TODO: move down to make 'token a captured variable to reduce code size.
      (define (do-reject token)
        (if (equal? token parselynn:end-of-input)
            (error-procedure
             'end-of-input "Syntax error: unexpected end of input: ~s" token)
            (error-procedure
             'unexpected-token "Syntax error: unexpected token: ~s" token))
        reject)

      (define (process-accept)
        (stack-peek parse-stack))

      (define (loop-with-input state token category source value)
        (define (process-shift action)
          (stack-push! state-stack state)
          (stack-push! parse-stack value)
          (loop (parselynn:lr-shift-action:target-id action)))

        ,table-based-code)

      (define (get-input)
        (define token
          (iterator:next input-tokens-iterator parselynn:end-of-input))

        (if (equal? token parselynn:end-of-input)
            (values token token token token)
            (let ()
              (define category
                (parselynn:token:category token))

              (define source
                (parselynn:token:source token))

              (define value
                (parselynn:token:value token))

              (values token category source value))))

      ;; Main parsing loop.
      (define (loop state)
        (define-values (token category source value) (get-input))
        (loop-with-input state token category source value))

      (loop initial-state))))
