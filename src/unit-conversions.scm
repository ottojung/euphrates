;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
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

%set (unit "pebi"   "(* 1024 1024 1024 1024)")
%set (unit "peta"   "1000000000000")
%set (unit "gibi"   "(* 1024 1024 1024)")
%set (unit "giga"   "1000000000")
%set (unit "mebi"   "(* 1024 1024)")
%set (unit "mega"   "1000000")
%set (unit "kibi"   "1024")
%set (unit "kilo"   "1000")
%set (unit "hecto"  "100")
%set (unit "deka"   "10")
%set (unit "normal" "1")
%set (unit "deci"   "1/10")
%set (unit "centi"  "1/100")
%set (unit "milli"  "1/1000")
%set (unit "micro"  "1/1000000")
%set (unit "nano"   "1/1000000000")
%set (unit "pico"   "1/1000000000000")

%set (unit "minute" "60")
%set (unit "hour"   "(* 60 60)")
%set (unit "day"    "(* 60 60 24)")
%set (unit "week"   "(* 60 60 24 7)")

%for (unit @a @ua) (unit @b @ub)
(export @a->@b/unit)
%end

;; %var pebi->pebi/unit
;; %var pebi->peta/unit
;; %var pebi->gibi/unit
;; %var pebi->giga/unit
;; %var pebi->mebi/unit
;; %var pebi->mega/unit
;; %var pebi->kibi/unit
;; %var pebi->normal/unit
;; %var pebi->kilo/unit
;; %var pebi->milli/unit
;; %var pebi->micro/unit
;; %var pebi->nano/unit
;; %var pebi->pico/unit
;; %var peta->pebi/unit
;; %var peta->peta/unit
;; %var peta->gibi/unit
;; %var peta->giga/unit
;; %var peta->mebi/unit
;; %var peta->mega/unit
;; %var peta->kibi/unit
;; %var peta->normal/unit
;; %var peta->kilo/unit
;; %var peta->milli/unit
;; %var peta->micro/unit
;; %var peta->nano/unit
;; %var peta->pico/unit
;; %var gibi->pebi/unit
;; %var gibi->peta/unit
;; %var gibi->gibi/unit
;; %var gibi->giga/unit
;; %var gibi->mebi/unit
;; %var gibi->mega/unit
;; %var gibi->kibi/unit
;; %var gibi->normal/unit
;; %var gibi->kilo/unit
;; %var gibi->milli/unit
;; %var gibi->micro/unit
;; %var gibi->nano/unit
;; %var gibi->pico/unit
;; %var giga->pebi/unit
;; %var giga->peta/unit
;; %var giga->gibi/unit
;; %var giga->giga/unit
;; %var giga->mebi/unit
;; %var giga->mega/unit
;; %var giga->kibi/unit
;; %var giga->normal/unit
;; %var giga->kilo/unit
;; %var giga->milli/unit
;; %var giga->micro/unit
;; %var giga->nano/unit
;; %var giga->pico/unit
;; %var mebi->pebi/unit
;; %var mebi->peta/unit
;; %var mebi->gibi/unit
;; %var mebi->giga/unit
;; %var mebi->mebi/unit
;; %var mebi->mega/unit
;; %var mebi->kibi/unit
;; %var mebi->normal/unit
;; %var mebi->kilo/unit
;; %var mebi->milli/unit
;; %var mebi->micro/unit
;; %var mebi->nano/unit
;; %var mebi->pico/unit
;; %var mega->pebi/unit
;; %var mega->peta/unit
;; %var mega->gibi/unit
;; %var mega->giga/unit
;; %var mega->mebi/unit
;; %var mega->mega/unit
;; %var mega->kibi/unit
;; %var mega->normal/unit
;; %var mega->kilo/unit
;; %var mega->milli/unit
;; %var mega->micro/unit
;; %var mega->nano/unit
;; %var mega->pico/unit
;; %var kibi->pebi/unit
;; %var kibi->peta/unit
;; %var kibi->gibi/unit
;; %var kibi->giga/unit
;; %var kibi->mebi/unit
;; %var kibi->mega/unit
;; %var kibi->kibi/unit
;; %var kibi->normal/unit
;; %var kibi->kilo/unit
;; %var kibi->milli/unit
;; %var kibi->micro/unit
;; %var kibi->nano/unit
;; %var kibi->pico/unit
;; %var normal->pebi/unit
;; %var normal->peta/unit
;; %var normal->gibi/unit
;; %var normal->giga/unit
;; %var normal->mebi/unit
;; %var normal->mega/unit
;; %var normal->kibi/unit
;; %var normal->normal/unit
;; %var normal->kilo/unit
;; %var normal->milli/unit
;; %var normal->micro/unit
;; %var normal->nano/unit
;; %var normal->pico/unit
;; %var kilo->pebi/unit
;; %var kilo->peta/unit
;; %var kilo->gibi/unit
;; %var kilo->giga/unit
;; %var kilo->mebi/unit
;; %var kilo->mega/unit
;; %var kilo->kibi/unit
;; %var kilo->normal/unit
;; %var kilo->kilo/unit
;; %var kilo->milli/unit
;; %var kilo->micro/unit
;; %var kilo->nano/unit
;; %var kilo->pico/unit
;; %var milli->pebi/unit
;; %var milli->peta/unit
;; %var milli->gibi/unit
;; %var milli->giga/unit
;; %var milli->mebi/unit
;; %var milli->mega/unit
;; %var milli->kibi/unit
;; %var milli->normal/unit
;; %var milli->kilo/unit
;; %var milli->milli/unit
;; %var milli->micro/unit
;; %var milli->nano/unit
;; %var milli->pico/unit
;; %var micro->pebi/unit
;; %var micro->peta/unit
;; %var micro->gibi/unit
;; %var micro->giga/unit
;; %var micro->mebi/unit
;; %var micro->mega/unit
;; %var micro->kibi/unit
;; %var micro->normal/unit
;; %var micro->kilo/unit
;; %var micro->milli/unit
;; %var micro->micro/unit
;; %var micro->nano/unit
;; %var micro->pico/unit
;; %var nano->pebi/unit
;; %var nano->peta/unit
;; %var nano->gibi/unit
;; %var nano->giga/unit
;; %var nano->mebi/unit
;; %var nano->mega/unit
;; %var nano->kibi/unit
;; %var nano->normal/unit
;; %var nano->kilo/unit
;; %var nano->milli/unit
;; %var nano->micro/unit
;; %var nano->nano/unit
;; %var nano->pico/unit
;; %var pico->pebi/unit
;; %var pico->peta/unit
;; %var pico->gibi/unit
;; %var pico->giga/unit
;; %var pico->mebi/unit
;; %var pico->mega/unit
;; %var pico->kibi/unit
;; %var pico->normal/unit
;; %var pico->kilo/unit
;; %var pico->milli/unit
;; %var pico->micro/unit
;; %var pico->nano/unit
;; %var pico->pico/unit

(define-values (
%for (unit @a @ua) (unit @b @ub)
     @a->@b/unit
%end
     )

  (let ()

%for (unit @a @ua) (unit @b @ub)

  (define @a->@b
    (lambda (x)
      (/ (* x @ua) @ub)))

%end

  (values

%for (unit @a @ua) (unit @b @ub)

     @a->@b

%end
     )))
