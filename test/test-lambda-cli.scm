
%run guile

;; lambda-cli
%use (assert=) "./euphrates/assert-equal.scm"
%use (lambda-cli) "./euphrates/define-cli.scm"

(let ()

  (define f
    (lambda-cli
     (run OPTS* DATE <end-statement>
          OPTS    : --opts <opts...>*
          /         --param1 <arg1>
          /         --flag1
          DATE    : may  <nth> MAY-OPTS?
          /         june <nth> JUNE-OPTS*
          MAY-OPTS    : -p <x>
          JUNE-OPTS   : -f3 / -f4)
     :synonym (run go)
     (string-append run "-suffix")))

  (assert= "go-suffix"
           (f (list "go" "--param1" "somefile" "june" "5" "the-end"))))
