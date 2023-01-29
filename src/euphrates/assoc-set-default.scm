
(cond-expand
 (guile
  (define-module (euphrates assoc-set-default)
    :export (assoc-set-default)
    :use-module ((euphrates assoc-set-value) :select (assoc-set-value)))))



(define-syntax assoc-set-default
  (syntax-rules ()
    ((_ key/0 value alist/0)
     (let ()
       (define key key/0)
       (define alist alist/0)
       (define got (assoc key alist))
       (if got alist (assoc-set-value key value alist))))))
