;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; EBNF is like BNF but productions are regex-like, basically.
;; This is a parser for it.
;; It outputs an alist that has all regex things compiled away.
;; In result, new productions are added to the original BNF of the input EBNF.
(define (generic-ebnf-tree->alist equality alternative)
  (define bnf-handler (generic-bnf-tree->alist equality alternative))

  (lambda (body)
    (define bnf-alist (bnf-handler body))
    (define ret (stack-make))
    (define (yield x) (stack-push! ret x))

    (define (make-name original-name/s counter)
      (string->symbol
       (string-append
        original-name/s
        (if (= 0 counter) ""
            (string-append "_" (number->string counter))))))

    (define taken-names
      (list->hashset
       (filter
        symbol?
        (list-collapse bnf-alist))))

    (define (generate-name original-name)
      (define original-name/s (~a original-name))
      (let loop ((c 0))
        (define name (make-name original-name/s c))
        (if (hashset-has? taken-names name)
            (loop (+ c 1))
            (begin
              (hashset-add! taken-names name)
              name))))

    (define (handle-term t)
      (define (err)
        (raisu* :from '!ebnf-tree->alist
                :type 'bad-ebnf-modifier
                :message (stringf "EBNF trees do not support operator ~s" (~a (car t)))
                :args (list (car t))))

      (cond
       ((not (list? t)) t)
       ((list-length= 0 t) t)
       ((list-length= 1 t) (err))
       ((list-length= 2 t)
        (let ()
          (define type (car t))
          (define original-name (cadr t))
          (cond
           ((equal? type 'custom) t)
           ((equal? type '*)
            (let ((name (generate-name (string-append (~a original-name) "*"))))
              (yield `(,name (,original-name ,name) ()))
              name))
           ((equal? type '+)
            (let ((name (generate-name (string-append (~a original-name) "+"))))
              (yield `(,name (,original-name ,name) (,original-name)))
              name))
           ((equal? type '?)
            (let ((name (generate-name (string-append (~a original-name) "?"))))
              (yield `(,name (,original-name) ()))
              name))
           (else (err)))))
       ((list-length=<? 2 t)
        (let ()
          (define type (car t))
          (cond
           ((equal? type 'custom) t)
           ((equal? type '/)
            (let ((name (generate-name 'generated-alternative)))
              (yield (cons name (map list (cdr t))))
              name))
           (else (err)))))))

    (define translated
      (map
       (lambda (production)
         (define lhs (car production))
         (define rhs (cdr production))
         (define rhs* (map (lambda (expansion) (map handle-term expansion)) rhs))
         (cons lhs rhs*))
       bnf-alist))

    (append translated (reverse (stack->list ret)))))
