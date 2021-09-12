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

;;
;; In this file we translate CFG-CLI definitions
;; into human readable help message.
;;

%var CFG-AST->CFG-CLI-help
%var CFG-AST->CFG-CLI-help

%use (~a) "./tilda-a.scm"
%use (~s) "./tilda-s.scm"
%use (raisu) "./raisu.scm"
%use (make-hashset hashset-ref hashset->list) "./ihashset.scm"
%use (CFG-CLI->CFG-AST) "./parse-cfg-cli.scm"
%use (string-pad-R) "./string-pad.scm"
%use (replicate) "./replicate.scm"
%use (get-current-program-path) "./get-current-program-path.scm"
%use (path-get-basename) "./path-get-basename.scm"
%use (list-fold) "./list-fold.scm"
%use (list-drop-while) "./list-drop-while.scm"
%use (CFG-lang-modifier-char?) "./compile-cfg-cli.scm"
%use (print-in-window) "./print-in-window.scm"
%use (conss) "./conss.scm"
%use (words->string) "./words-to-string.scm"
%use (string->words) "./string-to-words.scm"
%use (list-intersperse) "./list-intersperse.scm"
%use (list-deduplicate) "./list-deduplicate.scm"
%use (hashmap) "./hashmap.scm"
%use (hashmap-set! hashmap-ref hashmap->alist) "./ihashmap.scm"
%use (list-map/flatten) "./list-map-flatten.scm"
%use (system-environment-get) "./system-environment.scm"
%use (alphanum/alphabet/index) "./alphanum-alphabet.scm"

(define (CFG-AST->CFG-CLI-help helps types defaults)
  (define arg-helps (filter list? helps))
  (define single-helps (filter (negate list?) helps))

  (define (strip-modifiers name)
    (list->string (reverse (list-drop-while CFG-lang-modifier-char? (reverse (string->list name))))))

  (define header1 #f)
  (define header2 #f)
  (define footer #f)

  (define (flatten* T)
    (if (list? T)
        (apply append (map flatten* T))
        (list T)))

  (lambda (cli-decl)
    (define AST (CFG-CLI->CFG-AST cli-decl))
    (define window-width
      (let* ((w (system-environment-get "COLUMNS"))
             (n (and w (string->number w))))
        (or n 80)))

    (define flattened
      (list-deduplicate
       (flatten* cli-decl)))

    (define fH (hashmap))

    (define _
      (for-each
       (lambda (name-symbol)
         (define name (~a name-symbol))

         (map
          (lambda (L T)
            (define A (assoc name-symbol L))
            (when A
              (hashmap-set! fH name
                            (cons (cons T (cdr A))
                                  (hashmap-ref fH name '())))))
          (list arg-helps types defaults)
          '(#f type default)))
       flattened))

    (define (assoc/false name lst)
      (let ((x (assoc name lst)))
        (and x (cdr x))))

    (define (string-filter-non-alpha s)
      (list->string
       (filter alphanum/alphabet/index (string->list s))))

    (define fH-alist
      (sort (hashmap->alist fH)
            (lambda (a b)
              (string<? (string-filter-non-alpha (car a))
                        (string-filter-non-alpha (car b))))))

    (define maximum-option-size
      (list-fold
       (acc 7)
       (name (map car fH-alist))
       (max acc (string-length name))))

    (define option-start-x (+ 3 maximum-option-size))

    (define (pad-option n s)
      (display (list->string (replicate n #\space)))
      (string-pad-R s (+ 3 (- maximum-option-size n)) #\space))

    (define (print-option-parts parts)
      (print-in-window
       option-start-x window-width option-start-x #\space
       parts))

    (define maximum-production-size
      (list-fold
       (acc 3)
       (name (map car (cdr AST)))
       (max acc (string-length (strip-modifiers (~a name))))))

    (define production-start-x (+ 3 maximum-production-size))

    (define (pad-production n s)
      (display (list->string (replicate n #\space)))
      (string-pad-R s (+ 3 (- maximum-production-size n)) #\space))

    (define (show-type T)
      (if (list? T)
          (map (compose ~s ~a) T)
          (list (~a T))))

    (define (display-options)
      (display "Options:") (newline) (newline)
      (for-each
       (lambda (s)
         (if (string? s)
             (begin
               (display "  ")
               (display s)
               (newline))
             (let* ((name (car s))
                    (props (cdr s)))
               (display (pad-option 2 name))

               (let ((description (assoc/false #f props)))
                 (when description
                   (print-option-parts (list-intersperse " " (string->words (car description))))))

               (let ((type (assoc/false 'type props)))
                 (when type
                   (newline)
                   (display (pad-option 4 "type:"))
                   (print-option-parts
                    (if (list? type)
                        (list-intersperse " | " (list-map/flatten show-type type))
                        (list (~a type))))))

               (let ((def (assoc/false 'default props)))
                 (when def
                   (newline)
                   (case (car def)
                     ((#t) (display (pad-option 4 "default")))
                     ((#f) (display (pad-option 4 "not the default")))
                     (else
                      (display (pad-option 4 "default:"))
                      (print-option-parts (list-intersperse " " (string->words (~s (~a (car def))))))))))

               (newline)
               (newline))))
       fH-alist))

    (define (show-regex-elem elem)
      (define selem (~a elem))
      (define stripped (strip-modifiers selem))

      (cond
       ((string-suffix? "?" selem)
        (string-append "[" stripped "]"))
       ((string-suffix? "*" selem)
        (string-append "[" stripped "...]"))
       ((string-suffix? "+" selem)
        (string-append stripped "..."))
       (else
        selem)))

    (define (show-regex regex)
      (words->string (map show-regex-elem regex)))

    (define (show-production prod)
      (define name (strip-modifiers (~a (car prod))))
      (define regexes (cdr prod))
      (display (pad-production 2 name))
      (display "= ")
      (display (show-regex (car regexes)))
      (for-each
       (lambda (regex)
         (newline)
         (display (pad-production 2 ""))
         (display "| ")
         (display (show-regex regex)))
       (cdr regexes))
      (newline))

    (define (display-productions)
      (unless (null? (cdr AST))
        (newline)
        (for-each show-production (cdr AST))
        (newline)))

    (define (display-cli-decl)
      (display "Usage: ")
      (display (path-get-basename (get-current-program-path)))
      (display " ")
      (display (show-regex (cadr (car AST))))
      (newline))

    (with-output-to-string
      (lambda _
        (display-cli-decl)
        (display (or header1 ""))
        (display-productions)
        (display (or header2 ""))
        (display-options)
        (display (or footer ""))))))


