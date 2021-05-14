
%run guile

%var normal->milli/unit
%var normal->micro/unit
%var normal->nano/unit

%var milli->normal/unit
%var milli->micro/unit
%var milli->nano/unit

%var micro->normal/unit
%var micro->milli/unit
%var micro->nano/unit

%var nano->normal/unit
%var nano->milli/unit
%var nano->micro/unit

(define (normal->milli/unit s)
  (* 1000 s))

(define (normal->micro/unit s)
  (* 1000000 s))

(define (normal->nano/unit s)
  (* 1000000000 s))




(define (milli->normal/unit u)
  (/ u 1000))

(define (milli->micro/unit u)
  (* u 1000))

(define (milli->nano/unit u)
  (* 1000000 u))



(define (micro->normal/unit u)
  (/ u 1000000))

(define (micro->milli/unit u)
  (/ u 1000))

(define (micro->nano/unit u)
  (* 1000 u))



(define (nano->normal/unit ns)
  (/ ns 1000000000))

(define (nano->milli/unit ns)
  (/ ns 1000000))

(define (nano->micro/unit ns)
  (/ ns 1000))
