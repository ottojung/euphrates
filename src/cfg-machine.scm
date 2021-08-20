;;;; Copyright (C) 2021  Otto Jung
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

%use (hashmap) "./hashmap.scm"
%use (hashmap-ref hashmap-set!) "./ihashmap.scm"
%use (immutable-hashmap) "./immutable-hashmap.scm"
%use (~s) "./tilda-s.scm"
%use (raisu) "./raisu.scm"
%use (make-regex-machine/full) "./regex-machine.scm"

;; Context Free Grammar Machine.
;; Similar to Regex Machine from ./regex-machine.scm
;; It parses arbitrary lists and returns bindings.
;; Algorithm is the naive and predictable one,
;; so beware the complexity.
%var make-cfg-machine

;; Injects functions to call regexes in place of (call "name")
;; and returns (values new-grammar main)
(define (inject-calls grammar)
  (define regexes (hashmap))

  (define call
    (lambda (name/lst hash T cont)
      (define regex-machine
        (hashmap-ref regexes (car name/lst) #f))
      (unless regex-machine
        (raisu 'bad-call
               (string-append "Called non existent production: "
                              (~s (car name/lst)))))
      (regex-machine hash T cont)))

  (define (regex->injected-regex regex)
    (let loop ((regex regex))
      (if (pair? regex)
          (if (eq? 'call (car regex))
              (cons call (cdr regex))
              (map loop regex))
          regex)))

  (define new-grammar
    (map
     (lambda (p)
       (list (car p) (regex->injected-regex (cadr p))))
     grammar))

  (for-each
   (lambda (p)
     (hashmap-set!
      regexes
      (car p)
      (make-regex-machine/full (cadr p))))
   new-grammar)

  (define main
    (hashmap-ref regexes (car (car grammar))))

  (values new-grammar main))

;;
;; Example grammar:
;; '((main (and (call foo) (= "bar" x) (* (call baz))))
;;   (foo (or (and (call main) (= "end-foo" y))
;;            (and (epsilon))))
;;   (baz (and (any z) (any* w))))
(define (make-cfg-machine grammar)
  (define-values (grammar* main) (inject-calls grammar))
  (define (cont hash buf) (values hash (null? buf)))
  (lambda (T)
    (main (immutable-hashmap) T cont)))



