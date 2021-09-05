
%run guile

%var string-strip

%use (string-trim-chars) "./string-trim-chars.scm"

(define string-strip
  (case-lambda
   ((str) (string-trim-chars str "\n \t" 'both))
   ((str chars) (string-trim-chars str chars 'both))))
