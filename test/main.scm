
%run guile

%use (run-comprocess#p-default) "./../src/run-comprocess.scm"
%use (make-uni-spinlock) "./../src/uni-spinlock.scm"
%use (debug) "./../src/debug.scm"
%use (with-ignore-errors!) "./../src/with-ignore-errors.scm"

(display "All good\n")
(debug "All is ~s" 'debugy)

(with-ignore-errors!
 (throw 'hello!))

