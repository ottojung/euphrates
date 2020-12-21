
%run guile

%use (catch-any) "./catch-any.scm"
%use (current-source-info->string) "./current-source-info->string.scm"
%use (get-current-source-info) "./get-current-source-info.scm"
%use (debug) "./debug.scm"

%var with-ignore-errors!

(define-syntax-rule (with-ignore-errors! . bodies)
  (catch-any
   (lambda _ . bodies)
   (lambda errors
     (debug "~aerror: ~s"
            (current-source-info->string
             (get-current-source-info))
            errors))))
