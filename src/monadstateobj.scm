
%run guile

%var monadstateobj
%var monadstateobj?
%var monadstateobj-lval
%var set-monadstateobj-lval!
%var monadstateobj-cont
%var set-monadstateobj-cont!
%var monadstateobj-qvar
%var set-monadstateobj-qvar!
%var monadstateobj-qval
%var set-monadstateobj-qval!
%var monadstateobj-qtags
%var set-monadstateobj-qtags!

%use (define-type9) "./define-type9.scm"

(define-type9 <monadstateobj>
  (monadstateobj lval cont qvar qval qtags) monadstateobj?
  (lval monadstateobj-lval set-monadstateobj-lval!)
  (cont monadstateobj-cont set-monadstateobj-cont!)
  (qvar monadstateobj-qvar set-monadstateobj-qvar!)
  (qval monadstateobj-qval set-monadstateobj-qval!)
  (qtags monadstateobj-qtags set-monadstateobj-qtags!))
