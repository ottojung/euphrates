
;; Test adding two numbers
(assert= 5 (with-string-as-input "3 2" (+ (read) (read))))

;; Test reading a single number
(assert= 42 (with-string-as-input "42" (read)))

;; Test reading a symbol
(assert= 'hello (with-string-as-input "hello" (read)))

;; Test reading multiple data types
(assert= '(42 "world" hello)
         (with-string-as-input
          "42 \"world\" hello" (list (read) (read) (read))))

;; Test reading from an empty string (should result in an EOF object)
(assert (eof-object? (with-string-as-input "" (read))))

;; Test nested with-string-as-input
(assert= 10
         (with-string-as-input
          "5 5" (with-string-as-input
                 "1 1" (+ (read) (read)))
          (+ (read) (read))))

;; Test reading characters
(assert= #\A (with-string-as-input "A" (read-char)))

;; Test with a complex expression
(assert=
 25 (with-string-as-input
     "5" (* (read)
            (with-string-as-input
             "2 3" (+ (read) (read))))))

;; Test with newlines and whitespaces
(assert= '(1 2 3)
         (with-string-as-input
          " 1\n2\t3 " (list (read) (read) (read))))
