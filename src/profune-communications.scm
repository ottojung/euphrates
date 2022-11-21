;;;; Copyright (C) 2022  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

%run guile

%var profune-communications

;;
;; Communications between a client A and a server B.
;; Messages are based on profun queries.
;; Example dialogs:
;;   (B knows how to compute square roots, A wants to know sqrt(9))
;;   A: whats, sqrt(X, Y).
;;   B: whats, value(or(X, Y)).
;;   A: its, X = 9.
;;   B: its, Y = 3.
;;   A: bye.
;;
;;   (same as above, but A is straightforward)
;;   A: whats, X = 9, sqrt(X, Y).
;;   B: its, Y = 3.
;;   A: bye.
;;
;;   (A continues)
;;   A: whats, X = 9, sqrt(X, Y).
;;   B: its, Y = 3.
;;   A: whats, Y = 4, sqrt(X, Y).
;;   B: its, X = 16.
;;   A: bye.
;;
;;   (A makes a typo)
;;   A: whats, X = 9, swrt(X, Y).
;;   B: i-dont-recognize, swrt, 2.
;;   A: whats, X = 9, sqrt(X, Y).
;;   B: its, Y = 3.
;;   A: bye.
;;
;;   (A is calling B's tegfs API -- he wants to query entries with their previews)
;;   A: listen, query("image+funny"), diropen?(#t), whats, shared-preview(E, P).
;;   B: whats, value(E).
;;   A: its, entry(E).
;;   B: its, E = ..., P = ....
;;   A: more.
;;   B: its, E = ..., P = ....
;;   A: more.
;;   B: its, false().
;;   A: bye.
;;
;; Every communicator must know these words: "whats", "its", "listen", "more", "bye", and "i-dont-recognize".
;;

