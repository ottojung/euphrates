
(assert=
 '((s1 (a (class m) c b* d+))
   (b* (b b*) ())
   (d+ (d d+) (d)))

 (let ()
   (define g
     (generic-ebnf-tree->alist
      '= '/ (lambda (yield name t) t)))

   (g '( s1 = a (class m) c (* b) (+ d)))))



(assert=

 '((s1 (a (class m) c (class b) d+))
   (d+ (d d+) (d)))

 (let ()
   (define g
     (generic-ebnf-tree->alist
      '= '/ (lambda (yield name t) t)))

   (g '( s1 = a (class m) c (class b) (+ d)))))



(assert=

 '((dig ((class alphanum)) ((class alphanum))))

 (let ()
   (define g
     (generic-ebnf-tree->alist
      '= '/ (lambda (yield name t) t)))

   (g
    '( dig = (class alphanum) / (class alphanum)))))








(assert=

 '((expr (term add expr) (term))
   (add ("+") (space add) (add space))
   (term (num) (space term) (term space))
   (num (dig+))
   (dig ((class alphanum)))
   (space ((class whitespace))))

 (let ()
   (define g
     (generic-ebnf-tree->alist
      '= '/ (lambda (yield name t) t)))

   (g
    '( expr = term add expr / term
       add = "+" / space add / add space
       term = num / space term / term space
       num = dig+
       dig = (class alphanum)
       space = (class whitespace)))))




(assert=

 '((expr (term add expr) (term))
   (add ("+") (space add) (add space))
   (term (num) (space term) (term space))
   (num (dig+))
   (dig ((class alphanum)) ((class alphanum)))
   (space ((class whitespace))))

 (let ()
   (define g
     (generic-ebnf-tree->alist
      '= '/ (lambda (yield name t) t)))

   (g
    '( expr = term add expr / term
       add = "+" / space add / add space
       term = num / space term / term space
       num = dig+
       dig = (class alphanum) / (class alphanum)
       space = (class whitespace)))))
