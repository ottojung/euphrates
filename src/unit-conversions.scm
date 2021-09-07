
%run guile

%set (unit "pebi"   "(* 1024 1024 1024 1024)")
%set (unit "peta"   "1000000000000")
%set (unit "gibi"   "(* 1024 1024 1024)")
%set (unit "giga"   "1000000000")
%set (unit "mebi"   "(* 1024 1024)")
%set (unit "mega"   "1000000")
%set (unit "kibi"   "1024")
%set (unit "normal" "1")
%set (unit "kilo"   "1000")
%set (unit "milli"  "1/1000")
%set (unit "micro"  "1/1000000")
%set (unit "nano"   "1/1000000000")
%set (unit "pico"   "1/1000000000000")

%for (unit @a @ua) (unit @b @ub)
%var @a->@b/unit
%end

(define-values (
%for (unit @a @ua) (unit @b @ub)
     @a->@b/unit
%end
     )

  (let ()

%for (unit @a @ua) (unit @b @ub)

  (define @a->@b
    (lambda (x)
      (/ (* x @ua) @ub)))

%end

  (values

%for (unit @a @ua) (unit @b @ub)

     @a->@b

%end
     )))
