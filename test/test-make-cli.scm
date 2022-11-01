
%run guile

;; make-cli
%use (assert) "./src/assert.scm"
%use (make-cli) "./src/define-cli.scm"
%use (hashmap) "./src/hashmap.scm"

(let ()
  (define M
    (make-cli
     (run OPTS* DATE <end-statement>
          OPTS   : --opts <opts...>*
                 / --param1 <arg1>
                 / --flag1
          DATE   : may  <nth> MAY-OPTS?
                 / june <nth> JUNE-OPTS*
          MAY-OPTS    : -p <x>
          JUNE-OPTS   : -f3 / -f4)
     :synonym (run let go)))

  (define M2
    (make-cli
     (run --flag1?)
     :synonym (run let go)))

  (assert
   (not
    (M (hashmap)
       (list "go" "--param1" "somefile" "june" "5" "the-end"))))

  (assert (not (M2 (hashmap) (list "go"))))
  (assert (not (M2 (hashmap) (list "go" "--flag1"))))

  )
