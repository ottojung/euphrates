
%run guile

%use (get-directory-name) "./src/get-directory-name.scm"
%use (get-current-source-file-path) "./src/get-current-source-file-path.scm"
%use (append-posix-path) "./src/append-posix-path.scm"
%use (run-comprocess#p-default) "./src/run-comprocess.scm"
%use (make-uni-spinlock) "./src/uni-spinlock.scm"
%use (debug) "./src/debug.scm"
%use (with-ignore-errors!) "./src/with-ignore-errors.scm"
%use (random-choice) "./src/random-choice.scm"
%use (printable#alphabet) "./src/printable-alphabet.scm"
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
%use (hashmap-ref) "./src/ihashmap.scm"
%use (make-hashset hashset-equal?) "./src/ihashset.scm"
%use (assert=HS) "./src/assert-equal-hs.scm"
%use (list-permutations) "./src/list-permutations.scm"
%use (list-combinations) "./src/list-combinations.scm"
%use (cartesian-product) "./src/cartesian-product.scm"
%use (list-insert-at) "./src/list-insert-at.scm"
%use (list-deduplicate) "./src/list-deduplicate.scm"

(let ()
  (catch-any
   (lambda _ (assert (= (+ 3 2) (- 10 3))))
   (lambda errors
     (assert
      (equal? errors
              '((assertion-fail (test: (= 5 7)) (original: (= (+ 3 2) (- 10 3))))))))))

(let ()
  (assert (equal? 5 (string-length (list->string (random-choice 5 printable#alphabet))))))

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

;; directory-files
(let ()
  (assert=HS '(("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
             (directory-files "test/filetests"))
  (assert=HS '(("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
             (directory-files "test/filetests" #f))
  (assert=HS '(("test/filetests/dir1" "dir1") ("test/filetests/dir2" "dir2") ("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
             (directory-files "test/filetests" #t)))

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

(display "All good\n")

