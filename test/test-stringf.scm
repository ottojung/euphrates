

(let ()
  (assert= "start 1 2 3 end"
           (stringf "start ~s 2 ~a end"
                    1 3)))
