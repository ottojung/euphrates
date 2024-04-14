;;;; Copyright (C) 2020, 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



;; Specified by RFC 1421, 2045, 2152, 4648 $4, 4880
(define base64/alphabet
  #(#\A #\B #\C #\D #\E #\F #\G #\H
    #\I #\J #\K #\L #\M #\N #\O #\P
    #\Q #\R #\S #\T #\U #\V #\W #\X
    #\Y #\Z #\a #\b #\c #\d #\e #\f
    #\g #\h #\i #\j #\k #\l #\m #\n
    #\o #\p #\q #\r #\s #\t #\u #\v
    #\w #\x #\y #\z #\0 #\1 #\2 #\3
    #\4 #\5 #\6 #\7 #\8 #\9 #\+ #\/))
