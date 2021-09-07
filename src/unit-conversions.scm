
%run guile

%set (unit "pebi")
%set (unit "peta")
%set (unit "gibi")
%set (unit "giga")
%set (unit "mebi")
%set (unit "mega")
%set (unit "kibi")
%set (unit "kilo")
%set (unit "milli")
%set (unit "micro")
%set (unit "nano")
%set (unit "pico")

%for (unit @y)
%var normal->@y/unit
%var @y->normal/unit
%end
%for (unit @a) (unit @b)
%var @a->@b/unit
%end

(define-values (
%for (unit @y)
     normal->@y/unit
     @y->normal/unit
%end
%for (unit @a) (unit @b)
     @a->@b/unit
%end
     )

  (let ()

  (define (normal->pebi x)
    (/ x (* 1024 1024 1024 1024)))

  (define (normal->peta x)
    (/ x 1000000000000))

  (define (normal->gibi x)
    (/ x (* 1024 1024 1024)))

  (define (normal->giga x)
    (/ x 1000000000))

  (define (normal->mebi x)
    (/ x (* 1024 1024)))

  (define (normal->mega x)
    (/ x 1000000))

  (define (normal->kibi x)
    (/ x 1024))

  (define (normal->kilo x)
    (/ x 1000))

  (define (normal->milli x)
    (* x 1000))

  (define (normal->micro x)
    (* x 1000000))

  (define (normal->nano x)
    (* x 1000000000))

  (define (normal->pico x)
    (* x 1000000000000))



  (define (pebi->normal x)
    (* x (* 1024 1024 1024 1024)))

  (define (peta->normal x)
    (* x 1000000000000))

  (define (gibi->normal x)
    (* x (* 1024 1024 1024)))

  (define (giga->normal x)
    (* x 1000000000))

  (define (mebi->normal x)
    (* x (* 1024 1024)))

  (define (mega->normal x)
    (* x 1000000))

  (define (kibi->normal x)
    (* x 1024))

  (define (kilo->normal x)
    (* x 1000))

  (define (milli->normal x)
    (/ x 1000))

  (define (micro->normal x)
    (/ x 1000000))

  (define (nano->normal x)
    (/ x 1000000000))

  (define (pico->normal x)
    (/ x 1000000000000))

%for (unit @a) (unit @b)

  (define @a->@b
    (lambda (x)
      (normal->@b (@a->normal x))))

%end

  (values

%for (unit @y)

     normal->@y
     @y->normal

%end

%for (unit @a) (unit @b)

     @a->@b

%end
     )))
