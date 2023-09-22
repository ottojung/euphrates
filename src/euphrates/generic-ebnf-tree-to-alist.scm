;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; EBNF is like BNF but productions are regex-like, basically.
;; This is a parser for it.
;; It outputs an alist that has all regex things compiled away.
;; In result, new productions are added to the original BNF of the input EBNF.
(define (generic-ebnf-tree->alist equality-symbol alternation-symbol custom-transform)
  (define bnf-handler
    (generic-bnf-tree->alist equality-symbol alternation-symbol))

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

    (define generated-names
      (make-hashmap))

    (define (generate-name t original-name)
      (define original-name/s (~a original-name))
      (or (hashmap-ref generated-names t #f)
          (let loop ((c 0))
            (define name (make-name original-name/s c))
            (if (hashset-has? taken-names name)
                (loop (+ c 1))
                (begin
                  (hashset-add! taken-names name)
                  (hashmap-set! generated-names t name)
                  name)))))

    (define (do-custom t name)
      (custom-transform yield name t))

    (define (handle-term t)
      (define existing
        (hashmap-ref generated-names t #f))

      (cond
       (existing existing)
       ((not (list? t)) t)
       ((list-length= 0 t) t)
       ((list-length= 1 t) (do-custom t 'singleton))
       ((list-length= 2 t)
        (let ()
          (define type (car t))
          (define original-name (cadr t))
          (cond
           ((equal? type 'custom) t)
           ((equal? type '*)
            (let ((name (generate-name t (string-append (~a original-name) "*"))))
              (yield `(,name (,original-name ,name) ()))
              name))
           ((equal? type '+)
            (let ((name (generate-name t (string-append (~a original-name) "+"))))
              (yield `(,name (,original-name ,name) (,original-name)))
              name))
           ((equal? type '?)
            (let ((name (generate-name t (string-append (~a original-name) "?"))))
              (yield `(,name (,original-name) ()))
              name))
           (else
            (do-custom t (string-append (~a original-name) "<>"))))))
       ((list-length=<? 2 t)
        (let ()
          (define type (car t))
          (cond
           ((equal? type 'custom) t)
           ((equal? type '/)
            (let ((name (generate-name t 'generated-alternative)))
              (yield (cons name (map list (cdr t))))
              name))
           (else
            (do-custom t (string-append "generated-alternative" "<>"))))))))

    (define translated
      (bnf-alist:map-expansion-terms handle-term bnf-alist))

    (append translated (reverse (stack->list ret)))))
