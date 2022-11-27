;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
;;;;
;;;; This program is free software; you can redistribute it and/or modify
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

%var profun-iterator-copy
%var profun-iterator-insert!
%var profun-iterator-reset!

%var profun-iterator-constructor
%var profun-iterator-db
%var profun-iterator-env
%var profun-iterator-state
%var set-profun-iterator-state!
%var profun-iterator-query
%var set-profun-iterator-query!

%use (define-type9) "./define-type9.scm"
%use (profun-database-copy) "./profun-database.scm"

(define-type9 <profun-iterator>
  (profun-iterator-constructor db env state query) profun-iterator?
  (db profun-iterator-db)
  (env profun-iterator-env)
  (state profun-iterator-state set-profun-iterator-state!)
  (query profun-iterator-query set-profun-iterator-query!)
  )

(define (profun-iterator-copy iter)
  (define db (profun-iterator-db iter))
  (define env (profun-iterator-env iter))
  (define new-db (profun-database-copy db))
  (define new-env (env-copy env))
  (define state (profun-iterator-state iter))
  (define query (profun-iterator-query iter))
  (profun-iterator-constructor new-db new-env state query))

(define (profun-iterator-insert! iter instruction-prefix)
  (define db (profun-iterator-db iter))
  (define state (profun-iterator-state iter))
  (define new-state
    (add-prefix-to-instruction db state instruction-prefix))
  (set-profun-iterator-state! iter new-state))

(define (profun-iterator-reset! iter new-query)
  (define new-state (build-state new-query))
  (set-profun-iterator-state! iter new-state)
  (set-profun-iterator-query! iter new-query))
