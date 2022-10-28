
%run guile

%var monadstate
%var monadstate?
%var monadstate-lval
%var set-monadstate-lval!
%var monadstate-cont
%var set-monadstate-cont!
%var monadstate-qvar
%var set-monadstate-qvar!
%var monadstate-qval
%var set-monadstate-qval!
%var monadstate-qtags
%var set-monadstate-qtags!
%var monadstate-make-empty

%use (define-type9) "./define-type9.scm"

(define-type9 <monadstate>
  (monadstate lval cont qvar qval qtags) monadstate?
  (lval monadstate-lval set-monadstate-lval!)
  (cont monadstate-cont set-monadstate-cont!)
  (qvar monadstate-qvar set-monadstate-qvar!)
  (qval monadstate-qval set-monadstate-qval!)
  (qtags monadstate-qtags set-monadstate-qtags!))

(define (monadstate-make-empty)
  (monadstate #f #f #f #f #f))

