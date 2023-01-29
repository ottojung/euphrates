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

;; %for (unit @a @ua) (unit @b @ub)
;; (export @a->@b/unit)
;; %end

%var pebi->pebi/unit
%var pebi->peta/unit
%var pebi->gibi/unit
%var pebi->giga/unit
%var pebi->mebi/unit
%var pebi->mega/unit
%var pebi->kibi/unit
%var pebi->kilo/unit
%var pebi->hecto/unit
%var pebi->deka/unit
%var pebi->normal/unit
%var pebi->deci/unit
%var pebi->centi/unit
%var pebi->milli/unit
%var pebi->micro/unit
%var pebi->nano/unit
%var pebi->pico/unit
%var pebi->minute/unit
%var pebi->hour/unit
%var pebi->day/unit
%var pebi->week/unit
%var peta->pebi/unit
%var peta->peta/unit
%var peta->gibi/unit
%var peta->giga/unit
%var peta->mebi/unit
%var peta->mega/unit
%var peta->kibi/unit
%var peta->kilo/unit
%var peta->hecto/unit
%var peta->deka/unit
%var peta->normal/unit
%var peta->deci/unit
%var peta->centi/unit
%var peta->milli/unit
%var peta->micro/unit
%var peta->nano/unit
%var peta->pico/unit
%var peta->minute/unit
%var peta->hour/unit
%var peta->day/unit
%var peta->week/unit
%var gibi->pebi/unit
%var gibi->peta/unit
%var gibi->gibi/unit
%var gibi->giga/unit
%var gibi->mebi/unit
%var gibi->mega/unit
%var gibi->kibi/unit
%var gibi->kilo/unit
%var gibi->hecto/unit
%var gibi->deka/unit
%var gibi->normal/unit
%var gibi->deci/unit
%var gibi->centi/unit
%var gibi->milli/unit
%var gibi->micro/unit
%var gibi->nano/unit
%var gibi->pico/unit
%var gibi->minute/unit
%var gibi->hour/unit
%var gibi->day/unit
%var gibi->week/unit
%var giga->pebi/unit
%var giga->peta/unit
%var giga->gibi/unit
%var giga->giga/unit
%var giga->mebi/unit
%var giga->mega/unit
%var giga->kibi/unit
%var giga->kilo/unit
%var giga->hecto/unit
%var giga->deka/unit
%var giga->normal/unit
%var giga->deci/unit
%var giga->centi/unit
%var giga->milli/unit
%var giga->micro/unit
%var giga->nano/unit
%var giga->pico/unit
%var giga->minute/unit
%var giga->hour/unit
%var giga->day/unit
%var giga->week/unit
%var mebi->pebi/unit
%var mebi->peta/unit
%var mebi->gibi/unit
%var mebi->giga/unit
%var mebi->mebi/unit
%var mebi->mega/unit
%var mebi->kibi/unit
%var mebi->kilo/unit
%var mebi->hecto/unit
%var mebi->deka/unit
%var mebi->normal/unit
%var mebi->deci/unit
%var mebi->centi/unit
%var mebi->milli/unit
%var mebi->micro/unit
%var mebi->nano/unit
%var mebi->pico/unit
%var mebi->minute/unit
%var mebi->hour/unit
%var mebi->day/unit
%var mebi->week/unit
%var mega->pebi/unit
%var mega->peta/unit
%var mega->gibi/unit
%var mega->giga/unit
%var mega->mebi/unit
%var mega->mega/unit
%var mega->kibi/unit
%var mega->kilo/unit
%var mega->hecto/unit
%var mega->deka/unit
%var mega->normal/unit
%var mega->deci/unit
%var mega->centi/unit
%var mega->milli/unit
%var mega->micro/unit
%var mega->nano/unit
%var mega->pico/unit
%var mega->minute/unit
%var mega->hour/unit
%var mega->day/unit
%var mega->week/unit
%var kibi->pebi/unit
%var kibi->peta/unit
%var kibi->gibi/unit
%var kibi->giga/unit
%var kibi->mebi/unit
%var kibi->mega/unit
%var kibi->kibi/unit
%var kibi->kilo/unit
%var kibi->hecto/unit
%var kibi->deka/unit
%var kibi->normal/unit
%var kibi->deci/unit
%var kibi->centi/unit
%var kibi->milli/unit
%var kibi->micro/unit
%var kibi->nano/unit
%var kibi->pico/unit
%var kibi->minute/unit
%var kibi->hour/unit
%var kibi->day/unit
%var kibi->week/unit
%var kilo->pebi/unit
%var kilo->peta/unit
%var kilo->gibi/unit
%var kilo->giga/unit
%var kilo->mebi/unit
%var kilo->mega/unit
%var kilo->kibi/unit
%var kilo->kilo/unit
%var kilo->hecto/unit
%var kilo->deka/unit
%var kilo->normal/unit
%var kilo->deci/unit
%var kilo->centi/unit
%var kilo->milli/unit
%var kilo->micro/unit
%var kilo->nano/unit
%var kilo->pico/unit
%var kilo->minute/unit
%var kilo->hour/unit
%var kilo->day/unit
%var kilo->week/unit
%var hecto->pebi/unit
%var hecto->peta/unit
%var hecto->gibi/unit
%var hecto->giga/unit
%var hecto->mebi/unit
%var hecto->mega/unit
%var hecto->kibi/unit
%var hecto->kilo/unit
%var hecto->hecto/unit
%var hecto->deka/unit
%var hecto->normal/unit
%var hecto->deci/unit
%var hecto->centi/unit
%var hecto->milli/unit
%var hecto->micro/unit
%var hecto->nano/unit
%var hecto->pico/unit
%var hecto->minute/unit
%var hecto->hour/unit
%var hecto->day/unit
%var hecto->week/unit
%var deka->pebi/unit
%var deka->peta/unit
%var deka->gibi/unit
%var deka->giga/unit
%var deka->mebi/unit
%var deka->mega/unit
%var deka->kibi/unit
%var deka->kilo/unit
%var deka->hecto/unit
%var deka->deka/unit
%var deka->normal/unit
%var deka->deci/unit
%var deka->centi/unit
%var deka->milli/unit
%var deka->micro/unit
%var deka->nano/unit
%var deka->pico/unit
%var deka->minute/unit
%var deka->hour/unit
%var deka->day/unit
%var deka->week/unit
%var normal->pebi/unit
%var normal->peta/unit
%var normal->gibi/unit
%var normal->giga/unit
%var normal->mebi/unit
%var normal->mega/unit
%var normal->kibi/unit
%var normal->kilo/unit
%var normal->hecto/unit
%var normal->deka/unit
%var normal->normal/unit
%var normal->deci/unit
%var normal->centi/unit
%var normal->milli/unit
%var normal->micro/unit
%var normal->nano/unit
%var normal->pico/unit
%var normal->minute/unit
%var normal->hour/unit
%var normal->day/unit
%var normal->week/unit
%var deci->pebi/unit
%var deci->peta/unit
%var deci->gibi/unit
%var deci->giga/unit
%var deci->mebi/unit
%var deci->mega/unit
%var deci->kibi/unit
%var deci->kilo/unit
%var deci->hecto/unit
%var deci->deka/unit
%var deci->normal/unit
%var deci->deci/unit
%var deci->centi/unit
%var deci->milli/unit
%var deci->micro/unit
%var deci->nano/unit
%var deci->pico/unit
%var deci->minute/unit
%var deci->hour/unit
%var deci->day/unit
%var deci->week/unit
%var centi->pebi/unit
%var centi->peta/unit
%var centi->gibi/unit
%var centi->giga/unit
%var centi->mebi/unit
%var centi->mega/unit
%var centi->kibi/unit
%var centi->kilo/unit
%var centi->hecto/unit
%var centi->deka/unit
%var centi->normal/unit
%var centi->deci/unit
%var centi->centi/unit
%var centi->milli/unit
%var centi->micro/unit
%var centi->nano/unit
%var centi->pico/unit
%var centi->minute/unit
%var centi->hour/unit
%var centi->day/unit
%var centi->week/unit
%var milli->pebi/unit
%var milli->peta/unit
%var milli->gibi/unit
%var milli->giga/unit
%var milli->mebi/unit
%var milli->mega/unit
%var milli->kibi/unit
%var milli->kilo/unit
%var milli->hecto/unit
%var milli->deka/unit
%var milli->normal/unit
%var milli->deci/unit
%var milli->centi/unit
%var milli->milli/unit
%var milli->micro/unit
%var milli->nano/unit
%var milli->pico/unit
%var milli->minute/unit
%var milli->hour/unit
%var milli->day/unit
%var milli->week/unit
%var micro->pebi/unit
%var micro->peta/unit
%var micro->gibi/unit
%var micro->giga/unit
%var micro->mebi/unit
%var micro->mega/unit
%var micro->kibi/unit
%var micro->kilo/unit
%var micro->hecto/unit
%var micro->deka/unit
%var micro->normal/unit
%var micro->deci/unit
%var micro->centi/unit
%var micro->milli/unit
%var micro->micro/unit
%var micro->nano/unit
%var micro->pico/unit
%var micro->minute/unit
%var micro->hour/unit
%var micro->day/unit
%var micro->week/unit
%var nano->pebi/unit
%var nano->peta/unit
%var nano->gibi/unit
%var nano->giga/unit
%var nano->mebi/unit
%var nano->mega/unit
%var nano->kibi/unit
%var nano->kilo/unit
%var nano->hecto/unit
%var nano->deka/unit
%var nano->normal/unit
%var nano->deci/unit
%var nano->centi/unit
%var nano->milli/unit
%var nano->micro/unit
%var nano->nano/unit
%var nano->pico/unit
%var nano->minute/unit
%var nano->hour/unit
%var nano->day/unit
%var nano->week/unit
%var pico->pebi/unit
%var pico->peta/unit
%var pico->gibi/unit
%var pico->giga/unit
%var pico->mebi/unit
%var pico->mega/unit
%var pico->kibi/unit
%var pico->kilo/unit
%var pico->hecto/unit
%var pico->deka/unit
%var pico->normal/unit
%var pico->deci/unit
%var pico->centi/unit
%var pico->milli/unit
%var pico->micro/unit
%var pico->nano/unit
%var pico->pico/unit
%var pico->minute/unit
%var pico->hour/unit
%var pico->day/unit
%var pico->week/unit
%var minute->pebi/unit
%var minute->peta/unit
%var minute->gibi/unit
%var minute->giga/unit
%var minute->mebi/unit
%var minute->mega/unit
%var minute->kibi/unit
%var minute->kilo/unit
%var minute->hecto/unit
%var minute->deka/unit
%var minute->normal/unit
%var minute->deci/unit
%var minute->centi/unit
%var minute->milli/unit
%var minute->micro/unit
%var minute->nano/unit
%var minute->pico/unit
%var minute->minute/unit
%var minute->hour/unit
%var minute->day/unit
%var minute->week/unit
%var hour->pebi/unit
%var hour->peta/unit
%var hour->gibi/unit
%var hour->giga/unit
%var hour->mebi/unit
%var hour->mega/unit
%var hour->kibi/unit
%var hour->kilo/unit
%var hour->hecto/unit
%var hour->deka/unit
%var hour->normal/unit
%var hour->deci/unit
%var hour->centi/unit
%var hour->milli/unit
%var hour->micro/unit
%var hour->nano/unit
%var hour->pico/unit
%var hour->minute/unit
%var hour->hour/unit
%var hour->day/unit
%var hour->week/unit
%var day->pebi/unit
%var day->peta/unit
%var day->gibi/unit
%var day->giga/unit
%var day->mebi/unit
%var day->mega/unit
%var day->kibi/unit
%var day->kilo/unit
%var day->hecto/unit
%var day->deka/unit
%var day->normal/unit
%var day->deci/unit
%var day->centi/unit
%var day->milli/unit
%var day->micro/unit
%var day->nano/unit
%var day->pico/unit
%var day->minute/unit
%var day->hour/unit
%var day->day/unit
%var day->week/unit
%var week->pebi/unit
%var week->peta/unit
%var week->gibi/unit
%var week->giga/unit
%var week->mebi/unit
%var week->mega/unit
%var week->kibi/unit
%var week->kilo/unit
%var week->hecto/unit
%var week->deka/unit
%var week->normal/unit
%var week->deci/unit
%var week->centi/unit
%var week->milli/unit
%var week->micro/unit
%var week->nano/unit
%var week->pico/unit
%var week->minute/unit
%var week->hour/unit
%var week->day/unit
%var week->week/unit

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
