
%run guile

%use (get-directory-name) "./src/get-directory-name.scm"
%use (get-current-source-file-path) "./src/get-current-source-file-path.scm"
%use (append-posix-path) "./src/append-posix-path.scm"
%use (run-comprocess/p-default) "./src/run-comprocess-p-default.scm"
%use (make-uni-spinlock) "./src/uni-spinlock.scm"
%use (debug) "./src/debug.scm"
%use (debugv) "./src/debugv.scm"
%use (with-ignore-errors!) "./src/with-ignore-errors.scm"
%use (random-choice) "./src/random-choice.scm"
%use (printable/alphabet) "./src/printable-alphabet.scm"
%use (catch-any) "./src/catch-any.scm"
%use (assert) "./src/assert.scm"
%use (assert=) "./src/assert-equal.scm"
%use (make-queue queue-empty? queue-peek queue-push! queue-pop!) "./src/queue.scm"
%use (with-dynamic) "./src/with-dynamic.scm"
%use (lazy-parameter) "./src/lazy-parameter.scm"
%use (~a) "./src/tilda-a.scm"
%use (~s) "./src/tilda-s.scm"
%use (hash->mdict ahash->mdict mdict mdict-has? mdict-set! mdict->alist mdict-keys) "./src/mdict.scm"
%use (words) "./src/words.scm"
%use (unwords) "./src/unwords.scm"
%use (list->tree) "./src/list-to-tree.scm"
%use (list-traverse) "./src/list-traverse.scm"
%use (range) "./src/range.scm"
%use (use-svars with-svars with-package make-package make-static-package) "./src/package.scm"
%use (letin) "./src/letin.scm"
%use (list-intersperse) "./src/list-intersperse.scm"
%use (path-replace-extension) "./src/path-replace-extension.scm"
%use (define-rec define-rec?) "./src/define-rec.scm"
%use (apploop) "./src/apploop.scm"
%use (string-trim-chars) "./src/string-trim-chars.scm"
%use (file-or-directory-exists?) "./src/file-or-directory-exists-q.scm"
%use (get-directory-name) "./src/get-directory-name.scm"
%use (directory-files) "./src/directory-files.scm"
%use (directory-files-rec) "./src/directory-files-rec.scm"
%use (directory-tree) "./src/directory-tree.scm"
%use (hashmap) "./src/hashmap.scm"
%use (hashmap-ref hashmap->alist) "./src/ihashmap.scm"
%use (make-hashset hashset-equal? hashset-difference) "./src/ihashset.scm"
%use (assert=HS) "./src/assert-equal-hs.scm"
%use (list-permutations) "./src/list-permutations.scm"
%use (list-combinations) "./src/list-combinations.scm"
%use (cartesian-product) "./src/cartesian-product.scm"
%use (list-insert-at) "./src/list-insert-at.scm"
%use (list-deduplicate) "./src/list-deduplicate.scm"
%use (list-break) "./src/list-break.scm"
%use (list-tag list-untag) "./src/list-tag.scm"
%use (list-tag/next list-untag/next) "./src/list-tag-next.scm"
%use (comp appcomp) "./src/comp.scm"
%use (make-regex-machine*) "./src/regex-machine.scm"
%use (make-cfg-machine) "./src/cfg-machine.scm"
%use (parse-cli:IR->Regex parse-cli:make-IR) "./src/parse-cli.scm"
%use (make-cli lambda-cli with-cli define-cli:current-hashmap) "./src/define-cli.scm"
%use (command-line-argumets/p) "./src/command-line-arguments-p.scm"
%use (system-re) "./src/system-re.scm"
%use (number->number-list number-list->number number->number-list) "./src/number-list.scm"
%use (convert-number-base) "./src/convert-number-base.scm"
%use (define-property) "./src/properties.scm"
%use (seconds->time-string) "./src/time-to-string.scm"
%use (time-get-current-unixtime) "./src/time-get-current-unixtime.scm"
%use (time-get-monotonic-nanoseconds-timestamp) "./src/time-get-monotonic-nanoseconds-timestamp.scm"
%use (path-without-extension) "./src/path-without-extension.scm"
%use (path-extension) "./src/path-extension.scm"
%use (shell-quote) "./src/shell-quote.scm"
%use (immutable-hashmap) "./src/immutable-hashmap.scm"
%use (immutable-hashmap-ref immutable-hashmap-set immutable-hashmap->alist) "./src/i-immutable-hashmap.scm"

