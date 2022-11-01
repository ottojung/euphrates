
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (random-variable-name) "./src/random-variable-name.scm"

(let () ;; random-variable-name
  (define n1 (random-variable-name 20))
  (assert= 20 (string-length n1))
  (assert= n1 (string-downcase n1))
  )
