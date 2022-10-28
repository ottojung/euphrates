
%run guile

%var monadarg
%var monadarg?
%var monadarg-lval
%var set-monadarg-lval!
%var monadarg-cont
%var set-monadarg-cont!
%var monadarg-qvar
%var set-monadarg-qvar!
%var monadarg-qval
%var set-monadarg-qval!
%var monadarg-qtags
%var set-monadarg-qtags!
%var monadarg-make-empty

%use (define-type9) "./define-type9.scm"

(define-type9 <monadarg>
  (monadarg lval cont qvar qval qtags) monadarg?
  (lval monadarg-lval set-monadarg-lval!)
  (cont monadarg-cont set-monadarg-cont!)
  (qvar monadarg-qvar set-monadarg-qvar!)
  (qval monadarg-qval set-monadarg-qval!)
  (qtags monadarg-qtags set-monadarg-qtags!))

(define (monadarg-make-empty)
  (monadarg #f #f #f #f #f))

