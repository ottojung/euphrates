;;;; Copyright (C) 2020, 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




;; This is for ad hoc polymorphism
;; Faster than gfunc, but also more limited
;; Similar to SML parametric modules

(define-syntax with-svars-helper
  (syntax-rules ()
    ((_ dict buf () body)
     (lambda dict
       (let buf body)))
    ((_ dict buf (name . names) body)
     (with-svars-helper
      dict
      ((name
        (let ((z (assq (quote name) dict)))
          (if z (cdr z) name))) . buf)
      names
      body))))

(define-syntax with-svars
  (syntax-rules ()
    ((_ names body)
     (with-svars-helper dd () names body))))

(define-syntax use-svars-helper
  (syntax-rules ()
    ((_ () () f) (f))
    ((_ buf () f) (f . buf))
    ((_ buf ((name value) . names) f)
     (use-svars-helper
      ((cons (quote name) value) . buf)
      names
      f))))

(define-syntax use-svars
  (syntax-rules ()
    ((_ f . renames)
     (use-svars-helper () renames f))))

(define-syntax make-static-package-helper
  (syntax-rules ()
    ((_ hh buf ())
     (let ((hh (make-hashmap)))
       (begin . buf)
       hh))
    ((_ hh buf ((name value) . definitions))
     (make-static-package-helper
      hh
      ((hashmap-set! hh
                     (quote name)
                     value) . buf)
      definitions))))

(define-syntax make-static-package
  (syntax-rules ()
    ((_ definitions)
     (make-static-package-helper hh () definitions))))

(define-syntax make-package
  (syntax-rules ()
    ((_ inputs definitions)
     (with-svars
      inputs
      (make-static-package definitions)))))

(define-syntax with-package-helper
  (syntax-rules ()
    ((_ inst () body) body)
    ((_ inst (name . names) body)
     (let ((name (hashmap-ref inst (quote name))))
       (with-package-helper
        inst
        names
        body)))))

(define-syntax with-package-renames-helper-pre
  (syntax-rules ()
    ((_ (package . renames))
     (use-svars package . renames))
    ((_ package)
     (package))))

(define-syntax with-package
  (syntax-rules ()
    ((_ package-spec names body)
     (let ((inst (with-package-renames-helper-pre package-spec)))
       (with-package-helper inst names body)))))
