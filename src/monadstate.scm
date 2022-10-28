
%run guile

%var monadstate
%var monadstate?
%var monadstate-lval
%var monadstate-cont
%var monadstate-qvar
%var monadstate-qval
%var monadstate-qtags

%use (define-type9) "./define-type9.scm"

(define-type9 <monadstate>
  (monadstate lval cont qvar qval qtags) monadstate?
  (lval monadstate-lval)
  (cont monadstate-cont)
  (qvar monadstate-qvar)
  (qval monadstate-qval)
  (qtags monadstate-qtags))
