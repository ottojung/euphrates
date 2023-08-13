;; parse.scm -- Parser Combinators
;; Copyright (c) 2013 Alex Shinn.  All rights reserved.
;; BSD-style license: http://synthcode.com/license.txt

;;> \section{Parse Streams}

;;> Parse streams are an abstraction to treat ports as proper streams
;;> so that we can backtrack from previous states.  A single
;;> Parse-Stream record represents a single buffered chunk of text.

(define-record-type Parse-Stream
  (%make-chibi-parse-stream
   filename port buffer cache offset prev-char line column tail)
  chibi-parse-stream?
  ;; The file the data came from, for debugging and error reporting.
  (filename chibi-parse-stream-filename)
  ;; The underlying port.
  (port chibi-parse-stream-port)
  ;; A vector of characters read from the port.  We use a vector
  ;; rather than a string for guaranteed O(1) access.
  (buffer chibi-parse-stream-buffer)
  ;; A vector of caches corresponding to chibi-parser successes or failures
  ;; starting from the corresponding char.  Currently each cache is
  ;; just an alist, optimized under the assumption that the number of
  ;; possible memoized parsers is relatively small.  Note that
  ;; memoization is only enabled explicitly.
  (cache chibi-parse-stream-cache)
  ;; The current offset of filled characters in the buffer.
  ;; If offset is non-zero, (vector-ref buffer (- offset 1)) is
  ;; valid.
  (offset chibi-parse-stream-offset chibi-parse-stream-offset-set!)
  ;; The previous char before the beginning of this Parse-Stream.
  ;; Used for line/word-boundary checks.
  (prev-char chibi-parse-stream-prev-char)
  ;; The debug info for the start line and column of this chunk.
  (line chibi-parse-stream-line)
  (column chibi-parse-stream-column)
  ;; The successor Parse-Stream chunk, created on demand and filled
  ;; from the same port.
  (tail %chibi-parse-stream-tail %chibi-parse-stream-tail-set!))

;; We want to balance avoiding reallocating buffers with avoiding
;; holding many memoized values in memory.
(define default-buffer-size 256)

;;> Create a chibi-parse stream open on the given \var{filename}, with a
;;> possibly already opened \var{port}.

