;;;; Copyright (C) 2022  Otto Jung
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

%var directory-files-depth-iter

%for (COMPILER "guile")

%use (append-posix-path) "./append-posix-path.scm"
%use (catch-any) "./catch-any.scm"
%use (define-type9) "./define-type9.scm"
%use (path-normalize) "./path-normalize.scm"
%use (make-queue queue-empty? queue-pop! queue-push!) "./queue.scm"

;; Returns #f on iter end.
;; Normally returns a list that looks like this: (fullname name dirname1 dirname2 dirname3...)
;; NOTE: does not check for recursion!

(define-syntax-rule (false-if-exception expr)
  (catch-any
   (lambda _ expr)
   (lambda args #f)))

(define-type9 <dirlevel>
  (make-dirlevel full-name file-name stack) dirlevel?
  (full-name dirlevel-full-name)
  (file-name dirlevel-file-name)
  (stack dirlevel-stack)
  )

(define directory-files-depth-iter
  (case-lambda
   ((depth directory) (directory-files-depth-iter #f depth directory))
   ((include-directories? depth directory)
    (define norm (path-normalize directory))
    (define full-name0 norm)
    (define file-name0 full-name0)

    (define current-stack #f)
    (define current-prefix #f)
    (define current-depth #f)
    (define current-stream #f)

    (define todo-dirs (make-queue))

    (define (push-todo-dir! full-name file-name current-stack)
      (define prev-prefix (if (null? current-stack) "" (car current-stack)))
      (define new-prefix (append-posix-path prev-prefix file-name))
      (define stack (cons new-prefix current-stack))
      (define level (make-dirlevel full-name file-name stack))
      (queue-push! todo-dirs level))

    (define (pop-todo-dir!)
      (define level (queue-pop! todo-dirs))
      (set! current-stack (dirlevel-stack level))
      (set! current-prefix (car current-stack))
      (set! current-depth (+ 1 (length current-stack)))
      (set! current-stream (opendir (dirlevel-full-name level)))
      )

    (define (next)
      (define file-name
        (and current-stream (readdir current-stream)))
      (cond
       ((equal? #f file-name)
        (if (queue-empty? todo-dirs)
            #f
            (begin
              (pop-todo-dir!)
              (next))))
       ((eof-object? file-name)
        (closedir current-stream)
        (set! current-stream #f)
        (if (queue-empty? todo-dirs)
            #f
            (begin
              (pop-todo-dir!)
              (next))))
       ((or (string=? "." file-name)
            (string=? ".." file-name))
        (next))
       (else
        (let* ((full-name (if (= current-depth 1)
                              file-name
                              (string-append current-prefix "/" file-name)))
               (recurse? (< current-depth depth))
               (dir? (and (or recurse? (not include-directories?))
                          (let ((st (false-if-exception (stat full-name))))
                            (and st (equal? 'directory (stat:type st)))))))

          (when (and recurse? dir?)
            (push-todo-dir! full-name file-name current-stack))

          (if include-directories?
              (cons full-name (cons file-name current-stack))
              (if dir?
                  (next)
                  (cons full-name (cons file-name current-stack))))))))

    (push-todo-dir! full-name0 file-name0 '())

    next
    )))

%end
