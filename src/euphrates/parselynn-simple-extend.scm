;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn/simple:extend
         original additional)

  (define (arguments->options arguments)
    (map
     (fn-cons gkeyword->fkeyword identity)
     (keylist->alist arguments)))

  (define (parser->options parser)
    (define arguments
      (parselynn/simple-struct:arguments parser))

    (arguments->options arguments))

  (define (get-options x)
    (cond
     ((parselynn/simple-struct? x)
      (parser->options x))
     ((list? x)
      (arguments->options x))
     (else
      (raisu* :from "parselynn/simple:extend"
              :type 'bad-parser-type
              :message "Expected either a parselynn/simple-struct or arguments that defined it"
              :args (list x)))))

  (define options-original
    (get-options original))

  (define options-additional
    (get-options additional))

  (define merge-keys
    (list 'inline:
          'skip:
          'join:
          'flatten:
          'grammar:))

  (define options-new/0
    (assq-unset-multiple-values
     merge-keys
     (append options-additional
             options-original)))

  (define (get-new-val key)
    (append (assq-or key options-additional '())
            (assq-or key options-original '())))

  (define options-new
    (let loop ((keys merge-keys) (options options-new/0))
      (if (null? keys) options
          (loop
           (cdr keys)
           (assq-set-value
            (car keys) (get-new-val (car keys))
            options)))))

  (define arguments-new
    (alist->keylist
     (map
      (fn-cons gkeyword->rkeyword identity)
      options-new)))

  (if (and (list? original)
           (list? additional))
      arguments-new
      (parselynn/simple arguments-new)))
