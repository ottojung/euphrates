;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; Also handles vectors and other primitive types.
;; Use together with `parse-json'
;;

(define (display-alist-as-json/full type indentation-level alist port)
  (unless (member type (list 'pretty 'minimal))
    (raisu* :from "display-alist-as-json"
            :type 'bad-type
            :message (stringf "Expected ~s or ~s but got ~s"
                              (~a 'pretty) (~a 'minimal) (~a type))
            :args (list type)))

  (define minimal? (equal? type 'minimal))

  (define make-indentation
    (if minimal? (const "")
        (lambda (level) (make-string level #\tab))))

  (define display-space
    (if minimal? ignore
        (lambda _ (display " " port))))

  (define display-newline
    (if minimal? ignore
        (lambda _ (newline port))))

  (let loop ((indentation-level indentation-level)
             (alist alist))

    (define indentation (make-indentation indentation-level))

    (cond
     ((equal? #t alist) (display "true" port))
     ((equal? #f alist) (display "false" port))
     ((equal? 'null alist) (display "null" port))
     ((number? alist) (write alist port))
     ((string? alist) (write alist port))

     ((vector? alist)
      (display "[" port)
      (let ((index 0))
        (vector-for-each
         (lambda (x)
           (unless (= 0 index)
             (display "," port)
             (display-space port))
           (set! index (+ 1 index))
           (loop indentation-level x))
         alist))
      (display "]" port))

     ((list? alist)
      (display "{" port)
      (display-newline port)
      (for-each
       (lambda (p)
         (define-tuple (first? last? input) p)
         (unless (pair? input)
           (raisu 'object-must-consist-of-key-value-pairs input))

         (define key (car input))
         (define value (cdr input))

         (display indentation port)
         (cond
          ((string? key) (write key) port)
          ((symbol? key) (write (~a key) port))
          (else (raisu 'key-must-be-a-string-or-a-symbol key)))
         (display ":" port)
         (display-space port)
         (loop (+ 1 indentation-level) value)
         (unless last? (display "," port))
         (display-newline port))
       (list-mark-ends alist))
      (display (make-indentation (- indentation-level 1)) port)
      (display "}" port))

     (else (raisu 'unsupported-type alist)))))

(define display-alist-as-json
  (case-lambda
   ((alist)
    (display-alist-as-json/full
     'pretty 1 alist (current-output-port)))
   ((alist port)
    (display-alist-as-json/full
     'pretty 1 alist port))))

(define display-alist-as-json/indent
  (case-lambda
   ((indentation-level alist)
    (display-alist-as-json/full
     'pretty indentation-level alist (current-output-port)))
   ((indentation-level alist port)
    (display-alist-as-json/full
     'pretty indentation-level alist port))))

(define display-alist-as-json/minimal
  (case-lambda
   ((alist)
    (display-alist-as-json/full
     'minimal 1 alist (current-output-port)))
   ((alist port)
    (display-alist-as-json/full
     'minimal 1 alist port))))
