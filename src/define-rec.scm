
%run guile

%var define-rec
%var define-rec?

%for (COMPILER "guile")

(use-modules (srfi srfi-9))

(define define-rec? record?)

(define-syntax rec-fields
  (lambda (stx)
    (syntax-case stx ()
      [(rec-fields fiii name buf export-buf)
       (with-syntax
           [[type (datum->syntax #'name
                                 (symbol-append
                                  'define-rec:
                                  (syntax->datum #'name)))]
            [predi (datum->syntax #'name
                                  (symbol-append
                                   (syntax->datum #'name)
                                   '?))]]
         #'(define-record-type type
             (name . fiii)
             predi
             . buf))]
      [(rec-fields fiii name buf export-buf field . fields)
       (with-syntax

           [[gname (datum->syntax #'field
                                  (symbol-append
                                   (syntax->datum #'name)
                                   '-
                                   (syntax->datum #'field)))]
            [sname (datum->syntax #'field
                                  (symbol-append
                                   'set-
                                   (syntax->datum #'name)
                                   '-
                                   (syntax->datum #'field)
                                   '!))]]

         #'(rec-fields fiii
                       name
                       ((field gname sname) . buf)
                       (gname sname . export-buf)
                       .
                       fields))])))

(define-syntax-rule [define-rec name . fields]
  (rec-fields
   fields
   name
   ()
   ()
   . fields))

%end
%for (COMPILER "racket")

(define-syntax-rule [define-rec name . fields]
  (struct name fields
          #:mutable
          #:prefab))

(define define-rec? struct?)

%end