(define (make-chibi-parse-stream filename . o)
  (let ((port (if (pair? o) (car o) (open-input-file filename)))
        (len (if (and (pair? o) (pair? (cdr o))) (cadr o) default-buffer-size)))
    (%make-chibi-parse-stream
     filename port (make-vector len #f) (make-vector len '()) 0 #f 0 0 #f)))

;;> Open \var{filename} and create a chibi-parse stream on it.

(define (file->chibi-parse-stream filename)
  (make-chibi-parse-stream filename (open-input-file filename)))

;;> Create a chibi-parse stream on a string \var{str}.

(define (string->chibi-parse-stream str)
  (make-chibi-parse-stream #f (open-input-string str)))

;;> Access the next buffered chunk of a chibi-parse stream.

(define (chibi-parse-stream-tail source)
  (or (%chibi-parse-stream-tail source)
      (let* ((len (vector-length (chibi-parse-stream-buffer source)))
             (line-info (chibi-parse-stream-count-lines source))
             (line (+ (chibi-parse-stream-line source) (car line-info)))
             (col (if (zero? (car line-info))
                      (+ (chibi-parse-stream-column source) (cadr line-info))
                      (cadr line-info)))
             (tail (%make-chibi-parse-stream (chibi-parse-stream-filename source)
                                       (chibi-parse-stream-port source)
                                       (make-vector len #f)
                                       (make-vector len '())
                                       0
                                       (chibi-parse-stream-last-char source)
                                       line
                                       col
                                       #f)))
        (%chibi-parse-stream-tail-set! source tail)
        tail)))

(define (chibi-parse-stream-fill! source i)
  (let ((off (chibi-parse-stream-offset source))
        (buf (chibi-parse-stream-buffer source)))
    (if (<= off i)
        (do ((off off (+ off 1)))
            ((> off i) (chibi-parse-stream-offset-set! source off))
          (vector-set! buf off (read-char (chibi-parse-stream-port source))))
        #f)))

;;> Returns true iff \var{i} is the first character position in the
;;> chibi-parse stream \var{source}.

(define (chibi-parse-stream-start? source i)
  (and (zero? i) (not (chibi-parse-stream-prev-char source))))

;;> Returns true iff \var{i} is the last character position in the
;;> chibi-parse stream \var{source}.

(define (chibi-parse-stream-end? source i)
  (eof-object? (chibi-parse-stream-ref source i)))

;;> Returns the character in chibi-parse stream \var{source} indexed by
;;> \var{i}.

(define (chibi-parse-stream-ref source i)
  (chibi-parse-stream-fill! source i)
  (vector-ref (chibi-parse-stream-buffer source) i))

(define (chibi-parse-stream-last-char source)
  (let ((buf (chibi-parse-stream-buffer source)))
    (let lp ((i (min (- (vector-length buf) 1) (chibi-parse-stream-offset source))))
      (if (negative? i)
          (chibi-parse-stream-prev-char source)
          (let ((ch (vector-ref buf i)))
            (if (eof-object? ch)
                (lp (- i 1))
                ch))))))

(define (chibi-parse-stream-char-before source i)
  (if (> i (chibi-parse-stream-offset source))
      (chibi-parse-stream-ref source (- i 1))
      (chibi-parse-stream-prev-char source)))

(define (chibi-parse-stream-max-char source)
  (let ((buf (chibi-parse-stream-buffer source)))
    (let lp ((i (min (- (vector-length buf) 1)
                     (chibi-parse-stream-offset source))))
      (if (or (negative? i)
              (char? (vector-ref buf i)))
          i
          (lp (- i 1))))))

(define (chibi-parse-stream-count-lines source . o)
  (let* ((buf (chibi-parse-stream-buffer source))
         (end (if (pair? o) (car o) (vector-length buf))))
    (let lp ((i 0) (from 0) (lines 0))
      (if (>= i end)
          (list lines (- i from) from)
          (let ((ch (vector-ref buf i)))
            (cond
             ((not (char? ch))
              (list lines (- i from) from))
             ((eqv? ch #\newline)
              (lp (+ i 1) i (+ lines 1)))
             (else
              (lp (+ i 1) from lines))))))))

(define (chibi-parse-stream-end-of-line source i)
  (let* ((buf (chibi-parse-stream-buffer source))
         (end (vector-length buf)))
    (let lp ((i i))
      (if (>= i end)
          i
          (let ((ch (vector-ref buf i)))
            (if (or (not (char? ch)) (eqv? ch #\newline))
                i
                (lp (+ i 1))))))))

(define (chibi-parse-stream-debug-info s i)
  ;; i is the failed chibi-parse index, but we want the furthest reached
  ;; location
  (if (%chibi-parse-stream-tail s)
      (chibi-parse-stream-debug-info (%chibi-parse-stream-tail s) i)
      (let ((max-char (chibi-parse-stream-max-char s)))
        (if (< max-char 0)
            (list 0 0 "")
            (let* ((line-info
                    (chibi-parse-stream-count-lines s max-char))
                   (line (+ (chibi-parse-stream-line s) (car line-info)))
                   (col (if (zero? (car line-info))
                            (+ (chibi-parse-stream-column s) (cadr line-info))
                            (cadr line-info)))
                   (from (car (cddr line-info)))
                   (to (chibi-parse-stream-end-of-line s (+ from 1)))
                   (str (chibi-parse-stream-substring s from s to)))
              (list line col str))))))

(define (chibi-parse-stream-next-source source i)
  (if (>= (+ i 1) (vector-length (chibi-parse-stream-buffer source)))
      (chibi-parse-stream-tail source)
      source))

(define (chibi-parse-stream-next-index source i)
  (if (>= (+ i 1) (vector-length (chibi-parse-stream-buffer source)))
      0
      (+ i 1)))

(define (chibi-parse-stream-close source)
  (close-input-port (chibi-parse-stream-port source)))

(define (vector-substring vec start . o)
  (let* ((end (if (pair? o) (car o) (vector-length vec)))
         (res (make-string (- end start))))
    (do ((i start (+ i 1)))
        ((= i end) res)
      (string-set! res (- i start) (vector-ref vec i)))))

(define (chibi-parse-stream-in-tail? s0 s1)
  (let ((s0^ (%chibi-parse-stream-tail s0)))
    (or (eq? s0^ s1)
        (and s0^ (chibi-parse-stream-in-tail? s0^ s1)))))

(define (chibi-parse-stream< s0 i0 s1 i1)
  (if (eq? s0 s1)
      (< i0 i1)
      (chibi-parse-stream-in-tail? s0 s1)))

;;> Returns a string composed of the characters starting at chibi-parse
;;> stream \var{s0} index \var{i0} (inclusive), and ending at \var{s1}
;;> index \var{i1} (exclusive).

(define (chibi-parse-stream-substring s0 i0 s1 i1)
  (cond
   ((eq? s0 s1)
    (chibi-parse-stream-fill! s0 i1)
    (vector-substring (chibi-parse-stream-buffer s0) i0 i1))
   (else
    (let lp ((s (chibi-parse-stream-tail s0))
             (res (list (vector-substring (chibi-parse-stream-buffer s0) i0))))
      (let ((buf (chibi-parse-stream-buffer s)))
        (cond
         ((eq? s s1)
          (apply string-append
                 (reverse (cons (vector-substring buf 0 i1) res))))
         (else
          (lp (chibi-parse-stream-tail s)
              (cons (vector-substring buf 0) res)))))))))

(define (chibi-parse-stream-cache-cell s i f)
  (assv f (vector-ref (chibi-parse-stream-cache s) i)))

(define (chibi-parse-stream-cache-set! s i f x)
  (let ((cache (vector-ref (chibi-parse-stream-cache s) i)))
    (cond
     ((assv f cache)
      => (lambda (cell)
           ;; prefer longer matches
           (if (and (pair? (cdr cell))
                    (chibi-parse-stream< (car (cddr cell)) (cadr (cddr cell)) s i))
               (set-cdr! cell x))))
     (else
      (vector-set! (chibi-parse-stream-cache s) i (cons (cons f x) cache))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;> \section{Parser Interface}

;;> Combinator to indicate failure.

(define (chibi-parse-failure s i reason)
  (let ((line+col (chibi-parse-stream-debug-info s i)))
    (error "incomplete chibi-parse at" (append line+col (list reason)))))

;;> Call the chibi-parser combinator \var{f} on the chibi-parse stream
;;> \var{source}, starting at index \var{index}, passing the result to
;;> the given success continuation \var{sk}, which should be a
;;> procedure of the form \scheme{(result source index fail)}.  The
;;> optional failure continuation should be a procedure of the form
;;> \scheme{(source index reason)}, and defaults to just returning
;;> \scheme{#f}.

(define (call-with-chibi-parse f source index sk . o)
  (let ((s (if (string? source) (string->chibi-parse-stream source) source))
        (fk (if (pair? o) (car o) (lambda (s i reason) #f))))
    (f s index sk fk)))

;;> Call the chibi-parser combinator \var{f} on the chibi-parse stream
;;> \var{source}, at index \var{index}, and return the result, or
;;> \scheme{#f} if parsing fails.

(define (chibi-parse f source . o)
  (let ((index (if (pair? o) (car o) 0)))
    (call-with-chibi-parse f source index (lambda (r s i fk) r))))

;;> Call the chibi-parser combinator \var{f} on the chibi-parse stream
;;> \var{source}, at index \var{index}.  If the entire source is not
;;> chibi-parsed, raises an error, otherwise returns the result.

(define (chibi-parse-fully f source . o)
  (let ((s (if (string? source) (string->chibi-parse-stream source) source))
        (index (if (pair? o) (car o) 0)))
    (call-with-chibi-parse
     f s index
     (lambda (r s i fk)
       (if (chibi-parse-stream-end? s i) r (fk s i "incomplete chibi-parse")))
     chibi-parse-failure)))

;;> The fundamental chibi-parse iterator.  Repeatedly applies the chibi-parser
;;> combinator \var{f} to \var{source}, starting at \var{index}, as
;;> long as a valid chibi-parse is found.  On each successful chibi-parse applies
;;> the procedure \var{kons} to the chibi-parse result and the previous
;;> \var{kons} result, beginning with \var{knil}.  If no chibi-parses
;;> succeed returns \var{knil}.

(define (chibi-parse-fold f kons knil source . o)
  (let lp ((p (if (string? source) (string->chibi-parse-stream source) source))
           (index (if (pair? o) (car o) 0))
           (acc knil))
    (f p index (lambda (r s i fk) (lp s i (kons r acc))) (lambda (s i r) acc))))

;;> Parse as many of the chibi-parser combinator \var{f} from the chibi-parse
;;> stream \var{source}, starting at \var{index}, as possible, and
;;> return the result as a list.

(define (chibi-parse->list f source . o)
  (let ((index (if (pair? o) (car o) 0)))
    (reverse (chibi-parse-fold f cons '() source index))))

;;> As \scheme{chibi-parse->list} but requires the entire source be chibi-parsed
;;> with no left over characters, signalling an error otherwise.

(define (chibi-parse-fully->list f source . o)
  (let lp ((s (if (string? source) (string->chibi-parse-stream source) source))
           (index (if (pair? o) (car o) 0))
           (acc '()))
    (f s index
       (lambda (r s i fk)
         (if (eof-object? r) (reverse acc) (lp s i (cons r acc))))
       (lambda (s i reason) (error "incomplete chibi-parse")))))

;;> Return a new chibi-parser combinator with the same behavior as \var{f},
;;> but on failure replaces the reason with \var{reason}.  This can be
;;> useful to provide more descriptive chibi-parse failure reasons when
;;> chaining combinators.  For example, \scheme{chibi-parse-string} just
;;> expects to chibi-parse a single fixed string.  If it were defined in
;;> terms of \scheme{chibi-parse-char}, failure would indicate some char
;;> failed to match, but it's more useful to describe the whole string
;;> we were expecting to see.

(define (chibi-parse-with-failure-reason f reason)
  (lambda (r s i fk)
    (f r s i (lambda (s i r) (fk s i reason)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;> \section{Basic Parsing Combinators}

;;> Parse nothing successfully.

(define chibi-parse-epsilon
  (lambda (source index sk fk)
    (sk #t source index fk)))

;;> Parse any single character successfully.  Fails at end of input.

(define chibi-parse-anything
  (lambda (source index sk fk)
    (if (chibi-parse-stream-end? source index)
        (fk source index "end of input")
        (sk (chibi-parse-stream-ref source index)
            (chibi-parse-stream-next-source source index)
            (chibi-parse-stream-next-index source index)
            fk))))

;;> Always fail to chibi-parse.

(define chibi-parse-nothing
  (lambda (source index sk fk)
    (fk source index "nothing")))

;;> The disjunction combinator.  Returns the first combinator that
;;> succeeds parsing from the same source and index.

(define (chibi-parse-or f . o)
  (if (null? o)
      f
      (let ((g (apply chibi-parse-or o)))
        (lambda (source index sk fk)
          (let ((fk2 (lambda (s i r)
                       (g source index sk fk
                          ;; (lambda (s2 i2 r2)
                          ;;   (fk s2 i2 `(or ,r ,r2)))
                          ))))
            (f source index sk fk2))))))

;;> The conjunction combinator.  If both \var{f} and \var{g} chibi-parse
;;> successfully starting at the same source and index, returns the
;;> result of \var{g}.  Otherwise fails.

(define (chibi-parse-and f g)
  (lambda (source index sk fk)
    (f source index (lambda (r s i fk) (g source index sk fk)) fk)))

;;> The negation combinator.  If \var{f} succeeds, fails, otherwise
;;> succeeds with \var{#t}.

(define (chibi-parse-not f)
  (lambda (source index sk fk)
    (f source index (lambda (r s i fk) (fk s i "not"))
       (lambda (s i r) (sk #t source index fk)))))

(define (chibi-parse-seq-list o)
  (cond
   ((null? o)
    chibi-parse-epsilon)
   ((null? (cdr o))
    (let ((f (car o)))
      (lambda (s i sk fk)
        (f s i (lambda (r s i fk)
                 (sk (if (eq? r ignored-value) '() (list r)) s i fk))
           fk))))
   (else
    (let* ((f (car o))
           (o (cdr o))
           (g (car o))
           (o (cdr o))
           (g (if (pair? o)
                  (apply chibi-parse-seq g o)
                  (lambda (s i sk fk)
                    (g s i (lambda (r s i fk)
                             (sk (if (eq? r ignored-value) '() (list r))
                                 s i fk))
                       fk)))))
      (lambda (source index sk fk)
        (f source
           index
           (lambda (r s i fk)
             (g s i (lambda (r2 s i fk)
                      (let ((r2 (if (eq? r ignored-value) r2 (cons r r2))))
                        (sk r2 s i fk)))
                fk))
           fk))))))

;;> The sequence combinator.  Each combinator is applied in turn just
;;> past the position of the previous.  If all succeed, returns a list
;;> of the results in order, skipping any ignored values.

(define (chibi-parse-seq . o)
  (chibi-parse-seq-list o))

;;> Convert the list of chibi-parser combinators \var{ls} to a
;;> \scheme{chibi-parse-seq} sequence.

(define (list->chibi-parse-seq ls)
  (if (null? (cdr ls)) (car ls) (chibi-parse-seq-list ls)))

;;> The optional combinator.  Parse the combinator \var{f} (in
;;> sequence with any additional combinator args \var{o}), and return
;;> the result, or chibi-parse nothing successully on failure.

(define (chibi-parse-optional f . o)
  (if (pair? o)
      (chibi-parse-optional (apply chibi-parse-seq f o))
      (lambda (source index sk fk)
        (f source index sk (lambda (s i r) (sk #f source index fk))))))

(define ignored-value (list 'ignore))

;;> The repetition combinator.  Parse \var{f} repeatedly and return a
;;> list of the results.  \var{lo} is the minimum number of chibi-parses
;;> (deafult 0) to be considered a successful chibi-parse, and \var{hi} is
;;> the maximum number (default infinite) before stopping.

(define (chibi-parse-repeat f . o)
  (let ((lo (if (pair? o) (car o) 0))
        (hi (and (pair? o) (pair? (cdr o)) (cadr o))))
    (lambda (source0 index0 sk fk)
      (let repeat ((source source0) (index index0) (fk fk) (j 0) (res '()))
        (let ((fk (if (>= j lo)
                      (lambda (s i r) (sk (reverse res) source index fk))
                      fk)))
          (if (and hi (= j hi))
              (sk (reverse res) source index fk)
              (f source
                 index
                 (lambda (r s i fk) (repeat s i fk (+ j 1) (cons r res)))
                 fk)))))))

;;> Parse \var{f} one or more times.

(define (chibi-parse-repeat+ f)
  (chibi-parse-repeat f 1))

;;> Parse \var{f} and apply the procedure \var{proc} to the result on success.

(define (chibi-parse-map f proc)
  (lambda (source index sk fk)
    (f source index (lambda (res s i fk) (sk (proc res) s i fk)) fk)))

;;> Parse \var{f} and apply the procedure \var{proc} to the substring
;;> of the chibi-parsed data.  \var{proc} defaults to the identity.

(define (chibi-parse-map-substring f . o)
  (let ((proc (if (pair? o) (car o) (lambda (res) res))))
    (lambda (source index sk fk)
      (f source
         index
         (lambda (res s i fk)
           (sk (proc (chibi-parse-stream-substring source index s i)) s i fk))
         fk))))

;;> Parses the same streams as \var{f} but ignores the result on
;;> success.  Inside a \scheme{chibi-parse-seq} the result will not be
;;> included in the list of results.  Useful for discarding
;;> boiler-plate without the need for post-processing results.

(define (chibi-parse-ignore f)
  (chibi-parse-map f (lambda (res) ignored-value)))

;;> Parse with \var{f} and further require \var{check?} to return true
;;> when applied to the result.

(define (chibi-parse-assert f check?)
  (lambda (source index sk fk)
    (f source
       index
       (lambda (res s i fk)
         (if (check? res) (sk res s i fk) (fk s i "assertion failed")))
       fk)))

;;> Parse with \var{f} once and keep the first result, not allowing
;;> further backtracking within \var{f}.

(define (chibi-parse-atomic f)
  (lambda (source index sk fk)
    (f source index (lambda (res s i fk2) (sk res s i fk)) fk)))

;;> Parse with \var{f} once, keep the first result, and commit to the
;;> current chibi-parse path, discarding any prior backtracking options.
;;> Since prior backtracking options are discarded, prior failure
;;> continuations are also not used. By default, \scheme{#f} is
;;> returned on failure, a custom failure continuation can be passed
;;> as the second argument.

(define (chibi-parse-commit f . o)
  (let ((commit-fk (if (pair? o) (car o) (lambda (s i r) #f))))
    (lambda (source index sk fk)
      (f source index (lambda (res s i fk) (sk res s i commit-fk)) fk))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;> \section{Boundary Checks}

;;> Returns true iff \var{index} is the first index of the first chibi-parse
;;> stream \var{source}.

(define chibi-parse-beginning
  (lambda (source index sk fk)
    (if (chibi-parse-stream-start? source index)
        (sk #t source index fk)
        (fk source index "expected beginning"))))

;;> Returns true iff \var{index} is the last index of the last chibi-parse
;;> stream \var{source}.

(define chibi-parse-end
  (lambda (source index sk fk)
    (if (chibi-parse-stream-end? source index)
        (sk #t source index fk)
      (fk source index "expected end"))))

;;> Returns true iff \var{source}, \var{index} indicate the beginning
;;> of a line (or the entire stream).

(define chibi-parse-beginning-of-line
  (lambda (source index sk fk)
    (let ((before (chibi-parse-stream-char-before source index)))
      (if (or (not before) (eqv? #\newline before))
          (sk #t source index fk)
          (fk source index "expected beginning of line")))))

;;> Returns true iff \var{source}, \var{index} indicate the end of a
;;> line (or the entire stream).

(define chibi-parse-end-of-line
  (lambda (source index sk fk)
    (if (or (chibi-parse-stream-end? source index)
            (eqv? #\newline (chibi-parse-stream-ref source index)))
        (sk #t source index fk)
        (fk source index "expected end of line"))))

(define (char-word? ch)
  (or (char-alphabetic? ch) (eqv? ch #\_)))

;;> Returns true iff \var{source}, \var{index} indicate the beginning
;;> of a word (or the entire stream).

(define chibi-parse-beginning-of-word
  (lambda (source index sk fk)
    (let ((before (chibi-parse-stream-char-before source index)))
      (if (and (or (not before) (not (char-word? before)))
               (not (chibi-parse-stream-end? source index))
               (char-word? (chibi-parse-stream-ref source index)))
          (sk #t source index fk)
          (fk source index "expected beginning of word")))))

;;> Returns true iff \var{source}, \var{index} indicate the end of a
;;> word (or the entire stream).

(define chibi-parse-end-of-word
  (lambda (source index sk fk)
    (let ((before (chibi-parse-stream-char-before source index)))
      (if (and before
               (char-word? before)
               (or (chibi-parse-stream-end? source index)
                   (not (char-word? (chibi-parse-stream-ref source index)))))
          (sk #t source index fk)
          (fk source index "expected end of word")))))

;;> Parse the combinator \var{word} (default a \scheme{chibi-parse-token} of
;;> \scheme{char-alphabetic?} or underscores), ensuring it begins and
;;> ends on a word boundary.

(define (chibi-parse-word . o)
  (let ((word (if (pair? o) (car o) (chibi-parse-token char-word?))))
    (lambda (source index sk fk)
      (chibi-parse-map
       (chibi-parse-seq chibi-parse-beginning-of-word
                  word
                  chibi-parse-end-of-word)
       cadr))))

;;> As \scheme{chibi-parse-word}, but instead of an arbitrary word
;;> combinator takes a character predicate \var{pred} (conjoined with
;;> \scheme{char-alphabetic?} or underscore), and chibi-parses a sequence of
;;> those characters with \scheme{chibi-parse-token}.  Returns the chibi-parsed
;;> substring.

(define (chibi-parse-word+ . o)
  (let ((pred (if (pair? o)
                  (lambda (ch) (and (char-word? ch) ((car o) ch)))
                  char-word?)))
    (chibi-parse-word (chibi-parse-token pred))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;> \section{Constant Parsers}

(define (chibi-parse-char-pred pred)
  (lambda (source index sk fk)
    (let ((ch (chibi-parse-stream-ref source index)))
      (if (and (char? ch) (pred ch))
          (sk ch
              (chibi-parse-stream-next-source source index)
              (chibi-parse-stream-next-index source index)
              fk)
          (fk source index "failed char pred")))))

(define (x->char-predicate x)
  (cond
   ((char? x)
    (lambda (ch) (eqv? ch x)))
   ((char-set? x)
    (lambda (ch) (and (char? ch) (char-set-contains? x ch))))
   ((procedure? x)
    (lambda (ch) (and (char? ch) (x ch))))
   (else
    (error "don't know how to handle char predicate" x))))

;;> Parse a single char which matches \var{x}, which can be a
;;> character, character set, or arbitrary procedure.

(define (chibi-parse-char x)
  (chibi-parse-char-pred (x->char-predicate x)))

;;> Parse a single char which does not match \var{x}, which can be a
;;> character, character set, or arbitrary procedure.

(define (chibi-parse-not-char x)
  (let ((pred (x->char-predicate x)))
    (chibi-parse-char-pred (lambda (ch) (not (pred ch))))))

;;> Parse the exact string \var{str}.

(define (chibi-parse-string str)
  (chibi-parse-map (chibi-parse-with-failure-reason
              (chibi-parse-seq-list (map chibi-parse-char (string->list str)))
              (string-append "expected '" str "'"))
             list->string))

;;> Parse a sequence of characters matching \var{x} as with
;;> \scheme{chibi-parse-char}, and return the resulting substring.

(define (chibi-parse-token x)
  ;; (chibi-parse-map (chibi-parse-repeat+ (chibi-parse-char x)) list->string)
  ;; Tokens are atomic - we don't want to split them at any point in
  ;; the middle - so the implementation is slightly more complex than
  ;; the above.  With a sane grammar the result would be the same
  ;; either way, but this provides a useful optimization.
  (let ((f (chibi-parse-char x)))
    (lambda (source0 index0 sk fk)
      (let lp ((source source0) (index index0))
        (f source
           index
           (lambda (r s i fk) (lp s i))
           (lambda (s i r)
             (if (and (eq? source source0) (eqv? index index0))
                 (fk s i r)
                 (sk (chibi-parse-stream-substring source0 index0 source index)
                     source index fk))))))))

;;> We provide an extended subset of SRE syntax (see
;;> \hyperlink["http://srfi.schemers.org/srfi-115/srfi-115.html"]{SRFI 115}),
;;> taking advantage of more general parsing features.  These are just
;;> translated directly into chibi-parser combinators, with characters and
;;> strings implicitly matching themselves.  For example, \scheme{'(or
;;> "foo" "bar")} matches either of the strings \scheme{"foo"} or
;;> \scheme{"bar"}.  Existing chibi-parser combinators may be embedded directly.
;;> This is of course more powerful than SREs since it is not
;;> restricted to regular languages (or in fact any languages), though
;;> it does not provide the same performance guarantees.

(define (chibi-parse-sre x)
  (define (ranges->char-set ranges)
    (let lp ((ls ranges) (res (char-set)))
      (cond
       ((null? ls)
        res)
       ((string? (car ls))
        (lp (append (string->list (car ls)) (cdr ls)) res))
       ((null? (cdr ls))
        (error "incomplete range in / char-set" ranges))
       (else
        (let ((cs (ucs-range->char-set (char->integer (car ls))
                                       (+ 1 (char->integer (cadr ls))))))
          (lp (cddr ls) (char-set-union cs res)))))))
  (define (sre-list->char-set ls)
    (apply char-set-union (map sre->char-set ls)))
  (define (sre->char-set x)
    (cond
     ((char? x) (char-set x))
     ((string? x) (if (= 1 (string-length x))
                      (string->char-set x)
                      (error "multi-element string in char-set" x)))
     ((pair? x)
      (if (and (string? (car x)) (null? (cdr x)))
          (string->char-set (car x))
          (case (car x)
            ((/) (ranges->char-set (cdr x)))
            ((~) (char-set-complement (sre-list->char-set (cdr x))))
            ((-) (apply char-set-difference (map sre->char-set (cdr x))))
            ((&) (apply char-set-intersection (map sre->char-set (cdr x))))
            ((or) (sre-list->char-set (cdr x)))
            (else (error "unknown SRE char-set operator" x)))))
     (else (error "unknown SRE char-set" x))))
  (cond
   ((procedure? x)  ; an embedded chibi-parser
    x)
   ((or (char? x) (char-set? x))
    (chibi-parse-char x))
   ((string? x)
    (chibi-parse-string x))
   ((null? x)
    chibi-parse-epsilon)
   ((list? x)
    (case (car x)
      ((: seq) (chibi-parse-seq-list (map chibi-parse-sre (cdr x))))
      ((or) (apply chibi-parse-or (map chibi-parse-sre (cdr x))))
      ((and) (apply chibi-parse-and (map chibi-parse-sre (cdr x))))
      ((not) (apply chibi-parse-not (map chibi-parse-sre (cdr x))))
      ((*) (chibi-parse-repeat (list->chibi-parse-seq (map chibi-parse-sre (cdr x)))))
      ((+) (chibi-parse-repeat+ (list->chibi-parse-seq (map chibi-parse-sre (cdr x)))))
      ((?) (chibi-parse-optional (chibi-parse-seq-list (map chibi-parse-sre (cdr x)))))
      ((=> ->) (list->chibi-parse-seq (map chibi-parse-sre (cddr x))))
      ((word) (apply chibi-parse-word (cdr x)))
      ((word+) (apply chibi-parse-word+ (cdr x)))
      ((/ ~ & -) (chibi-parse-char (sre->char-set x)))
      (else
       (if (string? (car x))
           (chibi-parse-char (sre->char-set x))
           (error "unknown SRE operator" x)))))
   (else
    (case x
      ((any) chibi-parse-anything)
      ((nonl) (chibi-parse-char (lambda (ch) (not (eqv? ch #\newline)))))
      ((space whitespace) (chibi-parse-char char-whitespace?))
      ((digit numeric) (chibi-parse-char char-numeric?))
      ((alpha alphabetic) (chibi-parse-char char-alphabetic?))
      ((alnum alphanumeric)
       (chibi-parse-char-pred (lambda (ch) (or (char-alphabetic? ch) (char-numeric? ch)))))
      ((lower lower-case) (chibi-parse-char char-lower-case?))
      ((upper upper-case) (chibi-parse-char char-upper-case?))
      ((word) (chibi-parse-word))
      ((bow) chibi-parse-beginning-of-word)
      ((eow) chibi-parse-end-of-word)
      ((bol) chibi-parse-beginning-of-line)
      ((eol) chibi-parse-end-of-line)
      ((bos) chibi-parse-beginning)
      ((eos) chibi-parse-end)
      (else (error "unknown SRE chibi-parser" x))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;> \section{Laziness}

;;> A delayed combinator.  This is equivalent to the chibi-parser combinator
;;> \var{f}, but is delayed so it can be more efficient if never used
;;> and \var{f} is expensive to compute.  Moreover, it can allow
;;> self-referentiality as in:
;;>
;;> \schemeblock{
;;> (letrec* ((f (chibi-parse-lazy (chibi-parse-or (chibi-parse-seq g f) h))))
;;>   ...)
;;> }

(define-syntax chibi-parse-lazy
  (syntax-rules ()
    ((chibi-parse-lazy f)
     (let ((g (delay f)))
       (lambda (source index sk fk)
         ((force g) source index sk fk))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;> \section{Memoization}

;; debugging
(define *procedures* '())
(define (procedure-name f)
  (cond ((assq f *procedures*) => cdr) (else #f)))
(define (procedure-name-set! f name)
  (set! *procedures* (cons (cons f name) *procedures*)))

(define memoized-failure (list 'failure))

;;> Parse the same strings as \var{f}, but memoize the result at each
;;> source and index to avoid exponential backtracking.  \var{name} is
;;> provided for debugging only.

(define (chibi-parse-memoize name f)
  ;;(if (not (procedure-name f)) (procedure-name-set! f name))
  (lambda (source index sk fk)
    (cond
     ((chibi-parse-stream-cache-cell source index f)
      => (lambda (cell)
           (if (and (pair? (cdr cell)) (eq? memoized-failure (cadr cell)))
               (fk source index (cddr cell))
               (apply sk (append (cdr cell) (list fk))))))
     (else
      (f source
         index
         (lambda (res s i fk)
           (chibi-parse-stream-cache-set! source index f (list res s i))
           (sk res s i fk))
         (lambda (s i r)
           (if (not (pair? (chibi-parse-stream-cache-cell source index f)))
               (chibi-parse-stream-cache-set!
                source index f (cons memoized-failure r)))
           (fk s i r)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;> \section{Syntax}

;;> The four basic interfaces are \scheme{grammar},
;;> \scheme{define-grammar}, and their unmemoized variants
;;> \scheme{grammar/unmemoized} and
;;> \scheme{define-grammar/unmemoized}.  This is optimized for the
;;> common case - generally you want to memoize grammars, and may or
;;> may not want to memoize the smaller lexical components.

;;> \macro{(grammar/unmemoized init (rule (clause [action]) ...) ...)}
;;>
;;> Describe an grammar for the given named \var{rules} and return the
;;> rule named \var{init}.  The rules are chibi-parser combinators which
;;> match the first \var{clause} which succeeds, and returns the
;;> corresponding action.  Each \var{clause} is an SRE chibi-parser as in
;;> \scheme{chibi-parse-sre}, which may include embdedded chibi-parser combinators
;;> with \scheme{unquote} (,).  In particular, the rule itself and any
;;> other rules can be referenced in this way.  The optional
;;> \var{action}, which defaults to the normal result of the clause
;;> chibi-parser, is a normal Scheme expression with all \scheme{->} named
;;> expressions in clause bound to the corresponding result.
;;> Alternately, \var{action} can be of the form \scheme{=> receiver}
;;> to send the results directly to a success continuation as in
;;> \scheme{call-with-chibi-parse}.

(define-syntax grammar/unmemoized
  (syntax-rules ()
    ((grammar/unmemoized init (rule (clause . action) ...) ...)
     (letrec ((rule (chibi-parse-or (grammar-clause clause . action) ...))
              ...)
       init))))

;;> \macro{(grammar init (rule (clause [action]) ...) ...)}
;;>
;;> Equivalent to \scheme{grammar} but memoizes each clause.  Parsers
;;> nested within each clause are not automatically memoized, so if
;;> necessary should be memoized explicitly or split out into separate
;;> rules.

(define-syntax grammar
  (syntax-rules ()
    ((grammar init (rule (clause . action) ...) ...)
     (letrec ((rule
               (chibi-parse-memoize
                'rule
                (chibi-parse-or (grammar-clause clause . action) ...)))
              ...)
       init))))

;;> \macro{(define-grammar/unmemoized name (rule (clause [action]) ...) ...)}
;;>
;;> Similar to \scheme{grammar/unmemoized}, instead of returning a
;;> single entry point chibi-parser defines each \var{rule} as its own
;;> chibi-parser.  Also defines \var{name} as an alist mapping rule names to
;;> their values.

(define-syntax define-grammar/unmemoized
  (syntax-rules ()
    ((define-grammar/unmemoized name (rule (clause . action) ...) ...)
     (begin
       (define rule (chibi-parse-or (grammar-clause clause . action) ...))
       ...
       (define name (list (cons 'rule rule) ...))))))

;;> \macro{(define-grammar name (rule (clause [action]) ...) ...)}
;;>
;;> The memoized version of \scheme{define-grammar/unmemoized}.
;;>
;;> Example:
;;>
;;> \example{
;;> (define-grammar calc
;;>   (space ((* ,(chibi-parse-char char-whitespace?))))
;;>   (number ((-> n (+ ,(chibi-parse-char char-numeric?)))
;;>            (string->number (list->string n))))
;;>   (simple ((-> n ,number) n)
;;>           ((: "(" (=> e1 ,term) ")") e1))
;;>   (term-op ("*" *)
;;>            ("/" /)
;;>            ("%" modulo))
;;>   (term ((: (-> e1 ,simple) ,space (-> op ,term-op) ,space (-> e2 ,term))
;;>          (op e1 e2))
;;>         ((-> e1 ,simple)
;;>          e1)))
;;> (chibi-parse term "12 / (2*3)")
;;> }

(define-syntax define-grammar
  (syntax-rules ()
    ((define-grammar name (rule (clause . action) ...) ...)
     (begin
       (define rule
         (chibi-parse-memoize 'rule (chibi-parse-or (grammar-clause clause . action) ...)))
       ...
       (define name (list (cons 'rule rule) ...))))))

;; Most of the implementation goes into how we chibi-parse a single grammar
;; clause.  This is hard to read if you're not used to CPS macros.

(define-syntax grammar-clause
  (syntax-rules ()
    ((grammar-clause clause . action)
     (grammar-extract clause () (grammar-action action)))))

(define-syntax grammar-extract
  (syntax-rules (unquote -> => : seq * + ? or and)
    ;; Named patterns
    ((grammar-extract (-> name pattern) bindings k)
     (grammar-extract pattern bindings (grammar-bind name k)))
    ((grammar-extract (-> name pattern ...) bindings k)
     (grammar-extract (: pattern ...) bindings (grammar-bind name k)))
    ;; Allow => as an alias for -> for SRE compatibility.
    ((grammar-extract (=> name pattern) bindings k)
     (grammar-extract pattern bindings (grammar-bind name k)))
    ((grammar-extract (=> name pattern ...) bindings k)
     (grammar-extract (: pattern ...) bindings (grammar-bind name k)))
    ((grammar-extract ,name bindings k)
     (grammar-bind name k (chibi-parse-sre name) bindings))
    ;; Walk container patterns.
    ((grammar-extract (: x y ...) bindings k)
     (grammar-extract x bindings (grammar-map chibi-parse-seq (y ...) () k)))
    ((grammar-extract (* x) bindings k)
     (grammar-extract x bindings (grammar-map chibi-parse-repeat () () k)))
    ((grammar-extract (* x y ...) bindings k)
     (grammar-extract (: x y ...) bindings (grammar-map chibi-parse-repeat () () k)))
    ((grammar-extract (+ x) bindings k)
     (grammar-extract x bindings (grammar-map chibi-parse-repeat+ () () k)))
    ((grammar-extract (+ x y ...) bindings k)
     (grammar-extract (: x y ...) bindings (grammar-map chibi-parse-repeat+ () () k)))
    ((grammar-extract (? x y ...) bindings k)
     (grammar-extract x bindings (grammar-map chibi-parse-optional (y ...) () k)))
    ((grammar-extract (or x y ...) bindings k)
     (grammar-extract x bindings (grammar-map chibi-parse-or (y ...) () k)))
    ((grammar-extract (and x y ...) bindings k)
     (grammar-extract x bindings (grammar-map chibi-parse-and (y ...) () k)))
    ;; Anything else is an implicitly quasiquoted SRE
    ((grammar-extract pattern bindings (k ...))
     (k ... (chibi-parse-sre `pattern) bindings))))

(define-syntax grammar-map
  (syntax-rules ()
    ((grammar-map f () (args ...) (k ...) x bindings)
     (k ... (f args ... x) bindings))
    ((grammar-map f (y . rest) (args ...) k x bindings)
     (grammar-extract y bindings (grammar-map f rest (args ... x) k)))))

(define-syntax grammar-action
  (syntax-rules (=>)
    ((grammar-action () chibi-parser bindings)
     ;; By default just return the result.
     (grammar-action (=> (lambda (r s i fk) r)) chibi-parser bindings))
    ((grammar-action (=> receiver) chibi-parser ((var tmp) ...))
     ;; Explicit => handler.
     (lambda (source index sk fk)
       (let ((tmp #f) ...)
         (chibi-parser source
                 index
                 (lambda (r s i fk)
                   (sk (receiver r s i fk) s i fk))
                 fk))))
    ((grammar-action (action-expr) chibi-parser ())
     ;; Fast path - no named variables.
     (let ((f chibi-parser))
       (lambda (source index sk fk)
         (f source index (lambda (r s i fk) (sk action-expr s i fk)) fk))))
    ((grammar-action (action-expr) chibi-parser ((var tmp) ...))
     (lambda (source index sk fk)
       (let ((tmp #f) ...)
         ;; TODO: Precompute static components of the chibi-parser.
         ;; We need to bind fresh variables on each chibi-parse, so some
         ;; components must be reified in this scope.
         (chibi-parser source
                 index
                 (lambda (r s i fk)
                   (sk (let ((var tmp) ...) action-expr) s i fk))
                 fk))))))


;;; COMMON FILE:


(define (char-hex-digit? ch)
  (or (char-numeric? ch)
      (memv (char-downcase ch) '(#\a #\b #\c #\d #\e #\f))))

(define (char-octal-digit? ch)
  (and (char? ch) (char<=? #\0 ch #\7)))

(define (chibi-parse-assert-range proc lo hi)
  (if (or lo hi)
      (chibi-parse-assert proc (lambda (n)
                          (and (or (not lo) (<= lo n))
                               (or (not hi) (<= n hi)))))
      proc))

(define (chibi-parse-unsigned-integer . o)
  (let ((lo (and (pair? o) (car o)))
        (hi (and (pair? o) (pair? (cdr o)) (cadr o))))
    (chibi-parse-assert-range
     (chibi-parse-map (chibi-parse-token char-numeric?) string->number)
     lo hi)))

(define (chibi-parse-sign+)
  (chibi-parse-or (chibi-parse-char #\+) (chibi-parse-char #\-)))

(define (chibi-parse-sign)
  (chibi-parse-or (chibi-parse-sign+) chibi-parse-epsilon))

(define (chibi-parse-integer . o)
  (let ((lo (and (pair? o) (car o)))
        (hi (and (pair? o) (pair? (cdr o)) (cadr o))))
    (chibi-parse-assert-range
     (chibi-parse-map-substring
      (chibi-parse-seq (chibi-parse-sign) (chibi-parse-token char-numeric?)
                 ;; (chibi-parse-not (chibi-parse-or (chibi-parse-sign) (chibi-parse-char #\.)))
                 )
      string->number)
     lo hi)))

(define (chibi-parse-c-integer)
  (chibi-parse-or
   (chibi-parse-map (chibi-parse-seq (chibi-parse-string "0x") (chibi-parse-token char-hex-digit?))
              (lambda (x) (string->number (cadr x) 16)))
   (chibi-parse-map (chibi-parse-seq (chibi-parse-string "0") (chibi-parse-token char-octal-digit?))
              (lambda (x) (string->number (cadr x) 8)))
   (chibi-parse-integer)))

(define (chibi-parse-real)
  (chibi-parse-map-substring
   (chibi-parse-seq
    (chibi-parse-or
     (chibi-parse-seq (chibi-parse-sign) (chibi-parse-repeat+ (chibi-parse-char char-numeric?))
                (chibi-parse-optional
                 (chibi-parse-seq (chibi-parse-char #\.)
                            (chibi-parse-repeat (chibi-parse-char char-numeric?)))))
     (chibi-parse-seq (chibi-parse-sign) (chibi-parse-char #\.)
                (chibi-parse-repeat+ (chibi-parse-char char-numeric?))))
    (chibi-parse-optional
     (chibi-parse-seq (chibi-parse-char (lambda (ch) (eqv? #\e (char-downcase ch))))
                (chibi-parse-sign)
                (chibi-parse-repeat+ (chibi-parse-char char-numeric?)))))
   string->number))

(define (chibi-parse-imag)
  (chibi-parse-or (chibi-parse-char #\i) (chibi-parse-char #\I)))

(define (chibi-parse-complex)
  (chibi-parse-map-substring
   (chibi-parse-or
    (chibi-parse-seq (chibi-parse-real) (chibi-parse-sign+) (chibi-parse-real) (chibi-parse-imag))
    (chibi-parse-seq (chibi-parse-real) (chibi-parse-imag))
    (chibi-parse-real))
   string->number))

(define (chibi-parse-identifier . o)
  ;; Slightly more complicated than mapping chibi-parse-token because the
  ;; typical identifier syntax has different initial and subsequent
  ;; char-sets.
  (let* ((init?
          (if (pair? o)
              (car o)
              (lambda (ch) (or (eqv? #\_ ch) (char-alphabetic? ch)))))
         (init (chibi-parse-char init?))
         (subsequent
          (chibi-parse-char
           (if (and (pair? o) (pair? (cdr o)))
               (cadr o)
               (lambda (ch) (or (init? ch) (char-numeric? ch)))))))
    (lambda (source0 index0 sk0 fk0)
      (init
       source0
       index0
       (lambda (res source index fk2)
         (let lp ((s source) (i index))
           (subsequent
            s i (lambda (r s i fk) (lp s i))
            (lambda (s i r)
              (sk0 (string->symbol (chibi-parse-stream-substring source0 index0 s i))
                   s i fk0)))))
       fk0))))

(define (chibi-parse-delimited . o)
  (let ((delim (if (pair? o) (car o) #\"))
        (esc (if (and (pair? o) (pair? (cdr o))) (cadr o) #\\))
        (chibi-parse-esc (if (and (pair? o) (pair? (cdr o)) (pair? (cddr o)))
                       (car (cddr o))
                       chibi-parse-anything)))
    (chibi-parse-map
     (chibi-parse-seq
      (chibi-parse-char delim)
      (chibi-parse-repeat
       (chibi-parse-or (chibi-parse-char
                  (lambda (ch)
                    (and (not (eqv? ch delim)) (not (eqv? ch esc)))))
                 (chibi-parse-map (chibi-parse-seq (chibi-parse-char esc)
                                       (if (eqv? delim esc)
                                           (chibi-parse-char esc)
                                           chibi-parse-esc))
                            cadr)))
      (chibi-parse-char delim))
     (lambda (res) (list->string (cadr res))))))

(define (chibi-parse-separated . o)
  (let* ((sep (if (pair? o) (car o) #\,))
         (o1 (if (pair? o) (cdr o) '()))
         (delim (if (pair? o1) (car o1) #\"))
         (o2 (if (pair? o1) (cdr o1) '()))
         (esc (if (pair? o2) (car o2) delim))
         (o3 (if (pair? o2) (cdr o2) '()))
         (ok?
          (if (pair? o3)
              (let ((pred (car o3)))
                (lambda (ch)
                  (and (not (eqv? ch delim))
                       (not (eqv? ch sep))
                       (pred ch))))
              (lambda (ch) (and (not (eqv? ch delim)) (not (eqv? ch sep))))))
         (chibi-parse-field
          (chibi-parse-or (chibi-parse-delimited delim esc)
                    (chibi-parse-map-substring
                     (chibi-parse-repeat+ (chibi-parse-char ok?))))))
    (chibi-parse-map
     (chibi-parse-seq chibi-parse-field
                (chibi-parse-repeat
                 (chibi-parse-map (chibi-parse-seq (chibi-parse-char sep) chibi-parse-field) cadr)))
     (lambda (res) (cons (car res) (cadr res))))))

(define (chibi-parse-records . o)
  (let* ((terms (if (pair? o) (car o) '("\r\n" "\n")))
         (terms (if (list? terms) terms (list terms)))
         (term-chars (apply append (map string->list terms)))
         (ok? (lambda (ch) (not (memv ch term-chars))))
         (o (if (pair? o) (cdr o) '()))
         (sep (if (pair? o) (car o) #\,))
         (o (if (pair? o) (cdr o) '()))
         (delim (if (pair? o) (car o) #\"))
         (o (if (pair? o) (cdr o) '()))
         (esc (if (pair? o) (car o) delim)))
    (chibi-parse-repeat
     (chibi-parse-map
      (chibi-parse-seq (chibi-parse-separated sep delim esc ok?)
                 (apply chibi-parse-or chibi-parse-end (map chibi-parse-string terms)))
      car))))

(define chibi-parse-space (chibi-parse-char char-whitespace?))

(define (op-value op) (car op))
(define (op-prec op) (cadr op))
(define (op-assoc op)
  (let ((tail (cddr op))) (if (pair? tail) (car tail) 'left)))
(define (op<? op1 op2)
  (or (< (op-prec op1) (op-prec op2))
      (and (= (op-prec op1) (op-prec op2))
           (eq? 'right (op-assoc op1)))))

;; rules are of the form ((op precedence [assoc=left]) ...)
;; ls is of the forms (expr [op expr] ...)
;; returns an sexp representation of the operator chain
(define (resolve-operator-precedence rules ls)
  (define (lookup op rules)
    (or (assoc op rules)
        (list op 0)))
  (define (join exprs ops)
    `((,(op-value (car ops)) ,(cadr exprs) ,(car exprs))
      ,@(cddr exprs)))
  (if (null? ls) (error "empty operator chain"))
  (let lp ((ls (cdr ls)) (exprs (list (car ls))) (ops '((#f -1))))
    ;; ls: trailing operations ([op expr] ...)
    ;; exprs: list of expressions (expr expr ...)
    ;; ops: operator chain, same len as exprs ((op prec [assoc]) ...)
    (cond
     ((and (null? ls) (null? (cdr exprs)))
      (car exprs))
     ((null? ls)
      (lp ls (join exprs ops) (cdr ops)))
     ((null? (cdr ls))
      (error "unbalanced expression" ls))
     (else
      (let ((op (lookup (car ls) rules))
            (expr (cadr ls)))
        (if (or (null? (cdr ops)) (op<? op (car ops)))
            (lp (cddr ls) (cons expr exprs) (cons op ops))
            (lp ls (join exprs ops) (cdr ops))))))))

(define (chibi-parse-binary-op op rules expr . o)
  (let* ((ws (if (pair? o) (car o) (chibi-parse-repeat chibi-parse-space)))
         (ws-right (if (and (pair? o) (pair? (cdr o))) (cadr o) ws)))
    (chibi-parse-map
     (chibi-parse-seq ws expr (chibi-parse-repeat (chibi-parse-seq ws-right op ws expr)))
     (lambda (x)
       (resolve-operator-precedence
        rules
        (cons (cadr x)
              (apply append
                     (map (lambda (y) (list (cadr y) (cadr (cddr y))))
                          (car (cddr x))))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define chibi-parse-ipv4-digit (chibi-parse-integer 0 255))

(define chibi-parse-ipv4-address
  (chibi-parse-map-substring
   (chibi-parse-seq chibi-parse-ipv4-digit
              (chibi-parse-repeat (chibi-parse-seq (chibi-parse-char #\.) chibi-parse-ipv4-digit)
                            3 3))))

(define chibi-parse-ipv6-digit
  (chibi-parse-repeat (chibi-parse-char char-hex-digit?) 0 4))

(define chibi-parse-ipv6-address
  (chibi-parse-map-substring
   (chibi-parse-seq
    chibi-parse-ipv6-digit
    (chibi-parse-repeat (chibi-parse-seq (chibi-parse-repeat (chibi-parse-char #\:) 1 2)
                             chibi-parse-ipv6-digit)
                  1 7))))

(define chibi-parse-ip-address
  (chibi-parse-or chibi-parse-ipv4-address chibi-parse-ipv6-address))

(define chibi-parse-domain-atom
  (chibi-parse-token
   (lambda (ch)
     (or (char-alphabetic? ch) (char-numeric? ch) (memv ch '(#\- #\_))))))

(define (chibi-parse-domain)
  (chibi-parse-map-substring
   (chibi-parse-or
    chibi-parse-ip-address
    (chibi-parse-seq (chibi-parse-repeat (chibi-parse-seq chibi-parse-domain-atom (chibi-parse-char #\.)))
               chibi-parse-domain-atom))))

(define chibi-parse-top-level-domain
  (apply chibi-parse-or
         (chibi-parse-repeat (chibi-parse-char char-alphabetic?) 2 2)
         (map chibi-parse-string
              '("arpa" "com" "gov" "mil" "net" "org" "aero" "biz" "coop"
                "info" "museum" "name" "pro"))))

(define (chibi-parse-common-domain)
  (chibi-parse-map-substring
   (chibi-parse-seq (chibi-parse-repeat+ (chibi-parse-seq chibi-parse-domain-atom (chibi-parse-char #\.)))
              chibi-parse-top-level-domain)))

(define chibi-parse-email-local-part
  (chibi-parse-token
   (lambda (ch)
     (or (char-alphabetic? ch)
         (char-numeric? ch)
         (memv ch '(#\- #\_ #\. #\+))))))

(define (chibi-parse-email)
  ;; no quoted local parts or bang paths
  (chibi-parse-seq chibi-parse-email-local-part
             (chibi-parse-ignore (chibi-parse-char #\@))
             (chibi-parse-domain)))

(define (char-url-fragment? ch)
  (or (char-alphabetic? ch) (char-numeric? ch)
      (memv ch '(#\_ #\- #\+ #\\ #\= #\~ #\&))))

(define (char-url? ch)
  (or (char-url-fragment? ch) (memv ch '(#\. #\, #\;))))

(define (chibi-parse-url-char pred)
  (chibi-parse-or (chibi-parse-char pred)
            (chibi-parse-seq (chibi-parse-char #\%)
                       (chibi-parse-repeat (chibi-parse-char char-hex-digit?) 2 2))))

(define (chibi-parse-uri)
  (chibi-parse-seq
   (chibi-parse-identifier)
   (chibi-parse-ignore
    (chibi-parse-seq (chibi-parse-char #\:) (chibi-parse-repeat (chibi-parse-char #\/))))
   (chibi-parse-domain)
   (chibi-parse-optional (chibi-parse-map (chibi-parse-seq (chibi-parse-char #\:)
                                         (chibi-parse-integer 0 65536))
                              cadr))
   (chibi-parse-optional
    (chibi-parse-map-substring
     (chibi-parse-seq (chibi-parse-char #\/)
                (chibi-parse-repeat (chibi-parse-url-char char-url?)))))
   (chibi-parse-optional
    (chibi-parse-map
     (chibi-parse-seq (chibi-parse-ignore (chibi-parse-char #\?))
                (chibi-parse-map-substring
                 (chibi-parse-repeat (chibi-parse-url-char char-url?))))
     car))
   (chibi-parse-optional
    (chibi-parse-map
     (chibi-parse-seq (chibi-parse-ignore (chibi-parse-char #\#))
                (chibi-parse-map-substring
                 (chibi-parse-repeat (chibi-parse-url-char char-url-fragment?))))
     car))))

