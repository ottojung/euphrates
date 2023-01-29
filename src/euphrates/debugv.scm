
(cond-expand
 (guile
  (define-module (euphrates debugv)
    :export (debugv)
    :use-module ((euphrates debug) :select (debug))
    :use-module ((euphrates range) :select (range))
    :use-module ((euphrates list-intersperse) :select (list-intersperse)))))



(define (debug-vars->string vars/symbols)
  (define count (length vars/symbols))
  (define mapped (map (const "~s = ~s") (range count)))
  (apply string-append (list-intersperse ", " mapped)))

(define-syntax debug-vars-helper
  (syntax-rules ()
    ((_ vars buf ())
     (debug (debug-vars->string (reverse (quote vars))) . buf))
    ((_ vars buf (x . xs))
     (debug-vars-helper vars ((quote x) x . buf) xs))))

(define-syntax-rule (debugv . vars)
  (debug-vars-helper vars () vars))
