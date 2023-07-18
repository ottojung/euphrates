
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates prefixtree)
           make-prefixtree
           prefixtree->tree
           prefixtree-ref
           prefixtree-ref-closest
           prefixtree-ref-furthest
           prefixtree-set!))
   (import
     (only (scheme base)
           begin
           cond-expand
           define
           let
           quote))))


;; prefixtree

(let ()
  (define root (make-prefixtree 'r))
  (assert= '(r)
           (prefixtree->tree root))

  (prefixtree-set! root '(1 2 3 4) 'a)
  (assert= '(r ((1 . ?) ((2 . ?) ((3 . ?) ((4 . a))))))
           (prefixtree->tree root))

  (prefixtree-set! root '(1 2 3 5) 'b)
  (prefixtree-set! root '(1 2 3 6) 'c)
  (assert= '(r ((1 . ?) ((2 . ?) ((3 . ?) ((6 . c)) ((5 . b)) ((4 . a))))))
           (prefixtree->tree root))

  (prefixtree-set! root '(1 2 7 6) 'd)
  (prefixtree-set! root '(1 2 7 8) 'e)
  (assert= '(r ((1 . ?) ((2 . ?) ((7 . ?) ((8 . e)) ((6 . d))) ((3 . ?) ((6 . c)) ((5 . b)) ((4 . a))))))
           (prefixtree->tree root))

  (prefixtree-set! root '(1 2) 'f)
  (assert= '(r ((1 . ?) ((2 . f) ((7 . ?) ((8 . e)) ((6 . d))) ((3 . ?) ((6 . c)) ((5 . b)) ((4 . a))))))
           (prefixtree->tree root))

  (prefixtree-set! root '(1 2 3 6 9) 'g)
  (assert= '(r ((1 . ?) ((2 . f) ((7 . ?) ((8 . e)) ((6 . d))) ((3 . ?) ((6 . c) ((9 . g))) ((5 . b)) ((4 . a))))))
           (prefixtree->tree root))

  (prefixtree-set! root '(1 2 3 6 9) 'h)
  (assert= '(r ((1 . ?) ((2 . f) ((7 . ?) ((8 . e)) ((6 . d))) ((3 . ?) ((6 . c) ((9 . h))) ((5 . b)) ((4 . a))))))
           (prefixtree->tree root))

  (assert= 'f (prefixtree-ref root '(1 2) #f))
  (assert= 'c (prefixtree-ref root '(1 2 3 6) #f))
  (assert= #f (prefixtree-ref root '(1 2 3 6 7) #f))
  (assert= #f (prefixtree-ref root '(1 2 3 8) #f))
  (assert= #f (prefixtree-ref root '(1 2 3) #f))
  (assert= #f (prefixtree-ref root '(1 8) #f))
  (assert= #f (prefixtree-ref root '(1 6) #f))
  (assert= #f (prefixtree-ref root '(1 3 6) #f))
  (assert= 'r (prefixtree-ref root '() #f))

  (assert= '(f) (prefixtree-ref-closest root '(1 2)))
  (assert= '(c) (prefixtree-ref-closest root '(1 2 3 6)))
  (assert= '() (prefixtree-ref-closest root '(1 2 3 6 7)))
  (assert= '() (prefixtree-ref-closest root '(1 2 3 8)))
  (assert= '() (prefixtree-ref-closest root '(1 2 3)))
  (assert= '(e) (prefixtree-ref-closest root '(1 8)))
  (assert= '(d c) (prefixtree-ref-closest root '(1 6)))
  (assert= '(c) (prefixtree-ref-closest root '(1 3 6)))
  (assert= '(r) (prefixtree-ref-closest root '()))

  (assert= 'f (prefixtree-ref-furthest root '(1 2)))
  (assert= 'c (prefixtree-ref-furthest root '(1 2 3 6)))
  (assert= 'c (prefixtree-ref-furthest root '(1 2 3 6 7)))
  (assert= 'f (prefixtree-ref-furthest root '(1 2 3 8)))
  (assert= 'f (prefixtree-ref-furthest root '(1 2 3)))
  (assert= 'r (prefixtree-ref-furthest root '(1 8)))
  (assert= 'r (prefixtree-ref-furthest root '(1 6)))
  (assert= 'r (prefixtree-ref-furthest root '(1 3 6)))
  (assert= 'r (prefixtree-ref-furthest root '()))
  )
