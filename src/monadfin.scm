
%run guile

%var monadfin
%var monadfin?
%var monadfin-lval

%use (define-type9) "./define-type9.scm"

(define-type9 <monadfin>
  (monadfin lval) monadfin?
  (lval monadfin-lval))