(let ()
  (catch-any
   (lambda _ (assert (= (+ 3 2) (- 10 3))))
   (lambda errors
     (assert
      (equal? errors
              '((assertion-fail (test: (= 5 7)) (original: (= (+ 3 2) (- 10 3))))))))))

(let ()
  (assert (equal? 5 (string-length (list->string (random-choice 5 printable/alphabet))))))

(let ()
  (with-ignore-errors!
   (throw 'test "arg1" "arg2")))

;; queue
(let ()
  (define q (make-queue 1))

  (queue-push! q 1)
  (queue-push! q 2)
  (queue-push! q 3)

  (assert= (queue-peek q) 1)
  (assert= (queue-pop! q) 1)
  (assert= (queue-peek q) 2)
  (assert= (queue-pop! q) 2)

  (assert (not (queue-empty? q)))

  (queue-push! q 9)
  (assert= (queue-pop! q) 3)
  (queue-push! q 8)
  (assert= (queue-pop! q) 9)
  (queue-push! q 7)
  (assert= (queue-pop! q) 8)
  (assert= (queue-pop! q) 7)

  (assert (queue-empty? q)))


;; lazy-parameter, with-dynamic
(let ()
  (define test 1)
  (define x (lazy-parameter (begin (set! test 3) 2)
                            (lambda (z) (string->number (~a z)))))
  (define y (make-parameter 9))

  (assert= test 1)
  (assert= (y) 9)

  (with-dynamic ((x 4) (y 5))
                (assert= (y) 5)
                (assert= (x) 4)
                (assert= test 1))

  (assert= test 1)
  (assert= (x) 2)
  (assert= test 3))

;; mdict
(let ()
  (let ((zz (mdict 1 2
                   3 4)))
    (assert= (zz 3)
                  4)
    (let ((z2 (zz 3 99)))
      (assert= (z2 3)
                    99)
      (assert (mdict-has? z2 3))
      (assert (not (mdict-has? z2 52)))
      (let ((z3 (z2 52 2)))
        (assert (mdict-has? z3 52))
        (mdict-set! z3 52 9)
        (assert= (z3 52) 9)))))

;; words / unwords
(let ()
  (assert=
   (words "hello \t \t \n world!")
   (list "hello" "world!"))

  (assert=
   (unwords (list "hello" "world!"))
   "hello world!"))

;; list->tree
(let ()
  (define ex
    (map string->symbol
         (words "hello < define ex < words x > > bye")))

  (let ()
    (define (divider x xs)
      (cond
       ((equal? '< x)
        (values 'open (list x)))
       ((equal? '> x)
        (values 'close (list x)))
       (else
        (values #f #f))))

    (define r (list->tree ex divider))

    (assert=
     r
     '(hello
       (< define ex (< words x >) >)
       bye)))

  (let ()
    (define (divider x xs)
      (cond
       ((equal? '< x)
        (values 'open (list)))
       ((equal? '> x)
        (values 'close (list)))
       (else
        (values #f #f))))

    (define r (list->tree ex divider))

    (assert=
     r
     '(hello
       (define ex (words x))
       bye))))

;; list-traverse
(let ()
  (assert=
   6
   (list-traverse
    (range 10)
    (lambda (x xs)
      (if (< 5 x)
          (values #f x)
          (values #t xs)))))

  (assert=
   'custom-default
   (list-traverse
    (range 10)
    'custom-default
    (lambda (x xs)
      (if (< 5 x)
          (values #f x)
          (values #t (list)))))))

;; package
(let ()
  (define already-defined 7)

  (define x
    (with-svars [already-defined]
                (lambda (c) (list already-defined c))))

  (define y
    ((use-svars x (b 2) (already-defined 1)) 4))

  (define z
    ((x) 4))

  (define p
    (make-package [already-defined]
                  [[foo (lambda (c) (list already-defined c))]
                   [bar (lambda (c) (list c already-defined))]
                   [baz 3]]))

  (define p-inst (p (cons 'already-defined 22)))
  (define foo-inst (hashmap-ref p-inst 'foo))

  (assert= y (list 1 4))
  (assert= z (list 7 4))

  (assert=
   (list 22 2)
   (foo-inst 2))

  (assert=
   (list 3 2)
   (with-package
    [p [b 2] [already-defined 3]]
    [foo bar baz]
    (begin
      (foo 2))))

  (assert=
   (list 7 2)
   (with-package
    p
    [foo bar baz]
    (begin
      (foo 2))))

  (assert=
   (list 7 2)
   (with-package
    [p]
    [foo bar baz]
    (begin
      (foo 2)))))

;; letin
(let ()
  (letin
   [k (letin
       [i 2]
       [c 3]
       [r (+ i c)])]
   (do (assert= k 5))
   [[c k] (letin
           [i 2]
           [(c k) (values 3 4)]
           [[r m] (values (+ i c k) 0)])]
   (do (assert= c 9))
   (do (assert= k 0))))

;; list-intersperse
(let ()
  (assert= (list 0 'x 1 'x 2)
           (list-intersperse 'x (list 0 1 2)))
  (assert= (list 0)
           (list-intersperse 'x (list 0)))
  (assert= (list)
           (list-intersperse 'x (list)))
  (assert= 199
           (length (list-intersperse 'x (range 100)))))

;; path-replace-extension
(let ()
  (assert=
   "file.b.c"
   (path-replace-extension "file.b.a" ".c")))

;; define-rec
(let ()
  (define-rec rec1 aa bb)

  (let ((rec (rec1 1 2)))

    (assert (define-rec? rec))
    (assert= 1 (rec1-aa rec))
    (set-rec1-aa! rec 10)
    (assert= 10 (rec1-aa rec))))

;; apploop
(let ()
  (assert=
   120
   (apploop [x] [5] (if (= 0 x) 1 (* x (loop (- x 1)))))))

;; string-trim-chars
(let* ((s "xxhellokh")
       (tt "hx"))
  (define (test mode) (string-trim-chars s tt mode))

  (assert= "ellokh" (test 'left))
  (assert= "xxhellok" (test 'right))
  (assert= "ellok" (test 'both)))

;; hashset positive
(let ()
  (assert
   (hashset-equal?
    (make-hashset '((1 1) (1 2) (1 3) (1 4) (2 1) (2 2) (2 3) (2 4) (3 1) (3 2) (3 3) (3 4) (4 1) (4 2) (4 3) (4 4)))
    (make-hashset '((1 1) (1 2) (1 3) (1 4) (2 1) (2 2) (2 3) (2 4) (3 1) (3 2) (3 3) (3 4) (4 1) (4 2) (4 3) (4 4))))))

;; hashset negative
(let ()
  (assert
   ((negate hashset-equal?)
    (make-hashset '((1 1) (1 2) (1 3) (1 4) (2 1) (2 2) (2 3) (2 4) (3 1) (3 2) (3 3) (3 4) (4 1) (4 2) (4 3) (4 4)))
    (make-hashset '((0 0 0 0) (0 0 0 1) (0 0 1 0) (0 0 1 1) (0 1 0 0) (0 1 0 1) (0 1 1 0) (0 1 1 1) (1 0 0 0) (1 0 0 1) (1 0 1 0) (1 0 1 1) (1 1 0 0) (1 1 0 1) (1 1 1 0) (1 1 1 1))))))

;; hashset difference
(let ()
  (assert
   (hashset-equal?
    (make-hashset '(1 2 3))
    (hashset-difference
     (make-hashset '(1 2 3 4 5))
     (make-hashset '(4 5 7 8))))))

;; file-or-directory-exists?
(let ()
  (assert (file-or-directory-exists? "/"))
  (assert (file-or-directory-exists? (append-posix-path "test" "filetests" "dir1" "ab")))
  (assert (file-or-directory-exists? (append-posix-path "test" "filetests" "dir2")))
  (assert (not (file-or-directory-exists? (append-posix-path "test" "filetests" "dir3")))))

;; assert=HS
(let ()
  (assert=HS '(a b c d) '(a b c d))
  (assert=HS '(a b c d) '(b d c a)))

;; ;; Disabled due to guile's API change. TODO: fix
;; ;; directory-files
;; (let ()
;;   (assert=HS '(("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
;;              (directory-files "test/filetests"))
;;   (assert=HS '(("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
;;              (directory-files "test/filetests" #f))
;;   (assert=HS '(("test/filetests/dir1" "dir1") ("test/filetests/dir2" "dir2") ("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
;;              (directory-files "test/filetests" #t)))

;; directory-files-rec
(let ()
  (assert=HS '(("test/filetests/dir2/file1" "file1" "test/filetests/dir2" "test/filetests") ("test/filetests/dir1/dir1/zzz" "zzz" "test/filetests/dir1/dir1" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/ccc" "ccc" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/ab" "ab" "test/filetests/dir1" "test/filetests") ("test/filetests/b" "b" "test/filetests") ("test/filetests/a" "a" "test/filetests") ("test/filetests/cdefg" "cdefg" "test/filetests"))
             (directory-files-rec "test/filetests")))

(let ()
  (assert=HS '((1 2 3 4) (2 1 3 4) (1 3 2 4) (3 1 2 4) (2 3 1 4) (3 2 1 4) (1 2 4 3) (2 1 4 3) (1 4 2 3) (4 1 2 3) (2 4 1 3) (4 2 1 3) (1 3 4 2) (3 1 4 2) (1 4 3 2) (4 1 3 2) (3 4 1 2) (4 3 1 2) (2 3 4 1) (3 2 4 1) (2 4 3 1) (4 2 3 1) (3 4 2 1) (4 3 2 1))
             (list-permutations (list 1 2 3 4))))

(let ()
  (assert=HS '(() (1) (2) (1 2) (3) (1 3) (2 3) (1 2 3) (4) (1 4) (2 4) (1 2 4) (3 4) (1 3 4) (2 3 4) (1 2 3 4))
             (list-combinations (list 1 2 3 4))))

(let ()
  (assert=HS '((1 2) (1 3) (2 3) (1 4) (2 4) (3 4))
             (list-combinations (list 1 2 3 4) 2)))

(let ()
  (assert=HS '((1 1) (1 2) (1 3) (1 4) (2 1) (2 2) (2 3) (2 4) (3 1) (3 2) (3 3) (3 4) (4 1) (4 2) (4 3) (4 4))
             (list-combinations (list 1 2 3 4) 2 #t)))

(let ()
  (assert=HS '((0 0 0 0) (0 0 0 1) (0 0 1 0) (0 0 1 1) (0 1 0 0) (0 1 0 1) (0 1 1 0) (0 1 1 1) (1 0 0 0) (1 0 0 1) (1 0 1 0) (1 0 1 1) (1 1 0 0) (1 1 0 1) (1 1 1 0) (1 1 1 1))
             (list-combinations (list 0 1) 4 #t)))

;; cartesian-product
(let ()
  (assert=HS '((1 . a) (1 . b) (1 . c) (2 . a) (2 . b) (2 . c) (3 . a) (3 . b) (3 . c))
             (cartesian-product '(1 2 3) '(a b c))))

;; list-insert-at
(let ()
  (assert= '(a b c d)
           (list-insert-at '(a b d) 2 'c))

  (assert= '(a b c d)
           (list-insert-at '(b c d) 0 'a))

  (assert= '(a b c d)
           (list-insert-at '(a b c) 3 'd))

  (assert= '(a b c d)
           (list-insert-at '(a b c) 999999 'd))

  (assert= '(a b c d)
           (list-insert-at '(a b c) +inf.0 'd)))

;; list-deduplicate
(let ()
  (assert=HS '(a b c d)
           (list-deduplicate '(a b c d)))
  (assert=HS '(a b c d)
           (list-deduplicate '(a b c d c)))
  (assert=HS '(a b c d)
           (list-deduplicate '(a b c a a a d a)))
  (assert=HS '()
           (list-deduplicate '())))

;; list-deduplicate
(let ()
  (define-values (a1 a2)
    (list-break even? '(3 5 7 2 1 9)))

  (assert= a1 '(3 5 7))
  (assert= a2 '(2 1 9)))

;; list-tag
(let ()
  (assert= '((2 (5 3 1) 7 9) (6 (9 7) 1 3))
           (list-tag even? '(1 3 5 2 7 9 6 1 3)))
  (assert= '(2 6)
           (map car (list-tag even? '(1 3 5 2 7 9 6 1 3))))

  (assert= '((2 (5 3 1) 7 9) (6 (9 7)))
           (list-tag even? '(1 3 5 2 7 9 6)))
  (assert= '(2 6)
           (map car (list-tag even? '(1 3 5 2 7 9 6))))

  (assert= '((4 () 1 3 5) (2 (5 3 1) 7 9) (6 (9 7) 1 3))
           (list-tag even? '(4 1 3 5 2 7 9 6 1 3)))
  (assert= '(4 2 6)
           (map car (list-tag even? '(4 1 3 5 2 7 9 6 1 3))))

  (assert= '((4 () 1 3 5) (2 (5 3 1) 7 9) (6 (9 7)))
           (list-tag even? '(4 1 3 5 2 7 9 6)))
  (assert= '(4 2 6)
           (map car (list-tag even? '(4 1 3 5 2 7 9 6))))

  (assert= #f
           (list-tag even? '()))

  (assert= #f
           (list-tag even? '(1 3 5 7)))

  (assert= '(1 3 5 2 7 9 6)
           (list-untag (list-tag even? '(1 3 5 2 7 9 6))))

  )

;; list-tag/next
(let ()
  (assert= '((#f 1 3 5) (2 7 9) (6 1 3))
           (list-tag/next #f even? '(1 3 5 2 7 9 6 1 3)))
  (assert= '(#f 2 6)
           (map car (list-tag/next #f even? '(1 3 5 2 7 9 6 1 3))))

  (assert= '((#f 1 3 5) (2 7 9) (6))
           (list-tag/next #f even? '(1 3 5 2 7 9 6)))
  (assert= '(#f 2 6)
           (map car (list-tag/next #f even? '(1 3 5 2 7 9 6))))

  (assert= '((4 1 3 5) (2 7 9) (6 1 3))
           (list-tag/next #f even? '(4 1 3 5 2 7 9 6 1 3)))
  (assert= '(4 2 6)
           (map car (list-tag/next #f even? '(4 1 3 5 2 7 9 6 1 3))))

  (assert= '((4 1 3 5) (2 7 9) (6))
           (list-tag/next #f even? '(4 1 3 5 2 7 9 6)))
  (assert= '(4 2 6)
           (map car (list-tag/next #f even? '(4 1 3 5 2 7 9 6))))

  (assert= '((#f))
           (list-tag/next #f even? '()))

  (assert= '((#f 1 3 5 7))
           (list-tag/next #f even? '(1 3 5 7)))

  (assert= '(1 3 5 2 7 9 6 1 3)
           (list-untag/next (list-tag/next #f even? '(1 3 5 2 7 9 6 1 3))))
  (assert= '()
           (list-untag/next (list-tag/next #f even? '())))

  )

;; appcomp
(let ()
  (define f
    (comp (+ 2)
          ((lambda (x) (expt x 2)))
          (* 2)))

  (assert= 32 (f 2))

  (assert= 32
           (appcomp 2
                    (+ 2)
                    ((lambda (x) (expt x 2)))
                    (* 2))))

;; regex-machine
(let ()
  (define m (make-regex-machine*
             '(and (any x z)
                   (or (= 3) (= 2 m k))
                   (and* (any* i))
                   (any y))))
  (define H (hashmap))
  (assert (m H (list 1 2 3 9 8 7)))

  (assert=HS
   '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
   (hashmap->alist H)))

;; cfg-machine
(let ()
  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (and* (any* i))
                            (any y))))))
    (define-values (H sucess?) (m (list 1 2 3 9 8 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
     (immutable-hashmap->alist H)))

  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (call save-i)
                            (any y)))
                 (save-i (and* (any* i))))))
    (define-values (H sucess?) (m (list 1 2 3 9 8 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
     (immutable-hashmap->alist H)))

  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (call save-i)
                            (any y)))
                 (save-i (or (and (any* i) (call save-i))
                             (and (any* i)))))))
    (define-values (H sucess?) (m (list 1 2 3 9 8 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
     (immutable-hashmap->alist H)))

  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (call save-i)
                            (any y)))
                 (save-i (or (and (any* i) (call save-i))
                             (epsilon))))))
    (define-values (H sucess?) (m (list 1 2 3 9 8 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
     (immutable-hashmap->alist H)))

  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (call save-i)
                            (any y)))
                 (save-i (or (and (any* i) (call save-i))
                             (epsilon))))))
    (define-values (H sucess?) (m (list 1 2 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7))
     (immutable-hashmap->alist H))))

;; parse-cli
(let ()
  (let ()
    (define cli-decl
      '(run --opts <opts*> --param1 <arg1> --flag1? --no-flag1? <file>
            (may <nth> -p <x>)
            (june <nth> -f3? -f4?)
            (<kek*>)
            <end-statement>))
    (define IR
      (parse-cli:make-IR cli-decl))
    (define Regex
      ((parse-cli:IR->Regex '((run let go))) IR))
    (define M
      (make-regex-machine* Regex))

    (define H (hashmap))
    (define R (M H (list "go" "--flag1" "somefile" "june" "5" "the-end")))

    (assert=
     '((const . "run") (fg (param "--opts" word* . "<opts*>") (param "--param1" word . "<arg1>") (flag . "--flag1") (flag . "--no-flag1")) (word . "<file>") (or ((const . "may") (word . "<nth>") (fg (param "-p" word . "<x>"))) ((const . "june") (word . "<nth>") (fg (flag . "-f3") (flag . "-f4"))) ((word* . "<kek*>"))) (word . "<end-statement>"))
     IR "Bad IR")

    (assert=
     '(and (or (= "run" "run") (= "let" "run") (= "go" "run")) (* (or (and (= "--opts" "--opts") (* (any* "<opts*>"))) (and (= "--param1" "--param1") (any "<arg1>")) (= "--flag1" "--flag1") (= "--no-flag1" "--no-flag1"))) (any "<file>") (or (and (= "may" "may") (any "<nth>") (* (or (and (= "-p" "-p") (any "<x>"))))) (and (= "june" "june") (any "<nth>") (* (or (= "-f3" "-f3") (= "-f4" "-f4")))) (and (* (any* "<kek*>")))) (any "<end-statement>"))
     Regex "Bad Regex")

    (assert R)
    (assert=HS
     (hashmap->alist H)
     '(("<file>" . "somefile") ("<end-statement>" . "the-end") ("--flag1" . "--flag1") ("run" . "go") ("<nth>" . "5") ("june" . "june"))))

  (let ()
    (define in/out-types '(raw word normal))

    (parameterize
        ((command-line-argumets/p
          (list "--base" "10" "--soft")))

      (with-cli
       (--in <input-type>
             --soft?
             --out <output-type>
             --base <base-raw>
             --inbase <inbase-raw>
             --infinite?
             )

       :type (<input-type> in/out-types)
       :type (<output-type> in/out-types)
       :default (<input-type> 'normal)
       :default (<output-type> 'normal)

       :type (<base-raw> in/out-types 'number)
       :type (<inbase-raw> in/out-types 'number)
       :default (<base-raw> 'default)
       :default (<inbase-raw> 2)

       (assert --soft?)))))

;; make-cli
(let ()
  (define M
    (make-cli
     (run --opts <opts*> --param1 <arg1> --flag1? --no-flag1? <file>
          (may <nth> -p <x>)
          (june <nth> -f3? -f4?)
          (<kek*>)
          <end-statement>)
     :synonym (run let go)))

  (define M2
    (make-cli
     (run --flag1?)
     :synonym (run let go)))

  (assert
   (M (hashmap)
      (list "go" "--flag1" "somefile" "june" "5" "the-end")))

  (assert (M2 (hashmap) (list "go")))
  (assert (M2 (hashmap) (list "go" "--flag1")))

  )

;; lambda-cli
(let ()

  (define f
    (lambda-cli
     (run --opts <opts*> --param1 <arg1> --flag1? --no-flag1? <file>
          (may <nth> -p <x>)
          (june <nth> -f3? -f4?)
          (<kek*>)
          <end-statement>)
     :synonym (run go)
     (string-append run "-suffix")))

  (assert= "go-suffix"
           (f (list "go" "--flag1" "somefile" "june" "5" "the-end"))))

;; with-cli
(let ()

  (define ret
    (parameterize
        ((command-line-argumets/p
          (list "go" "--flag1" "-o" "fast" "-O1!" "somefile" "june" "5" "the-end")))

      (with-cli
       (run --opts <opts*> --param1 <arg1> --flag1? --no-flag1? <file>
            (may <nth> -p <x>)
            (june <nth> -f3? -f4?)
            <end-statement>)

       ;; :exclusive (--flag1? --no-flag1?)
       :synonym (--opts --options -o)
       :synonym (run let go)
       :type (<opts*> '("fast" -O0! -O1! -O2! -O3!))
       :type (<nth> 'number)
       :help (<nth> "day of month")
       :default (<arg1> 'defaultarg1)

       :help "general help here"
       :help (june "is a cool month")
       ;; :example (run --opts fast -O3! --flag1 some/fi.le june 30 goodbye))

       (assert= <arg1> "defaultarg1")
       (assert=HS <opts*> '("fast" -O1!)) ;; note the different types

       (string-append "prefix-" run "-"
                      (number->string (+ <nth> <nth>))))))

  (assert= ret "prefix-go-10"))

;; system-re
(let ()
  (assert= (cons "hello" 0) (system-re "echo hello"))
  (assert= (cons "hello" 0) (system-re "echo ~a" "hello")))

;; number-list
(let ()
  (assert= 9 (number-list->number 2 '(1 0 0 1) '()))
  (assert= 8 (number-list->number 2 '(1 0 0 0) '()))

  (assert= 0.375
           (exact->inexact (number-list->number 2 '(0 0 0 0) '(0 1 1))))
  (assert= 0.375
           (exact->inexact (number-list->number 2 '() '(0 1 1))))
  (assert= 9.375
           (exact->inexact (number-list->number 2 '(1 0 0 1) '(0 1 1))))
  (assert= 8.375
           (exact->inexact (number-list->number 2 '(1 0 0 0) '(0 1 1))))

  (let ()
    (define-values (wp fp) (number->number-list 2 9))
    (assert= wp '(1 0 0 1))
    (assert= fp '()))
  (let ()
    (define-values (wp fp) (number->number-list 2 8))
    (assert= wp '(1 0 0 0))
    (assert= fp '()))
  (let ()
    (define-values (wp fp) (number->number-list 2 0.375))
    (assert= wp '())
    (assert= fp '(0 1 1)))
  (let ()
    (define-values (wp fp) (number->number-list 2 9.375))
    (assert= wp '(1 0 0 1))
    (assert= fp '(0 1 1)))
  (let ()
    (define-values (wp fp) (number->number-list 2 8.375))
    (assert= wp '(1 0 0 0))
    (assert= fp '(0 1 1)))
  )

;; convert-number-base
(let ()
  (for-each
   (lambda (p)
     (assert= (car p) (convert-number-base 2 10 (cdr p)))
     (assert= (cdr p) (convert-number-base 10 2 (car p))))
   (list
    (cons (list #\9) (list #\1 #\0 #\0 #\1))
    (cons "9" "1001")
    (cons "8" "1000")
    (cons "0.375" "0.011")
    (cons "9.375" "1001.011")
    (cons "8.375" "1000.011")))

  (assert= "f" (convert-number-base 2 16 "1111"))
  (assert= "1111" (convert-number-base 16 2 "f")))

;; properties
(let ()

  (define object1 -3)
  (define-property absolute set-absolute! oRsDeyPCHkSMLSRztojiqnz)

  (assert= (absolute object1 #f) #f)

  (set-absolute! object1 3)

  (assert= (absolute object1 #f) 3))

;; seconds->time-string
(let ()
  (assert= "2:01:10" (seconds->time-string (+ (* 3600 2) 70))))

;; time-get-current-unixtime
(let ()
  (assert (number? (time-get-current-unixtime))))

;; time-get-monotonic-nanoseconds-timestamp
(let ()
  (let ((ret (time-get-monotonic-nanoseconds-timestamp)))
    (assert (number? ret))
    (assert (integer? ret))
    (assert (> ret 0))))

;; path-without-extension
(let ()
  (assert= "hello" (path-without-extension "hello.txt"))
  (assert= "hello.txt" (path-without-extension "hello.txt.tar"))
  (assert= "hello.txt.tar" (path-without-extension "hello.txt.tar.enc"))

  (assert= "/hi/hello" (path-without-extension "/hi/hello.txt"))
  (assert= "/hi/hello.txt" (path-without-extension "/hi/hello.txt.tar"))
  (assert= "/hi/hello.txt.tar" (path-without-extension "/hi/hello.txt.tar.enc"))

  (assert= "hello" (path-without-extension "hello"))
  (assert= "" (path-without-extension ""))
  (assert= "" (path-without-extension "."))
  )

;; path-extension
(let ()
  (assert= ".txt" (path-extension "hello.txt"))
  (assert= ".tar" (path-extension "hello.txt.tar"))
  (assert= ".enc" (path-extension "hello.txt.tar.enc"))

  (assert= ".txt" (path-extension "/hi/hello.txt"))
  (assert= ".tar" (path-extension "/hi/hello.txt.tar"))
  (assert= ".enc" (path-extension "/hi/hello.txt.tar.enc"))

  (assert= "" (path-extension "hello"))
  (assert= "" (path-extension ""))
  (assert= "." (path-extension "."))
  )

;; shell-quote
(let ()
  (assert= "'$b'" (shell-quote "$b"))
  (assert= "'$'\"'\"'b'" (shell-quote "$'b"))
  (assert= "'$ '\"'\"' b'" (shell-quote "$ ' b"))
  )

;; immutable-hashmap
(let ()
  (define H (immutable-hashmap))
  (define H2 (immutable-hashmap-set H 'a 5))
  (define H3 (immutable-hashmap-set H2 'b 9))
  (define H4 (immutable-hashmap-set H3 'a 7))

  (assert= #f (immutable-hashmap-ref H 'a #f))
  (assert= 5 (immutable-hashmap-ref H2 'a #f))
  (assert= 5 (immutable-hashmap-ref H3 'a #f))
  (assert= 9 (immutable-hashmap-ref H3 'b #f))
  (assert= 7 (immutable-hashmap-ref H4 'a #f))
  (assert= 9 (immutable-hashmap-ref H4 'b #f))
  )

(display "All good\n")

