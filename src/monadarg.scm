
%run guile

%var monadarg
%var monadarg?
%var monadarg-lval
%var monadarg-cont
%var monadarg-qvar
%var monadarg-qval
%var monadarg-qtags
%var monadarg-lazy?

%use (define-type9) "./define-type9.scm"

(define-type9 <monadarg>
  (monadarg lval cont qvar qval qtags lazy?) monadarg?
  (lval monadarg-lval)
  (cont monadarg-cont)
  (qvar monadarg-qvar)
  (qval monadarg-qval)
  (qtags monadarg-qtags)
  (lazy? monadarg-lazy?))
