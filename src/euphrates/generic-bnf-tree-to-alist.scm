;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (generic-bnf-tree->alist semicolon slash)
  (lambda (body)
    (unless (list? body)
      (raisu* :from 'parse-bnf/generic
              :type 'bnf-must-be-a-list
              :message "BNF must be a list"
              :args (list body)))

    (when (null? body)
      (raisu* :from 'parse-bnf/generic
              :type 'bnf-must-be-non-empty
              :message "BNF must be non-empty"
              :args (list)))

    (unless (list-length=<? 2 body)
      (raisu* :from 'parse-bnf/generic
              :type 'bnf-must-be-at-least-length-2
              :message "BNF must consist of at least 3 words"
              :args (list)))

    (define (semicolon? x)
      (equal? semicolon (~a x)))

    (define (slash? x)
      (equal? slash (~a x)))

    (define shifted-semilocons
      (let loop ((body (cdr body)) (last (car body)))
        (if (null? body)
            (list last)
            (let ((cur (car body)))
              (if (semicolon? cur)
                  (if (semicolon? last)
                      (raisu* :from 'parse-bnf/generic
                              :type 'cannot-start-with-a-semicolon
                              :message "BNF cannot start with production definition symbol"
                              :args (list last body))
                      (cons cur (loop (cdr body) last)))
                  (cons last (loop (cdr body) cur)))))))

    (unless (semicolon? (car shifted-semilocons))
      (raisu* :from 'parse-bnf/generic
              :type 'bnf-must-begin-with-production-definition
              :message "BNF must begin with a production definition, like \"MAIN ::=\""
              :args (list (car shifted-semilocons) (cadr shifted-semilocons))))

    (define grouped
      (filter (negate null?)
              (list-split-on semicolon? shifted-semilocons)))

    (define split-by-cases
      (map
       (lambda (production)
         (define name (car production))
         (define regex (cdr production))
         (cons name (list-split-on slash? regex)))
       grouped))

    split-by-cases))
