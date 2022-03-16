;;;; Copyright (C) 2013-2020 Aleix Conchillo Flaque <aconchillo@gmail.com>, 2022  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;;;
;;;; Original sources were published here: https://github.com/aconchillo/guile-json/blob/master/json/parser.scm
;;;;

%run guile

%var json-parse

%use (raisu) "./raisu.scm"

;;
;; Miscellaneuos helpers
;;

(define (json-exception port)
  (raisu 'json-invalid port))

(define (digit? c)
  (case c
    ((#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9) #t)
    (else #f)))

(define (whitespace? c)
  (case c
    ((#\sp #\ht #\lf #\cr) #t)
    (else #f)))

(define (control-char? ch)
  (<= (char->integer ch) #x1F))

(define (skip-whitespaces port)
  (let ((ch (peek-char port)))
    (cond
     ((whitespace? ch)
      (read-char port)
      (skip-whitespaces port))
     (else *unspecified*))))

(define (expect-string port expected return)
  (let loop ((n 0))
    (cond
     ;; All characters match.
     ((= n (string-length expected)) return)
     ;; Go to next characters.
     ((eqv? (read-char port) (string-ref expected n))
      (loop (+ n 1)))
     ;; Anything else is an error.
     (else (json-exception port)))))

(define (expect-delimiter port delimiter)
  (let ((ch (read-char port)))
    (cond
     ((not (eqv? ch delimiter)) (json-exception port))
     ;; Unexpected EOF.
     ((eof-object? ch) (json-exception port)))))

(define (skip-record-separators port)
  (when (eqv? #\rs (peek-char port))
    (read-char port)
    (skip-record-separators port)))

;;
;; Number parsing helpers
;;

(define (expect-digit port)
  (let ((ch (peek-char port)))
    (cond
     ((not (digit? ch)) (json-exception port))
     ;; Unexpected EOF.
     ((eof-object? ch) (json-exception port)))))

;; Read + or -, and return 1 or -1 respectively. If something different is
;; found, return 1.
(define (read-sign port)
  (let ((ch (peek-char port)))
    (cond
     ((eqv? ch #\+)
      (read-char port)
      1)
     ((eqv? ch #\-)
      (read-char port)
      -1)
     (else 1))))

(define (read-digit-value port)
  (let ((ch (read-char port)))
    (cond
     ((eqv? ch #\0) 0)
     ((eqv? ch #\1) 1)
     ((eqv? ch #\2) 2)
     ((eqv? ch #\3) 3)
     ((eqv? ch #\4) 4)
     ((eqv? ch #\5) 5)
     ((eqv? ch #\6) 6)
     ((eqv? ch #\7) 7)
     ((eqv? ch #\8) 8)
     ((eqv? ch #\9) 9)
     (else (json-exception port)))))

;; Read digits [0..9].
(define (read-digits port)
  (expect-digit port)
  (let loop ((ch (peek-char port)) (number 0))
    (cond
     ((digit? ch)
      (let ((value (read-digit-value port)))
        (loop (peek-char port) (+ (* number 10) value))))
     (else number))))

(define (read-digits-fraction port)
  (expect-digit port)
  (let loop ((ch (peek-char port)) (number 0) (length 0))
    (cond
     ((digit? ch)
      (let ((value (read-digit-value port)))
        (loop (peek-char port) (+ (* number 10) value) (+ length 1))))
     (else
      (/ number (expt 10 length))))))

(define (read-exponent port)
  (let ((ch (peek-char port)))
    (cond
     ((or (eqv? ch #\e) (eqv? ch #\E))
      (read-char port)
      (let ((sign (read-sign port))
            (digits (read-digits port)))
        (if (<= digits 1000) ;; Some maximum exponent.
            (expt 10 (* sign digits))
            (json-exception port))))
     (else 1))))

(define (read-fraction port)
  (let ((ch (peek-char port)))
    (cond
     ((eqv? ch #\.)
      (read-char port)
      (read-digits-fraction port))
     (else 0))))

(define (read-positive-number port)
  (let* ((number
          (let ((ch (peek-char port)))
            (cond
             ;; Numbers that start with 0 must be a fraction.
             ((eqv? ch #\0)
              (read-char port)
              0)
             ;; Otherwise read more digits.
             (else (read-digits port)))))
         (fraction (read-fraction port))
         (exponent (read-exponent port))
         (result (* (+ number fraction) exponent)))
    (if (and (zero? fraction) (>= exponent 1))
        result
        (exact->inexact result))))

(define (json-read-number port)
  (let ((ch (peek-char port)))
    (cond
     ;; Negative numbers.
     ((eqv? ch #\-)
      (read-char port)
      (expect-digit port)
      (* -1 (read-positive-number port)))
     ;; Positive numbers.
     ((digit? ch)
      (read-positive-number port))
     ;; Anything else is an error.
     (else (json-exception port)))))

;;
;; Object parsing helpers
;;

(define (read-pair port)
  ;; Read key.
  (let ((key (json-read-string port)))
    (skip-whitespaces port)
    (let ((ch (peek-char port)))
      (cond
       ;; Skip colon and read value.
       ((eqv? ch #\:)
        (read-char port)
        (cons key (json-parse port)))
       ;; Anything other than colon is an error.
       (else (json-exception port))))))

(define (json-read-object port)
  (expect-delimiter port #\{)
  (let loop ((pairs '()) (added #t))
    (skip-whitespaces port)
    (let ((ch (peek-char port)))
      (cond
       ;; End of object.
       ((eqv? ch #\})
        (read-char port)
        (cond
         (added pairs)
         (else (json-exception port))))
       ;; Read one pair and continue.
       ((eqv? ch #\")
        (let ((pair (read-pair port)))
          (loop (cons pair pairs) #t)))
       ;; Skip comma and read more pairs.
       ((eqv? ch #\,)
        (read-char port)
        (cond
         (added (loop pairs #f))
         (else (json-exception port))))
       ;; Invalid object.
       (else (json-exception port))))))

;;
;; Array parsing helpers
;;

(define (json-read-array port)
  (expect-delimiter port #\[)
  (skip-whitespaces port)
  (cond
   ;; Special case when array is empty.
   ((eqv? (peek-char port) #\])
    (read-char port)
    #())
   (else
    ;; Read first element in array.
    (let loop ((values (list (json-parse port))))
      (skip-whitespaces port)
      (let ((ch (peek-char port)))
        (cond
         ;; Unexpected EOF.
         ((eof-object? ch) (json-exception port))
         ;; Handle comma (if there's a comma there should be another element).
         ((eqv? ch #\,)
          (read-char port)
          (loop (cons (json-parse port) values)))
         ;; End of array.
         ((eqv? ch #\])
          (read-char port)
          (list->vector (reverse! values)))
         ;; Anything else other than comma and end of array is wrong.
         (else (json-exception port))))))))

;;
;; String parsing helpers
;;

(define (read-hex-digit->integer port)
  (let ((ch (read-char port)))
    (cond
     ((eqv? ch #\0) 0)
     ((eqv? ch #\1) 1)
     ((eqv? ch #\2) 2)
     ((eqv? ch #\3) 3)
     ((eqv? ch #\4) 4)
     ((eqv? ch #\5) 5)
     ((eqv? ch #\6) 6)
     ((eqv? ch #\7) 7)
     ((eqv? ch #\8) 8)
     ((eqv? ch #\9) 9)
     ((or (eqv? ch #\A) (eqv? ch #\a)) 10)
     ((or (eqv? ch #\B) (eqv? ch #\b)) 11)
     ((or (eqv? ch #\C) (eqv? ch #\c)) 12)
     ((or (eqv? ch #\D) (eqv? ch #\d)) 13)
     ((or (eqv? ch #\E) (eqv? ch #\e)) 14)
     ((or (eqv? ch #\F) (eqv? ch #\f)) 15)
     (else (json-exception port)))))

(define (read-unicode-value port)
  (+ (* 4096 (read-hex-digit->integer port))
      (* 256 (read-hex-digit->integer port))
      (* 16 (read-hex-digit->integer port))
      (read-hex-digit->integer port)))

;; Unicode codepoint with surrogates is:
;;   10000 + (high - D800) + (low - DC00)
;; which is equivalent to:
;;  (high << 10) + low - 35FDC00
;; see
;;   https://github.com/aconchillo/guile-json/issues/58#issuecomment-662744070
(define (json-surrogate-pair->unicode high low)
  (+ (* high #x400) low #x-35FDC00))

(define (read-unicode-char port)
  (let ((codepoint (read-unicode-value port)))
    (cond
     ;; Surrogate pairs. `codepoint` already contains the higher surrogate
     ;; (between D800 and DC00) . At this point we are expecting another
     ;; \uXXXX that holds the lower surrogate (between DC00 and DFFF).
     ((and (>= codepoint #xD800) (< codepoint #xDC00))
      (expect-string port "\\u" #f)
      (let ((low-surrogate (read-unicode-value port)))
        (if (and (>= low-surrogate #xDC00) (< low-surrogate #xE000))
            (integer->char (json-surrogate-pair->unicode codepoint low-surrogate))
            (json-exception port))))
     ;; Reserved for surrogates (we just need to check starting from the low
     ;; surrogates).
     ((and (>= codepoint #xDC00) (< codepoint #xE000))
      (json-exception port))
     (else (integer->char codepoint)))))

(define (read-control-char port)
  (let ((ch (read-char port)))
    (cond
     ((eqv? ch #\") #\")
     ((eqv? ch #\\) #\\)
     ((eqv? ch #\/) #\/)
     ((eqv? ch #\b) #\bs)
     ((eqv? ch #\f) #\ff)
     ((eqv? ch #\n) #\lf)
     ((eqv? ch #\r) #\cr)
     ((eqv? ch #\t) #\ht)
     ((eqv? ch #\u) (read-unicode-char port))
     (else (json-exception port)))))

(define (json-read-string port)
  (expect-delimiter port #\")
  (let loop ((chars '()) (ch (read-char port)))
    (cond
     ;; Unexpected EOF.
     ((eof-object? ch) (json-exception port))
     ;; Unescaped control characters are not allowed.
     ((control-char? ch) (json-exception port))
     ;; End of string.
     ((eqv? ch #\") (reverse-list->string chars))
     ;; Escaped characters.
     ((eqv? ch #\\)
      (loop (cons (read-control-char port) chars) (read-char port)))
     ;; All other characters.
     (else
      (loop (cons ch chars) (read-char port))))))

;;
;; Booleans and null parsing helpers
;;

(define (json-read-true port)
  (expect-string port "true" #t))

(define (json-read-false port)
  (expect-string port "false" #f))

(define (json-read-null port)
  (expect-string port "null" 'null))

;;
;; Main parser functions
;;

(define (json-parse port)
  (skip-whitespaces port)
  (let ((ch (peek-char port)))
    (cond
     ;; Unexpected EOF.
     ((eof-object? ch) (json-exception port))
     ;; Read JSON values.
     ((eqv? ch #\t) (json-read-true port))
     ((eqv? ch #\f) (json-read-false port))
     ((eqv? ch #\n) (json-read-null port))
     ((eqv? ch #\{) (json-read-object port))
     ((eqv? ch #\[) (json-read-array port))
     ((eqv? ch #\") (json-read-string port))
     ;; Anything else should be a number.
     (else (json-read-number port)))))
