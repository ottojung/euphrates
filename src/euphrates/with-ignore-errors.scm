
(cond-expand
 (guile
  (define-module (euphrates with-ignore-errors)
    :export (with-ignore-errors!)
    :use-module ((euphrates catch-any) :select (catch-any))
    :use-module ((euphrates current-source-info-to-string) :select (current-source-info->string))
    :use-module ((euphrates get-current-source-info) :select (get-current-source-info))
    :use-module ((euphrates debug) :select (debug)))))



(define-syntax-rule (with-ignore-errors! . bodies)
  (catch-any
   (lambda _ . bodies)
   (lambda errors
     (debug "~aerror: ~s"
            (current-source-info->string
             (get-current-source-info))
            errors))))
