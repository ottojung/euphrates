;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:folexer:compile/iterator lexer)

  (define base-model
    (parselynn:folexer:base-model lexer))

  (define evaluator-code
    (labelinglogic:model:compile-to-r7rs/first base-model))

  `(
    (define evaluator ,evaluator-code)

    (define offset 0)
    (define linenum 0)
    (define colnum 0)

    (define (adjust-positions! c)
      (set! offset (+ offset 1))

      (define nl? (equal? c #\newline))
      (when nl? (set! linenum (+ linenum 1)))
      (set! colnum (if nl? 0 (+ 1 colnum))))

    (define read-next-char
      (cond
       ((string? ___scanner)
        (let ((input-length (string-length ___scanner)))
          (lambda _
            (if (>= offset input-length)
                (eof-object)
                (string-ref ___scanner offset)))))

       ((port? ___scanner)
        (lambda _
          (read-char ___scanner)))

       ((procedure? ___scanner)
        ___scanner)

       (else
        (___errorp
         'unsupported-input-type
         "Type error: unsupported input type: ~s" ___scanner))))

    (define lexical-token-typetag
      '*lexical-token*)

    (define (make-lexical-token category source value)
      (vector lexical-token-typetag category source value))

    (define (wrap-return c category)
      (define location
        (vector '*stdin* linenum colnum offset 1))
      (make-lexical-token category location c))

    (define (get-next-token . args)
      (define c (read-next-char))
      (if (eof-object? c) '*eoi*
          (let ()
            (define category
              (or (evaluator c)
                  (___errorp
                   'unrecognized-input
                   "Type error: unrecognized input: ~s" c)))

            (adjust-positions! c)
            (wrap-return c category))))))
