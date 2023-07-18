
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates md5) md5-digest))
   (import (only (scheme base) begin cond-expand))))


(assert=
 (md5-digest "hello")
 "5d41402abc4b2a76b9719d911017c592")

(assert=
 (md5-digest "The quick brown fox jumps over the lazy dog")
 "9e107d9d372bb6826bd81d3542a419d6")

(assert=
 (md5-digest "a b c\nd e\tf")
 "572853b8bb902e996262c34b39a850d0")

(assert=
 (md5-digest "")
 "d41d8cd98f00b204e9800998ecf8427e")
