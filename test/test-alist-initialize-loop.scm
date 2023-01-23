
%run guile

(let ()


  (alist-initialize-loop
   (X Y Z)

   :initial
   ((X 1)
    (Y 2))

   :invariant
   ((Z (+ (X) (Y))))

   :mutators
   
