
%run guile

%var normal->micro/unit
%var micro->nano/unit
%var normal->nano/unit
%var nano->micro/unit
%var micro->normal/unit
%var nano->normal/unit

(define (normal->micro/unit s)
  (* 1000000 s))

(define (micro->nano/unit ms)
  (* 1000 ms))

(define (normal->nano/unit s)
  (micro->nano/unit (normal->micro/unit s)))

(define (nano->micro/unit ns)
  (quotient ns 1000))

(define (micro->normal/unit u)
  (quotient u 1000000))

(define (nano->normal/unit n)
  (quotient n (* 1000 1000000)))
