;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:ll-1-compile/for-core
         get-next-token-code
         parsing-table callback-alist)

  (define table-based-code
    (parselynn:ll-parsing-table:compile
     parsing-table callback-alist))

  (define starting-predictor
    (if (null? (parselynn:ll-parsing-table:clauses parsing-table))
        '(lambda _ 42)
        (parselynn:ll-compile:get-predictor-name
         (parselynn:ll-parsing-table:starting-nonterminal parsing-table))))

  `(

    ;;;;;;;;;;;;;;;;;;;
    ;;
    ;; Library.
    ;;

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

    (define (parselynn:ll-reject-action:make)
      #f)

    (define (parselynn:ll-reject-action? obj)
      (equal? reject obj))

    ;;;;;;;;;;;;;;;;;;;
    ;;
    ;; Implementation.
    ;;

    (define reject
      (parselynn:ll-reject-action:make))

    (lambda (___scanner ___errorp)
      ,@get-next-token-code
      (define input-tokens-iterator get-next-token)
      (define error-procedure ___errorp)

      (define token #f)

      (define (do-reject)
        (if (equal? token parselynn:end-of-input)
            (error-procedure
             'end-of-input "Syntax error: unexpected end of input: ~s" token)
            (error-procedure
             'unexpected-token "Syntax error: unexpected token: ~s" token))
        reject)

      (define (get-input)
        (iterator:next input-tokens-iterator parselynn:end-of-input))

      (define look_ahead #f)
      (define (advance!)
        (set! token (get-input))
        (if (equal? parselynn:end-of-input token)
            (set! look_ahead token)
            (set! look_ahead (parselynn:token:category token))))

      ,@table-based-code

      (define result
        (begin
          (advance!)
          (,starting-predictor)))

      (if (equal? token parselynn:end-of-input)
          result
          (do-reject)))))
