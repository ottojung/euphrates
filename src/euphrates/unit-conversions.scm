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

(cond-expand
 (guile
  (define-module (euphrates unit-conversions)
    :export (pebi->pebi/unit pebi->peta/unit pebi->gibi/unit pebi->giga/unit pebi->mebi/unit pebi->mega/unit pebi->kibi/unit pebi->kilo/unit pebi->hecto/unit pebi->deka/unit pebi->normal/unit pebi->deci/unit pebi->centi/unit pebi->milli/unit pebi->micro/unit pebi->nano/unit pebi->pico/unit pebi->minute/unit pebi->hour/unit pebi->day/unit pebi->week/unit peta->pebi/unit peta->peta/unit peta->gibi/unit peta->giga/unit peta->mebi/unit peta->mega/unit peta->kibi/unit peta->kilo/unit peta->hecto/unit peta->deka/unit peta->normal/unit peta->deci/unit peta->centi/unit peta->milli/unit peta->micro/unit peta->nano/unit peta->pico/unit peta->minute/unit peta->hour/unit peta->day/unit peta->week/unit gibi->pebi/unit gibi->peta/unit gibi->gibi/unit gibi->giga/unit gibi->mebi/unit gibi->mega/unit gibi->kibi/unit gibi->kilo/unit gibi->hecto/unit gibi->deka/unit gibi->normal/unit gibi->deci/unit gibi->centi/unit gibi->milli/unit gibi->micro/unit gibi->nano/unit gibi->pico/unit gibi->minute/unit gibi->hour/unit gibi->day/unit gibi->week/unit giga->pebi/unit giga->peta/unit giga->gibi/unit giga->giga/unit giga->mebi/unit giga->mega/unit giga->kibi/unit giga->kilo/unit giga->hecto/unit giga->deka/unit giga->normal/unit giga->deci/unit giga->centi/unit giga->milli/unit giga->micro/unit giga->nano/unit giga->pico/unit giga->minute/unit giga->hour/unit giga->day/unit giga->week/unit mebi->pebi/unit mebi->peta/unit mebi->gibi/unit mebi->giga/unit mebi->mebi/unit mebi->mega/unit mebi->kibi/unit mebi->kilo/unit mebi->hecto/unit mebi->deka/unit mebi->normal/unit mebi->deci/unit mebi->centi/unit mebi->milli/unit mebi->micro/unit mebi->nano/unit mebi->pico/unit mebi->minute/unit mebi->hour/unit mebi->day/unit mebi->week/unit mega->pebi/unit mega->peta/unit mega->gibi/unit mega->giga/unit mega->mebi/unit mega->mega/unit mega->kibi/unit mega->kilo/unit mega->hecto/unit mega->deka/unit mega->normal/unit mega->deci/unit mega->centi/unit mega->milli/unit mega->micro/unit mega->nano/unit mega->pico/unit mega->minute/unit mega->hour/unit mega->day/unit mega->week/unit kibi->pebi/unit kibi->peta/unit kibi->gibi/unit kibi->giga/unit kibi->mebi/unit kibi->mega/unit kibi->kibi/unit kibi->kilo/unit kibi->hecto/unit kibi->deka/unit kibi->normal/unit kibi->deci/unit kibi->centi/unit kibi->milli/unit kibi->micro/unit kibi->nano/unit kibi->pico/unit kibi->minute/unit kibi->hour/unit kibi->day/unit kibi->week/unit kilo->pebi/unit kilo->peta/unit kilo->gibi/unit kilo->giga/unit kilo->mebi/unit kilo->mega/unit kilo->kibi/unit kilo->kilo/unit kilo->hecto/unit kilo->deka/unit kilo->normal/unit kilo->deci/unit kilo->centi/unit kilo->milli/unit kilo->micro/unit kilo->nano/unit kilo->pico/unit kilo->minute/unit kilo->hour/unit kilo->day/unit kilo->week/unit hecto->pebi/unit hecto->peta/unit hecto->gibi/unit hecto->giga/unit hecto->mebi/unit hecto->mega/unit hecto->kibi/unit hecto->kilo/unit hecto->hecto/unit hecto->deka/unit hecto->normal/unit hecto->deci/unit hecto->centi/unit hecto->milli/unit hecto->micro/unit hecto->nano/unit hecto->pico/unit hecto->minute/unit hecto->hour/unit hecto->day/unit hecto->week/unit deka->pebi/unit deka->peta/unit deka->gibi/unit deka->giga/unit deka->mebi/unit deka->mega/unit deka->kibi/unit deka->kilo/unit deka->hecto/unit deka->deka/unit deka->normal/unit deka->deci/unit deka->centi/unit deka->milli/unit deka->micro/unit deka->nano/unit deka->pico/unit deka->minute/unit deka->hour/unit deka->day/unit deka->week/unit normal->pebi/unit normal->peta/unit normal->gibi/unit normal->giga/unit normal->mebi/unit normal->mega/unit normal->kibi/unit normal->kilo/unit normal->hecto/unit normal->deka/unit normal->normal/unit normal->deci/unit normal->centi/unit normal->milli/unit normal->micro/unit normal->nano/unit normal->pico/unit normal->minute/unit normal->hour/unit normal->day/unit normal->week/unit deci->pebi/unit deci->peta/unit deci->gibi/unit deci->giga/unit deci->mebi/unit deci->mega/unit deci->kibi/unit deci->kilo/unit deci->hecto/unit deci->deka/unit deci->normal/unit deci->deci/unit deci->centi/unit deci->milli/unit deci->micro/unit deci->nano/unit deci->pico/unit deci->minute/unit deci->hour/unit deci->day/unit deci->week/unit centi->pebi/unit centi->peta/unit centi->gibi/unit centi->giga/unit centi->mebi/unit centi->mega/unit centi->kibi/unit centi->kilo/unit centi->hecto/unit centi->deka/unit centi->normal/unit centi->deci/unit centi->centi/unit centi->milli/unit centi->micro/unit centi->nano/unit centi->pico/unit centi->minute/unit centi->hour/unit centi->day/unit centi->week/unit milli->pebi/unit milli->peta/unit milli->gibi/unit milli->giga/unit milli->mebi/unit milli->mega/unit milli->kibi/unit milli->kilo/unit milli->hecto/unit milli->deka/unit milli->normal/unit milli->deci/unit milli->centi/unit milli->milli/unit milli->micro/unit milli->nano/unit milli->pico/unit milli->minute/unit milli->hour/unit milli->day/unit milli->week/unit micro->pebi/unit micro->peta/unit micro->gibi/unit micro->giga/unit micro->mebi/unit micro->mega/unit micro->kibi/unit micro->kilo/unit micro->hecto/unit micro->deka/unit micro->normal/unit micro->deci/unit micro->centi/unit micro->milli/unit micro->micro/unit micro->nano/unit micro->pico/unit micro->minute/unit micro->hour/unit micro->day/unit micro->week/unit nano->pebi/unit nano->peta/unit nano->gibi/unit nano->giga/unit nano->mebi/unit nano->mega/unit nano->kibi/unit nano->kilo/unit nano->hecto/unit nano->deka/unit nano->normal/unit nano->deci/unit nano->centi/unit nano->milli/unit nano->micro/unit nano->nano/unit nano->pico/unit nano->minute/unit nano->hour/unit nano->day/unit nano->week/unit pico->pebi/unit pico->peta/unit pico->gibi/unit pico->giga/unit pico->mebi/unit pico->mega/unit pico->kibi/unit pico->kilo/unit pico->hecto/unit pico->deka/unit pico->normal/unit pico->deci/unit pico->centi/unit pico->milli/unit pico->micro/unit pico->nano/unit pico->pico/unit pico->minute/unit pico->hour/unit pico->day/unit pico->week/unit minute->pebi/unit minute->peta/unit minute->gibi/unit minute->giga/unit minute->mebi/unit minute->mega/unit minute->kibi/unit minute->kilo/unit minute->hecto/unit minute->deka/unit minute->normal/unit minute->deci/unit minute->centi/unit minute->milli/unit minute->micro/unit minute->nano/unit minute->pico/unit minute->minute/unit minute->hour/unit minute->day/unit minute->week/unit hour->pebi/unit hour->peta/unit hour->gibi/unit hour->giga/unit hour->mebi/unit hour->mega/unit hour->kibi/unit hour->kilo/unit hour->hecto/unit hour->deka/unit hour->normal/unit hour->deci/unit hour->centi/unit hour->milli/unit hour->micro/unit hour->nano/unit hour->pico/unit hour->minute/unit hour->hour/unit hour->day/unit hour->week/unit day->pebi/unit day->peta/unit day->gibi/unit day->giga/unit day->mebi/unit day->mega/unit day->kibi/unit day->kilo/unit day->hecto/unit day->deka/unit day->normal/unit day->deci/unit day->centi/unit day->milli/unit day->micro/unit day->nano/unit day->pico/unit day->minute/unit day->hour/unit day->day/unit day->week/unit week->pebi/unit week->peta/unit week->gibi/unit week->giga/unit week->mebi/unit week->mega/unit week->kibi/unit week->kilo/unit week->hecto/unit week->deka/unit week->normal/unit week->deci/unit week->centi/unit week->milli/unit week->micro/unit week->nano/unit week->pico/unit week->minute/unit week->hour/unit week->day/unit week->week/unit))))

(define-values (
     pebi->pebi/unit
     pebi->peta/unit
     pebi->gibi/unit
     pebi->giga/unit
     pebi->mebi/unit
     pebi->mega/unit
     pebi->kibi/unit
     pebi->kilo/unit
     pebi->hecto/unit
     pebi->deka/unit
     pebi->normal/unit
     pebi->deci/unit
     pebi->centi/unit
     pebi->milli/unit
     pebi->micro/unit
     pebi->nano/unit
     pebi->pico/unit
     pebi->minute/unit
     pebi->hour/unit
     pebi->day/unit
     pebi->week/unit
     peta->pebi/unit
     peta->peta/unit
     peta->gibi/unit
     peta->giga/unit
     peta->mebi/unit
     peta->mega/unit
     peta->kibi/unit
     peta->kilo/unit
     peta->hecto/unit
     peta->deka/unit
     peta->normal/unit
     peta->deci/unit
     peta->centi/unit
     peta->milli/unit
     peta->micro/unit
     peta->nano/unit
     peta->pico/unit
     peta->minute/unit
     peta->hour/unit
     peta->day/unit
     peta->week/unit
     gibi->pebi/unit
     gibi->peta/unit
     gibi->gibi/unit
     gibi->giga/unit
     gibi->mebi/unit
     gibi->mega/unit
     gibi->kibi/unit
     gibi->kilo/unit
     gibi->hecto/unit
     gibi->deka/unit
     gibi->normal/unit
     gibi->deci/unit
     gibi->centi/unit
     gibi->milli/unit
     gibi->micro/unit
     gibi->nano/unit
     gibi->pico/unit
     gibi->minute/unit
     gibi->hour/unit
     gibi->day/unit
     gibi->week/unit
     giga->pebi/unit
     giga->peta/unit
     giga->gibi/unit
     giga->giga/unit
     giga->mebi/unit
     giga->mega/unit
     giga->kibi/unit
     giga->kilo/unit
     giga->hecto/unit
     giga->deka/unit
     giga->normal/unit
     giga->deci/unit
     giga->centi/unit
     giga->milli/unit
     giga->micro/unit
     giga->nano/unit
     giga->pico/unit
     giga->minute/unit
     giga->hour/unit
     giga->day/unit
     giga->week/unit
     mebi->pebi/unit
     mebi->peta/unit
     mebi->gibi/unit
     mebi->giga/unit
     mebi->mebi/unit
     mebi->mega/unit
     mebi->kibi/unit
     mebi->kilo/unit
     mebi->hecto/unit
     mebi->deka/unit
     mebi->normal/unit
     mebi->deci/unit
     mebi->centi/unit
     mebi->milli/unit
     mebi->micro/unit
     mebi->nano/unit
     mebi->pico/unit
     mebi->minute/unit
     mebi->hour/unit
     mebi->day/unit
     mebi->week/unit
     mega->pebi/unit
     mega->peta/unit
     mega->gibi/unit
     mega->giga/unit
     mega->mebi/unit
     mega->mega/unit
     mega->kibi/unit
     mega->kilo/unit
     mega->hecto/unit
     mega->deka/unit
     mega->normal/unit
     mega->deci/unit
     mega->centi/unit
     mega->milli/unit
     mega->micro/unit
     mega->nano/unit
     mega->pico/unit
     mega->minute/unit
     mega->hour/unit
     mega->day/unit
     mega->week/unit
     kibi->pebi/unit
     kibi->peta/unit
     kibi->gibi/unit
     kibi->giga/unit
     kibi->mebi/unit
     kibi->mega/unit
     kibi->kibi/unit
     kibi->kilo/unit
     kibi->hecto/unit
     kibi->deka/unit
     kibi->normal/unit
     kibi->deci/unit
     kibi->centi/unit
     kibi->milli/unit
     kibi->micro/unit
     kibi->nano/unit
     kibi->pico/unit
     kibi->minute/unit
     kibi->hour/unit
     kibi->day/unit
     kibi->week/unit
     kilo->pebi/unit
     kilo->peta/unit
     kilo->gibi/unit
     kilo->giga/unit
     kilo->mebi/unit
     kilo->mega/unit
     kilo->kibi/unit
     kilo->kilo/unit
     kilo->hecto/unit
     kilo->deka/unit
     kilo->normal/unit
     kilo->deci/unit
     kilo->centi/unit
     kilo->milli/unit
     kilo->micro/unit
     kilo->nano/unit
     kilo->pico/unit
     kilo->minute/unit
     kilo->hour/unit
     kilo->day/unit
     kilo->week/unit
     hecto->pebi/unit
     hecto->peta/unit
     hecto->gibi/unit
     hecto->giga/unit
     hecto->mebi/unit
     hecto->mega/unit
     hecto->kibi/unit
     hecto->kilo/unit
     hecto->hecto/unit
     hecto->deka/unit
     hecto->normal/unit
     hecto->deci/unit
     hecto->centi/unit
     hecto->milli/unit
     hecto->micro/unit
     hecto->nano/unit
     hecto->pico/unit
     hecto->minute/unit
     hecto->hour/unit
     hecto->day/unit
     hecto->week/unit
     deka->pebi/unit
     deka->peta/unit
     deka->gibi/unit
     deka->giga/unit
     deka->mebi/unit
     deka->mega/unit
     deka->kibi/unit
     deka->kilo/unit
     deka->hecto/unit
     deka->deka/unit
     deka->normal/unit
     deka->deci/unit
     deka->centi/unit
     deka->milli/unit
     deka->micro/unit
     deka->nano/unit
     deka->pico/unit
     deka->minute/unit
     deka->hour/unit
     deka->day/unit
     deka->week/unit
     normal->pebi/unit
     normal->peta/unit
     normal->gibi/unit
     normal->giga/unit
     normal->mebi/unit
     normal->mega/unit
     normal->kibi/unit
     normal->kilo/unit
     normal->hecto/unit
     normal->deka/unit
     normal->normal/unit
     normal->deci/unit
     normal->centi/unit
     normal->milli/unit
     normal->micro/unit
     normal->nano/unit
     normal->pico/unit
     normal->minute/unit
     normal->hour/unit
     normal->day/unit
     normal->week/unit
     deci->pebi/unit
     deci->peta/unit
     deci->gibi/unit
     deci->giga/unit
     deci->mebi/unit
     deci->mega/unit
     deci->kibi/unit
     deci->kilo/unit
     deci->hecto/unit
     deci->deka/unit
     deci->normal/unit
     deci->deci/unit
     deci->centi/unit
     deci->milli/unit
     deci->micro/unit
     deci->nano/unit
     deci->pico/unit
     deci->minute/unit
     deci->hour/unit
     deci->day/unit
     deci->week/unit
     centi->pebi/unit
     centi->peta/unit
     centi->gibi/unit
     centi->giga/unit
     centi->mebi/unit
     centi->mega/unit
     centi->kibi/unit
     centi->kilo/unit
     centi->hecto/unit
     centi->deka/unit
     centi->normal/unit
     centi->deci/unit
     centi->centi/unit
     centi->milli/unit
     centi->micro/unit
     centi->nano/unit
     centi->pico/unit
     centi->minute/unit
     centi->hour/unit
     centi->day/unit
     centi->week/unit
     milli->pebi/unit
     milli->peta/unit
     milli->gibi/unit
     milli->giga/unit
     milli->mebi/unit
     milli->mega/unit
     milli->kibi/unit
     milli->kilo/unit
     milli->hecto/unit
     milli->deka/unit
     milli->normal/unit
     milli->deci/unit
     milli->centi/unit
     milli->milli/unit
     milli->micro/unit
     milli->nano/unit
     milli->pico/unit
     milli->minute/unit
     milli->hour/unit
     milli->day/unit
     milli->week/unit
     micro->pebi/unit
     micro->peta/unit
     micro->gibi/unit
     micro->giga/unit
     micro->mebi/unit
     micro->mega/unit
     micro->kibi/unit
     micro->kilo/unit
     micro->hecto/unit
     micro->deka/unit
     micro->normal/unit
     micro->deci/unit
     micro->centi/unit
     micro->milli/unit
     micro->micro/unit
     micro->nano/unit
     micro->pico/unit
     micro->minute/unit
     micro->hour/unit
     micro->day/unit
     micro->week/unit
     nano->pebi/unit
     nano->peta/unit
     nano->gibi/unit
     nano->giga/unit
     nano->mebi/unit
     nano->mega/unit
     nano->kibi/unit
     nano->kilo/unit
     nano->hecto/unit
     nano->deka/unit
     nano->normal/unit
     nano->deci/unit
     nano->centi/unit
     nano->milli/unit
     nano->micro/unit
     nano->nano/unit
     nano->pico/unit
     nano->minute/unit
     nano->hour/unit
     nano->day/unit
     nano->week/unit
     pico->pebi/unit
     pico->peta/unit
     pico->gibi/unit
     pico->giga/unit
     pico->mebi/unit
     pico->mega/unit
     pico->kibi/unit
     pico->kilo/unit
     pico->hecto/unit
     pico->deka/unit
     pico->normal/unit
     pico->deci/unit
     pico->centi/unit
     pico->milli/unit
     pico->micro/unit
     pico->nano/unit
     pico->pico/unit
     pico->minute/unit
     pico->hour/unit
     pico->day/unit
     pico->week/unit
     minute->pebi/unit
     minute->peta/unit
     minute->gibi/unit
     minute->giga/unit
     minute->mebi/unit
     minute->mega/unit
     minute->kibi/unit
     minute->kilo/unit
     minute->hecto/unit
     minute->deka/unit
     minute->normal/unit
     minute->deci/unit
     minute->centi/unit
     minute->milli/unit
     minute->micro/unit
     minute->nano/unit
     minute->pico/unit
     minute->minute/unit
     minute->hour/unit
     minute->day/unit
     minute->week/unit
     hour->pebi/unit
     hour->peta/unit
     hour->gibi/unit
     hour->giga/unit
     hour->mebi/unit
     hour->mega/unit
     hour->kibi/unit
     hour->kilo/unit
     hour->hecto/unit
     hour->deka/unit
     hour->normal/unit
     hour->deci/unit
     hour->centi/unit
     hour->milli/unit
     hour->micro/unit
     hour->nano/unit
     hour->pico/unit
     hour->minute/unit
     hour->hour/unit
     hour->day/unit
     hour->week/unit
     day->pebi/unit
     day->peta/unit
     day->gibi/unit
     day->giga/unit
     day->mebi/unit
     day->mega/unit
     day->kibi/unit
     day->kilo/unit
     day->hecto/unit
     day->deka/unit
     day->normal/unit
     day->deci/unit
     day->centi/unit
     day->milli/unit
     day->micro/unit
     day->nano/unit
     day->pico/unit
     day->minute/unit
     day->hour/unit
     day->day/unit
     day->week/unit
     week->pebi/unit
     week->peta/unit
     week->gibi/unit
     week->giga/unit
     week->mebi/unit
     week->mega/unit
     week->kibi/unit
     week->kilo/unit
     week->hecto/unit
     week->deka/unit
     week->normal/unit
     week->deci/unit
     week->centi/unit
     week->milli/unit
     week->micro/unit
     week->nano/unit
     week->pico/unit
     week->minute/unit
     week->hour/unit
     week->day/unit
     week->week/unit
     )

  (let ()


    (define pebi->pebi
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) (* 1024 1024 1024 1024))))


    (define pebi->peta
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 1000000000000)))


    (define pebi->gibi
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) (* 1024 1024 1024))))


    (define pebi->giga
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 1000000000)))


    (define pebi->mebi
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) (* 1024 1024))))


    (define pebi->mega
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 1000000)))


    (define pebi->kibi
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 1024)))


    (define pebi->kilo
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 1000)))


    (define pebi->hecto
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 100)))


    (define pebi->deka
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 10)))


    (define pebi->normal
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 1)))


    (define pebi->deci
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 1/10)))


    (define pebi->centi
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 1/100)))


    (define pebi->milli
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 1/1000)))


    (define pebi->micro
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 1/1000000)))


    (define pebi->nano
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 1/1000000000)))


    (define pebi->pico
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 1/1000000000000)))


    (define pebi->minute
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) 60)))


    (define pebi->hour
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) (* 60 60))))


    (define pebi->day
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) (* 60 60 24))))


    (define pebi->week
      (lambda (x)
        (/ (* x (* 1024 1024 1024 1024)) (* 60 60 24 7))))


    (define peta->pebi
      (lambda (x)
        (/ (* x 1000000000000) (* 1024 1024 1024 1024))))


    (define peta->peta
      (lambda (x)
        (/ (* x 1000000000000) 1000000000000)))


    (define peta->gibi
      (lambda (x)
        (/ (* x 1000000000000) (* 1024 1024 1024))))


    (define peta->giga
      (lambda (x)
        (/ (* x 1000000000000) 1000000000)))


    (define peta->mebi
      (lambda (x)
        (/ (* x 1000000000000) (* 1024 1024))))


    (define peta->mega
      (lambda (x)
        (/ (* x 1000000000000) 1000000)))


    (define peta->kibi
      (lambda (x)
        (/ (* x 1000000000000) 1024)))


    (define peta->kilo
      (lambda (x)
        (/ (* x 1000000000000) 1000)))


    (define peta->hecto
      (lambda (x)
        (/ (* x 1000000000000) 100)))


    (define peta->deka
      (lambda (x)
        (/ (* x 1000000000000) 10)))


    (define peta->normal
      (lambda (x)
        (/ (* x 1000000000000) 1)))


    (define peta->deci
      (lambda (x)
        (/ (* x 1000000000000) 1/10)))


    (define peta->centi
      (lambda (x)
        (/ (* x 1000000000000) 1/100)))


    (define peta->milli
      (lambda (x)
        (/ (* x 1000000000000) 1/1000)))


    (define peta->micro
      (lambda (x)
        (/ (* x 1000000000000) 1/1000000)))


    (define peta->nano
      (lambda (x)
        (/ (* x 1000000000000) 1/1000000000)))


    (define peta->pico
      (lambda (x)
        (/ (* x 1000000000000) 1/1000000000000)))


    (define peta->minute
      (lambda (x)
        (/ (* x 1000000000000) 60)))


    (define peta->hour
      (lambda (x)
        (/ (* x 1000000000000) (* 60 60))))


    (define peta->day
      (lambda (x)
        (/ (* x 1000000000000) (* 60 60 24))))


    (define peta->week
      (lambda (x)
        (/ (* x 1000000000000) (* 60 60 24 7))))


    (define gibi->pebi
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) (* 1024 1024 1024 1024))))


    (define gibi->peta
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 1000000000000)))


    (define gibi->gibi
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) (* 1024 1024 1024))))


    (define gibi->giga
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 1000000000)))


    (define gibi->mebi
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) (* 1024 1024))))


    (define gibi->mega
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 1000000)))


    (define gibi->kibi
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 1024)))


    (define gibi->kilo
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 1000)))


    (define gibi->hecto
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 100)))


    (define gibi->deka
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 10)))


    (define gibi->normal
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 1)))


    (define gibi->deci
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 1/10)))


    (define gibi->centi
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 1/100)))


    (define gibi->milli
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 1/1000)))


    (define gibi->micro
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 1/1000000)))


    (define gibi->nano
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 1/1000000000)))


    (define gibi->pico
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 1/1000000000000)))


    (define gibi->minute
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) 60)))


    (define gibi->hour
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) (* 60 60))))


    (define gibi->day
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) (* 60 60 24))))


    (define gibi->week
      (lambda (x)
        (/ (* x (* 1024 1024 1024)) (* 60 60 24 7))))


    (define giga->pebi
      (lambda (x)
        (/ (* x 1000000000) (* 1024 1024 1024 1024))))


    (define giga->peta
      (lambda (x)
        (/ (* x 1000000000) 1000000000000)))


    (define giga->gibi
      (lambda (x)
        (/ (* x 1000000000) (* 1024 1024 1024))))


    (define giga->giga
      (lambda (x)
        (/ (* x 1000000000) 1000000000)))


    (define giga->mebi
      (lambda (x)
        (/ (* x 1000000000) (* 1024 1024))))


    (define giga->mega
      (lambda (x)
        (/ (* x 1000000000) 1000000)))


    (define giga->kibi
      (lambda (x)
        (/ (* x 1000000000) 1024)))


    (define giga->kilo
      (lambda (x)
        (/ (* x 1000000000) 1000)))


    (define giga->hecto
      (lambda (x)
        (/ (* x 1000000000) 100)))


    (define giga->deka
      (lambda (x)
        (/ (* x 1000000000) 10)))


    (define giga->normal
      (lambda (x)
        (/ (* x 1000000000) 1)))


    (define giga->deci
      (lambda (x)
        (/ (* x 1000000000) 1/10)))


    (define giga->centi
      (lambda (x)
        (/ (* x 1000000000) 1/100)))


    (define giga->milli
      (lambda (x)
        (/ (* x 1000000000) 1/1000)))


    (define giga->micro
      (lambda (x)
        (/ (* x 1000000000) 1/1000000)))


    (define giga->nano
      (lambda (x)
        (/ (* x 1000000000) 1/1000000000)))


    (define giga->pico
      (lambda (x)
        (/ (* x 1000000000) 1/1000000000000)))


    (define giga->minute
      (lambda (x)
        (/ (* x 1000000000) 60)))


    (define giga->hour
      (lambda (x)
        (/ (* x 1000000000) (* 60 60))))


    (define giga->day
      (lambda (x)
        (/ (* x 1000000000) (* 60 60 24))))


    (define giga->week
      (lambda (x)
        (/ (* x 1000000000) (* 60 60 24 7))))


    (define mebi->pebi
      (lambda (x)
        (/ (* x (* 1024 1024)) (* 1024 1024 1024 1024))))


    (define mebi->peta
      (lambda (x)
        (/ (* x (* 1024 1024)) 1000000000000)))


    (define mebi->gibi
      (lambda (x)
        (/ (* x (* 1024 1024)) (* 1024 1024 1024))))


    (define mebi->giga
      (lambda (x)
        (/ (* x (* 1024 1024)) 1000000000)))


    (define mebi->mebi
      (lambda (x)
        (/ (* x (* 1024 1024)) (* 1024 1024))))


    (define mebi->mega
      (lambda (x)
        (/ (* x (* 1024 1024)) 1000000)))


    (define mebi->kibi
      (lambda (x)
        (/ (* x (* 1024 1024)) 1024)))


    (define mebi->kilo
      (lambda (x)
        (/ (* x (* 1024 1024)) 1000)))


    (define mebi->hecto
      (lambda (x)
        (/ (* x (* 1024 1024)) 100)))


    (define mebi->deka
      (lambda (x)
        (/ (* x (* 1024 1024)) 10)))


    (define mebi->normal
      (lambda (x)
        (/ (* x (* 1024 1024)) 1)))


    (define mebi->deci
      (lambda (x)
        (/ (* x (* 1024 1024)) 1/10)))


    (define mebi->centi
      (lambda (x)
        (/ (* x (* 1024 1024)) 1/100)))


    (define mebi->milli
      (lambda (x)
        (/ (* x (* 1024 1024)) 1/1000)))


    (define mebi->micro
      (lambda (x)
        (/ (* x (* 1024 1024)) 1/1000000)))


    (define mebi->nano
      (lambda (x)
        (/ (* x (* 1024 1024)) 1/1000000000)))


    (define mebi->pico
      (lambda (x)
        (/ (* x (* 1024 1024)) 1/1000000000000)))


    (define mebi->minute
      (lambda (x)
        (/ (* x (* 1024 1024)) 60)))


    (define mebi->hour
      (lambda (x)
        (/ (* x (* 1024 1024)) (* 60 60))))


    (define mebi->day
      (lambda (x)
        (/ (* x (* 1024 1024)) (* 60 60 24))))


    (define mebi->week
      (lambda (x)
        (/ (* x (* 1024 1024)) (* 60 60 24 7))))


    (define mega->pebi
      (lambda (x)
        (/ (* x 1000000) (* 1024 1024 1024 1024))))


    (define mega->peta
      (lambda (x)
        (/ (* x 1000000) 1000000000000)))


    (define mega->gibi
      (lambda (x)
        (/ (* x 1000000) (* 1024 1024 1024))))


    (define mega->giga
      (lambda (x)
        (/ (* x 1000000) 1000000000)))


    (define mega->mebi
      (lambda (x)
        (/ (* x 1000000) (* 1024 1024))))


    (define mega->mega
      (lambda (x)
        (/ (* x 1000000) 1000000)))


    (define mega->kibi
      (lambda (x)
        (/ (* x 1000000) 1024)))


    (define mega->kilo
      (lambda (x)
        (/ (* x 1000000) 1000)))


    (define mega->hecto
      (lambda (x)
        (/ (* x 1000000) 100)))


    (define mega->deka
      (lambda (x)
        (/ (* x 1000000) 10)))


    (define mega->normal
      (lambda (x)
        (/ (* x 1000000) 1)))


    (define mega->deci
      (lambda (x)
        (/ (* x 1000000) 1/10)))


    (define mega->centi
      (lambda (x)
        (/ (* x 1000000) 1/100)))


    (define mega->milli
      (lambda (x)
        (/ (* x 1000000) 1/1000)))


    (define mega->micro
      (lambda (x)
        (/ (* x 1000000) 1/1000000)))


    (define mega->nano
      (lambda (x)
        (/ (* x 1000000) 1/1000000000)))


    (define mega->pico
      (lambda (x)
        (/ (* x 1000000) 1/1000000000000)))


    (define mega->minute
      (lambda (x)
        (/ (* x 1000000) 60)))


    (define mega->hour
      (lambda (x)
        (/ (* x 1000000) (* 60 60))))


    (define mega->day
      (lambda (x)
        (/ (* x 1000000) (* 60 60 24))))


    (define mega->week
      (lambda (x)
        (/ (* x 1000000) (* 60 60 24 7))))


    (define kibi->pebi
      (lambda (x)
        (/ (* x 1024) (* 1024 1024 1024 1024))))


    (define kibi->peta
      (lambda (x)
        (/ (* x 1024) 1000000000000)))


    (define kibi->gibi
      (lambda (x)
        (/ (* x 1024) (* 1024 1024 1024))))


    (define kibi->giga
      (lambda (x)
        (/ (* x 1024) 1000000000)))


    (define kibi->mebi
      (lambda (x)
        (/ (* x 1024) (* 1024 1024))))


    (define kibi->mega
      (lambda (x)
        (/ (* x 1024) 1000000)))


    (define kibi->kibi
      (lambda (x)
        (/ (* x 1024) 1024)))


    (define kibi->kilo
      (lambda (x)
        (/ (* x 1024) 1000)))


    (define kibi->hecto
      (lambda (x)
        (/ (* x 1024) 100)))


    (define kibi->deka
      (lambda (x)
        (/ (* x 1024) 10)))


    (define kibi->normal
      (lambda (x)
        (/ (* x 1024) 1)))


    (define kibi->deci
      (lambda (x)
        (/ (* x 1024) 1/10)))


    (define kibi->centi
      (lambda (x)
        (/ (* x 1024) 1/100)))


    (define kibi->milli
      (lambda (x)
        (/ (* x 1024) 1/1000)))


    (define kibi->micro
      (lambda (x)
        (/ (* x 1024) 1/1000000)))


    (define kibi->nano
      (lambda (x)
        (/ (* x 1024) 1/1000000000)))


    (define kibi->pico
      (lambda (x)
        (/ (* x 1024) 1/1000000000000)))


    (define kibi->minute
      (lambda (x)
        (/ (* x 1024) 60)))


    (define kibi->hour
      (lambda (x)
        (/ (* x 1024) (* 60 60))))


    (define kibi->day
      (lambda (x)
        (/ (* x 1024) (* 60 60 24))))


    (define kibi->week
      (lambda (x)
        (/ (* x 1024) (* 60 60 24 7))))


    (define kilo->pebi
      (lambda (x)
        (/ (* x 1000) (* 1024 1024 1024 1024))))


    (define kilo->peta
      (lambda (x)
        (/ (* x 1000) 1000000000000)))


    (define kilo->gibi
      (lambda (x)
        (/ (* x 1000) (* 1024 1024 1024))))


    (define kilo->giga
      (lambda (x)
        (/ (* x 1000) 1000000000)))


    (define kilo->mebi
      (lambda (x)
        (/ (* x 1000) (* 1024 1024))))


    (define kilo->mega
      (lambda (x)
        (/ (* x 1000) 1000000)))


    (define kilo->kibi
      (lambda (x)
        (/ (* x 1000) 1024)))


    (define kilo->kilo
      (lambda (x)
        (/ (* x 1000) 1000)))


    (define kilo->hecto
      (lambda (x)
        (/ (* x 1000) 100)))


    (define kilo->deka
      (lambda (x)
        (/ (* x 1000) 10)))


    (define kilo->normal
      (lambda (x)
        (/ (* x 1000) 1)))


    (define kilo->deci
      (lambda (x)
        (/ (* x 1000) 1/10)))


    (define kilo->centi
      (lambda (x)
        (/ (* x 1000) 1/100)))


    (define kilo->milli
      (lambda (x)
        (/ (* x 1000) 1/1000)))


    (define kilo->micro
      (lambda (x)
        (/ (* x 1000) 1/1000000)))


    (define kilo->nano
      (lambda (x)
        (/ (* x 1000) 1/1000000000)))


    (define kilo->pico
      (lambda (x)
        (/ (* x 1000) 1/1000000000000)))


    (define kilo->minute
      (lambda (x)
        (/ (* x 1000) 60)))


    (define kilo->hour
      (lambda (x)
        (/ (* x 1000) (* 60 60))))


    (define kilo->day
      (lambda (x)
        (/ (* x 1000) (* 60 60 24))))


    (define kilo->week
      (lambda (x)
        (/ (* x 1000) (* 60 60 24 7))))


    (define hecto->pebi
      (lambda (x)
        (/ (* x 100) (* 1024 1024 1024 1024))))


    (define hecto->peta
      (lambda (x)
        (/ (* x 100) 1000000000000)))


    (define hecto->gibi
      (lambda (x)
        (/ (* x 100) (* 1024 1024 1024))))


    (define hecto->giga
      (lambda (x)
        (/ (* x 100) 1000000000)))


    (define hecto->mebi
      (lambda (x)
        (/ (* x 100) (* 1024 1024))))


    (define hecto->mega
      (lambda (x)
        (/ (* x 100) 1000000)))


    (define hecto->kibi
      (lambda (x)
        (/ (* x 100) 1024)))


    (define hecto->kilo
      (lambda (x)
        (/ (* x 100) 1000)))


    (define hecto->hecto
      (lambda (x)
        (/ (* x 100) 100)))


    (define hecto->deka
      (lambda (x)
        (/ (* x 100) 10)))


    (define hecto->normal
      (lambda (x)
        (/ (* x 100) 1)))


    (define hecto->deci
      (lambda (x)
        (/ (* x 100) 1/10)))


    (define hecto->centi
      (lambda (x)
        (/ (* x 100) 1/100)))


    (define hecto->milli
      (lambda (x)
        (/ (* x 100) 1/1000)))


    (define hecto->micro
      (lambda (x)
        (/ (* x 100) 1/1000000)))


    (define hecto->nano
      (lambda (x)
        (/ (* x 100) 1/1000000000)))


    (define hecto->pico
      (lambda (x)
        (/ (* x 100) 1/1000000000000)))


    (define hecto->minute
      (lambda (x)
        (/ (* x 100) 60)))


    (define hecto->hour
      (lambda (x)
        (/ (* x 100) (* 60 60))))


    (define hecto->day
      (lambda (x)
        (/ (* x 100) (* 60 60 24))))


    (define hecto->week
      (lambda (x)
        (/ (* x 100) (* 60 60 24 7))))


    (define deka->pebi
      (lambda (x)
        (/ (* x 10) (* 1024 1024 1024 1024))))


    (define deka->peta
      (lambda (x)
        (/ (* x 10) 1000000000000)))


    (define deka->gibi
      (lambda (x)
        (/ (* x 10) (* 1024 1024 1024))))


    (define deka->giga
      (lambda (x)
        (/ (* x 10) 1000000000)))


    (define deka->mebi
      (lambda (x)
        (/ (* x 10) (* 1024 1024))))


    (define deka->mega
      (lambda (x)
        (/ (* x 10) 1000000)))


    (define deka->kibi
      (lambda (x)
        (/ (* x 10) 1024)))


    (define deka->kilo
      (lambda (x)
        (/ (* x 10) 1000)))


    (define deka->hecto
      (lambda (x)
        (/ (* x 10) 100)))


    (define deka->deka
      (lambda (x)
        (/ (* x 10) 10)))


    (define deka->normal
      (lambda (x)
        (/ (* x 10) 1)))


    (define deka->deci
      (lambda (x)
        (/ (* x 10) 1/10)))


    (define deka->centi
      (lambda (x)
        (/ (* x 10) 1/100)))


    (define deka->milli
      (lambda (x)
        (/ (* x 10) 1/1000)))


    (define deka->micro
      (lambda (x)
        (/ (* x 10) 1/1000000)))


    (define deka->nano
      (lambda (x)
        (/ (* x 10) 1/1000000000)))


    (define deka->pico
      (lambda (x)
        (/ (* x 10) 1/1000000000000)))


    (define deka->minute
      (lambda (x)
        (/ (* x 10) 60)))


    (define deka->hour
      (lambda (x)
        (/ (* x 10) (* 60 60))))


    (define deka->day
      (lambda (x)
        (/ (* x 10) (* 60 60 24))))


    (define deka->week
      (lambda (x)
        (/ (* x 10) (* 60 60 24 7))))


    (define normal->pebi
      (lambda (x)
        (/ (* x 1) (* 1024 1024 1024 1024))))


    (define normal->peta
      (lambda (x)
        (/ (* x 1) 1000000000000)))


    (define normal->gibi
      (lambda (x)
        (/ (* x 1) (* 1024 1024 1024))))


    (define normal->giga
      (lambda (x)
        (/ (* x 1) 1000000000)))


    (define normal->mebi
      (lambda (x)
        (/ (* x 1) (* 1024 1024))))


    (define normal->mega
      (lambda (x)
        (/ (* x 1) 1000000)))


    (define normal->kibi
      (lambda (x)
        (/ (* x 1) 1024)))


    (define normal->kilo
      (lambda (x)
        (/ (* x 1) 1000)))


    (define normal->hecto
      (lambda (x)
        (/ (* x 1) 100)))


    (define normal->deka
      (lambda (x)
        (/ (* x 1) 10)))


    (define normal->normal
      (lambda (x)
        (/ (* x 1) 1)))


    (define normal->deci
      (lambda (x)
        (/ (* x 1) 1/10)))


    (define normal->centi
      (lambda (x)
        (/ (* x 1) 1/100)))


    (define normal->milli
      (lambda (x)
        (/ (* x 1) 1/1000)))


    (define normal->micro
      (lambda (x)
        (/ (* x 1) 1/1000000)))


    (define normal->nano
      (lambda (x)
        (/ (* x 1) 1/1000000000)))


    (define normal->pico
      (lambda (x)
        (/ (* x 1) 1/1000000000000)))


    (define normal->minute
      (lambda (x)
        (/ (* x 1) 60)))


    (define normal->hour
      (lambda (x)
        (/ (* x 1) (* 60 60))))


    (define normal->day
      (lambda (x)
        (/ (* x 1) (* 60 60 24))))


    (define normal->week
      (lambda (x)
        (/ (* x 1) (* 60 60 24 7))))


    (define deci->pebi
      (lambda (x)
        (/ (* x 1/10) (* 1024 1024 1024 1024))))


    (define deci->peta
      (lambda (x)
        (/ (* x 1/10) 1000000000000)))


    (define deci->gibi
      (lambda (x)
        (/ (* x 1/10) (* 1024 1024 1024))))


    (define deci->giga
      (lambda (x)
        (/ (* x 1/10) 1000000000)))


    (define deci->mebi
      (lambda (x)
        (/ (* x 1/10) (* 1024 1024))))


    (define deci->mega
      (lambda (x)
        (/ (* x 1/10) 1000000)))


    (define deci->kibi
      (lambda (x)
        (/ (* x 1/10) 1024)))


    (define deci->kilo
      (lambda (x)
        (/ (* x 1/10) 1000)))


    (define deci->hecto
      (lambda (x)
        (/ (* x 1/10) 100)))


    (define deci->deka
      (lambda (x)
        (/ (* x 1/10) 10)))


    (define deci->normal
      (lambda (x)
        (/ (* x 1/10) 1)))


    (define deci->deci
      (lambda (x)
        (/ (* x 1/10) 1/10)))


    (define deci->centi
      (lambda (x)
        (/ (* x 1/10) 1/100)))


    (define deci->milli
      (lambda (x)
        (/ (* x 1/10) 1/1000)))


    (define deci->micro
      (lambda (x)
        (/ (* x 1/10) 1/1000000)))


    (define deci->nano
      (lambda (x)
        (/ (* x 1/10) 1/1000000000)))


    (define deci->pico
      (lambda (x)
        (/ (* x 1/10) 1/1000000000000)))


    (define deci->minute
      (lambda (x)
        (/ (* x 1/10) 60)))


    (define deci->hour
      (lambda (x)
        (/ (* x 1/10) (* 60 60))))


    (define deci->day
      (lambda (x)
        (/ (* x 1/10) (* 60 60 24))))


    (define deci->week
      (lambda (x)
        (/ (* x 1/10) (* 60 60 24 7))))


    (define centi->pebi
      (lambda (x)
        (/ (* x 1/100) (* 1024 1024 1024 1024))))


    (define centi->peta
      (lambda (x)
        (/ (* x 1/100) 1000000000000)))


    (define centi->gibi
      (lambda (x)
        (/ (* x 1/100) (* 1024 1024 1024))))


    (define centi->giga
      (lambda (x)
        (/ (* x 1/100) 1000000000)))


    (define centi->mebi
      (lambda (x)
        (/ (* x 1/100) (* 1024 1024))))


    (define centi->mega
      (lambda (x)
        (/ (* x 1/100) 1000000)))


    (define centi->kibi
      (lambda (x)
        (/ (* x 1/100) 1024)))


    (define centi->kilo
      (lambda (x)
        (/ (* x 1/100) 1000)))


    (define centi->hecto
      (lambda (x)
        (/ (* x 1/100) 100)))


    (define centi->deka
      (lambda (x)
        (/ (* x 1/100) 10)))


    (define centi->normal
      (lambda (x)
        (/ (* x 1/100) 1)))


    (define centi->deci
      (lambda (x)
        (/ (* x 1/100) 1/10)))


    (define centi->centi
      (lambda (x)
        (/ (* x 1/100) 1/100)))


    (define centi->milli
      (lambda (x)
        (/ (* x 1/100) 1/1000)))


    (define centi->micro
      (lambda (x)
        (/ (* x 1/100) 1/1000000)))


    (define centi->nano
      (lambda (x)
        (/ (* x 1/100) 1/1000000000)))


    (define centi->pico
      (lambda (x)
        (/ (* x 1/100) 1/1000000000000)))


    (define centi->minute
      (lambda (x)
        (/ (* x 1/100) 60)))


    (define centi->hour
      (lambda (x)
        (/ (* x 1/100) (* 60 60))))


    (define centi->day
      (lambda (x)
        (/ (* x 1/100) (* 60 60 24))))


    (define centi->week
      (lambda (x)
        (/ (* x 1/100) (* 60 60 24 7))))


    (define milli->pebi
      (lambda (x)
        (/ (* x 1/1000) (* 1024 1024 1024 1024))))


    (define milli->peta
      (lambda (x)
        (/ (* x 1/1000) 1000000000000)))


    (define milli->gibi
      (lambda (x)
        (/ (* x 1/1000) (* 1024 1024 1024))))


    (define milli->giga
      (lambda (x)
        (/ (* x 1/1000) 1000000000)))


    (define milli->mebi
      (lambda (x)
        (/ (* x 1/1000) (* 1024 1024))))


    (define milli->mega
      (lambda (x)
        (/ (* x 1/1000) 1000000)))


    (define milli->kibi
      (lambda (x)
        (/ (* x 1/1000) 1024)))


    (define milli->kilo
      (lambda (x)
        (/ (* x 1/1000) 1000)))


    (define milli->hecto
      (lambda (x)
        (/ (* x 1/1000) 100)))


    (define milli->deka
      (lambda (x)
        (/ (* x 1/1000) 10)))


    (define milli->normal
      (lambda (x)
        (/ (* x 1/1000) 1)))


    (define milli->deci
      (lambda (x)
        (/ (* x 1/1000) 1/10)))


    (define milli->centi
      (lambda (x)
        (/ (* x 1/1000) 1/100)))


    (define milli->milli
      (lambda (x)
        (/ (* x 1/1000) 1/1000)))


    (define milli->micro
      (lambda (x)
        (/ (* x 1/1000) 1/1000000)))


    (define milli->nano
      (lambda (x)
        (/ (* x 1/1000) 1/1000000000)))


    (define milli->pico
      (lambda (x)
        (/ (* x 1/1000) 1/1000000000000)))


    (define milli->minute
      (lambda (x)
        (/ (* x 1/1000) 60)))


    (define milli->hour
      (lambda (x)
        (/ (* x 1/1000) (* 60 60))))


    (define milli->day
      (lambda (x)
        (/ (* x 1/1000) (* 60 60 24))))


    (define milli->week
      (lambda (x)
        (/ (* x 1/1000) (* 60 60 24 7))))


    (define micro->pebi
      (lambda (x)
        (/ (* x 1/1000000) (* 1024 1024 1024 1024))))


    (define micro->peta
      (lambda (x)
        (/ (* x 1/1000000) 1000000000000)))


    (define micro->gibi
      (lambda (x)
        (/ (* x 1/1000000) (* 1024 1024 1024))))


    (define micro->giga
      (lambda (x)
        (/ (* x 1/1000000) 1000000000)))


    (define micro->mebi
      (lambda (x)
        (/ (* x 1/1000000) (* 1024 1024))))


    (define micro->mega
      (lambda (x)
        (/ (* x 1/1000000) 1000000)))


    (define micro->kibi
      (lambda (x)
        (/ (* x 1/1000000) 1024)))


    (define micro->kilo
      (lambda (x)
        (/ (* x 1/1000000) 1000)))


    (define micro->hecto
      (lambda (x)
        (/ (* x 1/1000000) 100)))


    (define micro->deka
      (lambda (x)
        (/ (* x 1/1000000) 10)))


    (define micro->normal
      (lambda (x)
        (/ (* x 1/1000000) 1)))


    (define micro->deci
      (lambda (x)
        (/ (* x 1/1000000) 1/10)))


    (define micro->centi
      (lambda (x)
        (/ (* x 1/1000000) 1/100)))


    (define micro->milli
      (lambda (x)
        (/ (* x 1/1000000) 1/1000)))


    (define micro->micro
      (lambda (x)
        (/ (* x 1/1000000) 1/1000000)))


    (define micro->nano
      (lambda (x)
        (/ (* x 1/1000000) 1/1000000000)))


    (define micro->pico
      (lambda (x)
        (/ (* x 1/1000000) 1/1000000000000)))


    (define micro->minute
      (lambda (x)
        (/ (* x 1/1000000) 60)))


    (define micro->hour
      (lambda (x)
        (/ (* x 1/1000000) (* 60 60))))


    (define micro->day
      (lambda (x)
        (/ (* x 1/1000000) (* 60 60 24))))


    (define micro->week
      (lambda (x)
        (/ (* x 1/1000000) (* 60 60 24 7))))


    (define nano->pebi
      (lambda (x)
        (/ (* x 1/1000000000) (* 1024 1024 1024 1024))))


    (define nano->peta
      (lambda (x)
        (/ (* x 1/1000000000) 1000000000000)))


    (define nano->gibi
      (lambda (x)
        (/ (* x 1/1000000000) (* 1024 1024 1024))))


    (define nano->giga
      (lambda (x)
        (/ (* x 1/1000000000) 1000000000)))


    (define nano->mebi
      (lambda (x)
        (/ (* x 1/1000000000) (* 1024 1024))))


    (define nano->mega
      (lambda (x)
        (/ (* x 1/1000000000) 1000000)))


    (define nano->kibi
      (lambda (x)
        (/ (* x 1/1000000000) 1024)))


    (define nano->kilo
      (lambda (x)
        (/ (* x 1/1000000000) 1000)))


    (define nano->hecto
      (lambda (x)
        (/ (* x 1/1000000000) 100)))


    (define nano->deka
      (lambda (x)
        (/ (* x 1/1000000000) 10)))


    (define nano->normal
      (lambda (x)
        (/ (* x 1/1000000000) 1)))


    (define nano->deci
      (lambda (x)
        (/ (* x 1/1000000000) 1/10)))


    (define nano->centi
      (lambda (x)
        (/ (* x 1/1000000000) 1/100)))


    (define nano->milli
      (lambda (x)
        (/ (* x 1/1000000000) 1/1000)))


    (define nano->micro
      (lambda (x)
        (/ (* x 1/1000000000) 1/1000000)))


    (define nano->nano
      (lambda (x)
        (/ (* x 1/1000000000) 1/1000000000)))


    (define nano->pico
      (lambda (x)
        (/ (* x 1/1000000000) 1/1000000000000)))


    (define nano->minute
      (lambda (x)
        (/ (* x 1/1000000000) 60)))


    (define nano->hour
      (lambda (x)
        (/ (* x 1/1000000000) (* 60 60))))


    (define nano->day
      (lambda (x)
        (/ (* x 1/1000000000) (* 60 60 24))))


    (define nano->week
      (lambda (x)
        (/ (* x 1/1000000000) (* 60 60 24 7))))


    (define pico->pebi
      (lambda (x)
        (/ (* x 1/1000000000000) (* 1024 1024 1024 1024))))


    (define pico->peta
      (lambda (x)
        (/ (* x 1/1000000000000) 1000000000000)))


    (define pico->gibi
      (lambda (x)
        (/ (* x 1/1000000000000) (* 1024 1024 1024))))


    (define pico->giga
      (lambda (x)
        (/ (* x 1/1000000000000) 1000000000)))


    (define pico->mebi
      (lambda (x)
        (/ (* x 1/1000000000000) (* 1024 1024))))


    (define pico->mega
      (lambda (x)
        (/ (* x 1/1000000000000) 1000000)))


    (define pico->kibi
      (lambda (x)
        (/ (* x 1/1000000000000) 1024)))


    (define pico->kilo
      (lambda (x)
        (/ (* x 1/1000000000000) 1000)))


    (define pico->hecto
      (lambda (x)
        (/ (* x 1/1000000000000) 100)))


    (define pico->deka
      (lambda (x)
        (/ (* x 1/1000000000000) 10)))


    (define pico->normal
      (lambda (x)
        (/ (* x 1/1000000000000) 1)))


    (define pico->deci
      (lambda (x)
        (/ (* x 1/1000000000000) 1/10)))


    (define pico->centi
      (lambda (x)
        (/ (* x 1/1000000000000) 1/100)))


    (define pico->milli
      (lambda (x)
        (/ (* x 1/1000000000000) 1/1000)))


    (define pico->micro
      (lambda (x)
        (/ (* x 1/1000000000000) 1/1000000)))


    (define pico->nano
      (lambda (x)
        (/ (* x 1/1000000000000) 1/1000000000)))


    (define pico->pico
      (lambda (x)
        (/ (* x 1/1000000000000) 1/1000000000000)))


    (define pico->minute
      (lambda (x)
        (/ (* x 1/1000000000000) 60)))


    (define pico->hour
      (lambda (x)
        (/ (* x 1/1000000000000) (* 60 60))))


    (define pico->day
      (lambda (x)
        (/ (* x 1/1000000000000) (* 60 60 24))))


    (define pico->week
      (lambda (x)
        (/ (* x 1/1000000000000) (* 60 60 24 7))))


    (define minute->pebi
      (lambda (x)
        (/ (* x 60) (* 1024 1024 1024 1024))))


    (define minute->peta
      (lambda (x)
        (/ (* x 60) 1000000000000)))


    (define minute->gibi
      (lambda (x)
        (/ (* x 60) (* 1024 1024 1024))))


    (define minute->giga
      (lambda (x)
        (/ (* x 60) 1000000000)))


    (define minute->mebi
      (lambda (x)
        (/ (* x 60) (* 1024 1024))))


    (define minute->mega
      (lambda (x)
        (/ (* x 60) 1000000)))


    (define minute->kibi
      (lambda (x)
        (/ (* x 60) 1024)))


    (define minute->kilo
      (lambda (x)
        (/ (* x 60) 1000)))


    (define minute->hecto
      (lambda (x)
        (/ (* x 60) 100)))


    (define minute->deka
      (lambda (x)
        (/ (* x 60) 10)))


    (define minute->normal
      (lambda (x)
        (/ (* x 60) 1)))


    (define minute->deci
      (lambda (x)
        (/ (* x 60) 1/10)))


    (define minute->centi
      (lambda (x)
        (/ (* x 60) 1/100)))


    (define minute->milli
      (lambda (x)
        (/ (* x 60) 1/1000)))


    (define minute->micro
      (lambda (x)
        (/ (* x 60) 1/1000000)))


    (define minute->nano
      (lambda (x)
        (/ (* x 60) 1/1000000000)))


    (define minute->pico
      (lambda (x)
        (/ (* x 60) 1/1000000000000)))


    (define minute->minute
      (lambda (x)
        (/ (* x 60) 60)))


    (define minute->hour
      (lambda (x)
        (/ (* x 60) (* 60 60))))


    (define minute->day
      (lambda (x)
        (/ (* x 60) (* 60 60 24))))


    (define minute->week
      (lambda (x)
        (/ (* x 60) (* 60 60 24 7))))


  (define hour->pebi
    (lambda (x)
      (/ (* x (* 60 60)) (* 1024 1024 1024 1024))))


  (define hour->peta
    (lambda (x)
      (/ (* x (* 60 60)) 1000000000000)))


  (define hour->gibi
    (lambda (x)
      (/ (* x (* 60 60)) (* 1024 1024 1024))))


  (define hour->giga
    (lambda (x)
      (/ (* x (* 60 60)) 1000000000)))


  (define hour->mebi
    (lambda (x)
      (/ (* x (* 60 60)) (* 1024 1024))))


  (define hour->mega
    (lambda (x)
      (/ (* x (* 60 60)) 1000000)))


  (define hour->kibi
    (lambda (x)
      (/ (* x (* 60 60)) 1024)))


  (define hour->kilo
    (lambda (x)
      (/ (* x (* 60 60)) 1000)))


  (define hour->hecto
    (lambda (x)
      (/ (* x (* 60 60)) 100)))


  (define hour->deka
    (lambda (x)
      (/ (* x (* 60 60)) 10)))


  (define hour->normal
    (lambda (x)
      (/ (* x (* 60 60)) 1)))


  (define hour->deci
    (lambda (x)
      (/ (* x (* 60 60)) 1/10)))


  (define hour->centi
    (lambda (x)
      (/ (* x (* 60 60)) 1/100)))


  (define hour->milli
    (lambda (x)
      (/ (* x (* 60 60)) 1/1000)))


  (define hour->micro
    (lambda (x)
      (/ (* x (* 60 60)) 1/1000000)))


  (define hour->nano
    (lambda (x)
      (/ (* x (* 60 60)) 1/1000000000)))


  (define hour->pico
    (lambda (x)
      (/ (* x (* 60 60)) 1/1000000000000)))


  (define hour->minute
    (lambda (x)
      (/ (* x (* 60 60)) 60)))


  (define hour->hour
    (lambda (x)
      (/ (* x (* 60 60)) (* 60 60))))


  (define hour->day
    (lambda (x)
      (/ (* x (* 60 60)) (* 60 60 24))))


  (define hour->week
    (lambda (x)
      (/ (* x (* 60 60)) (* 60 60 24 7))))


  (define day->pebi
    (lambda (x)
      (/ (* x (* 60 60 24)) (* 1024 1024 1024 1024))))


  (define day->peta
    (lambda (x)
      (/ (* x (* 60 60 24)) 1000000000000)))


  (define day->gibi
    (lambda (x)
      (/ (* x (* 60 60 24)) (* 1024 1024 1024))))


  (define day->giga
    (lambda (x)
      (/ (* x (* 60 60 24)) 1000000000)))


  (define day->mebi
    (lambda (x)
      (/ (* x (* 60 60 24)) (* 1024 1024))))


  (define day->mega
    (lambda (x)
      (/ (* x (* 60 60 24)) 1000000)))


  (define day->kibi
    (lambda (x)
      (/ (* x (* 60 60 24)) 1024)))


  (define day->kilo
    (lambda (x)
      (/ (* x (* 60 60 24)) 1000)))


  (define day->hecto
    (lambda (x)
      (/ (* x (* 60 60 24)) 100)))


  (define day->deka
    (lambda (x)
      (/ (* x (* 60 60 24)) 10)))


  (define day->normal
    (lambda (x)
      (/ (* x (* 60 60 24)) 1)))


  (define day->deci
    (lambda (x)
      (/ (* x (* 60 60 24)) 1/10)))


  (define day->centi
    (lambda (x)
      (/ (* x (* 60 60 24)) 1/100)))


  (define day->milli
    (lambda (x)
      (/ (* x (* 60 60 24)) 1/1000)))


  (define day->micro
    (lambda (x)
      (/ (* x (* 60 60 24)) 1/1000000)))


  (define day->nano
    (lambda (x)
      (/ (* x (* 60 60 24)) 1/1000000000)))


  (define day->pico
    (lambda (x)
      (/ (* x (* 60 60 24)) 1/1000000000000)))


  (define day->minute
    (lambda (x)
      (/ (* x (* 60 60 24)) 60)))


  (define day->hour
    (lambda (x)
      (/ (* x (* 60 60 24)) (* 60 60))))


  (define day->day
    (lambda (x)
      (/ (* x (* 60 60 24)) (* 60 60 24))))


  (define day->week
    (lambda (x)
      (/ (* x (* 60 60 24)) (* 60 60 24 7))))


  (define week->pebi
    (lambda (x)
      (/ (* x (* 60 60 24 7)) (* 1024 1024 1024 1024))))


  (define week->peta
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 1000000000000)))


  (define week->gibi
    (lambda (x)
      (/ (* x (* 60 60 24 7)) (* 1024 1024 1024))))


  (define week->giga
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 1000000000)))


  (define week->mebi
    (lambda (x)
      (/ (* x (* 60 60 24 7)) (* 1024 1024))))


  (define week->mega
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 1000000)))


  (define week->kibi
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 1024)))


  (define week->kilo
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 1000)))


  (define week->hecto
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 100)))


  (define week->deka
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 10)))


  (define week->normal
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 1)))


  (define week->deci
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 1/10)))


  (define week->centi
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 1/100)))


  (define week->milli
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 1/1000)))


  (define week->micro
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 1/1000000)))


  (define week->nano
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 1/1000000000)))


  (define week->pico
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 1/1000000000000)))


  (define week->minute
    (lambda (x)
      (/ (* x (* 60 60 24 7)) 60)))


  (define week->hour
    (lambda (x)
      (/ (* x (* 60 60 24 7)) (* 60 60))))


  (define week->day
    (lambda (x)
      (/ (* x (* 60 60 24 7)) (* 60 60 24))))


  (define week->week
    (lambda (x)
      (/ (* x (* 60 60 24 7)) (* 60 60 24 7))))


  (values
   pebi->pebi
   pebi->peta
   pebi->gibi
   pebi->giga
   pebi->mebi
   pebi->mega
   pebi->kibi
   pebi->kilo
   pebi->hecto
   pebi->deka
   pebi->normal
   pebi->deci
   pebi->centi
   pebi->milli
   pebi->micro
   pebi->nano
   pebi->pico
   pebi->minute
   pebi->hour
   pebi->day
   pebi->week
   peta->pebi
   peta->peta
   peta->gibi
   peta->giga
   peta->mebi
   peta->mega
   peta->kibi
   peta->kilo
   peta->hecto
   peta->deka
   peta->normal
   peta->deci
   peta->centi
   peta->milli
   peta->micro
   peta->nano
   peta->pico
   peta->minute
   peta->hour
   peta->day
   peta->week
   gibi->pebi
   gibi->peta
   gibi->gibi
   gibi->giga
   gibi->mebi
   gibi->mega
   gibi->kibi
   gibi->kilo
   gibi->hecto
   gibi->deka
   gibi->normal
   gibi->deci
   gibi->centi
   gibi->milli
   gibi->micro
   gibi->nano
   gibi->pico
   gibi->minute
   gibi->hour
   gibi->day
   gibi->week
   giga->pebi
   giga->peta
   giga->gibi
   giga->giga
   giga->mebi
   giga->mega
   giga->kibi
   giga->kilo
   giga->hecto
   giga->deka
   giga->normal
   giga->deci
   giga->centi
   giga->milli
   giga->micro
   giga->nano
   giga->pico
   giga->minute
   giga->hour
   giga->day
   giga->week
   mebi->pebi
   mebi->peta
   mebi->gibi
   mebi->giga
   mebi->mebi
   mebi->mega
   mebi->kibi
   mebi->kilo
   mebi->hecto
   mebi->deka
   mebi->normal
   mebi->deci
   mebi->centi
   mebi->milli
   mebi->micro
   mebi->nano
   mebi->pico
   mebi->minute
   mebi->hour
   mebi->day
   mebi->week
   mega->pebi
   mega->peta
   mega->gibi
   mega->giga
   mega->mebi
   mega->mega
   mega->kibi
   mega->kilo
   mega->hecto
   mega->deka
   mega->normal
   mega->deci
   mega->centi
   mega->milli
   mega->micro
   mega->nano
   mega->pico
   mega->minute
   mega->hour
   mega->day
   mega->week
   kibi->pebi
   kibi->peta
   kibi->gibi
   kibi->giga
   kibi->mebi
   kibi->mega
   kibi->kibi
   kibi->kilo
   kibi->hecto
   kibi->deka
   kibi->normal
   kibi->deci
   kibi->centi
   kibi->milli
   kibi->micro
   kibi->nano
   kibi->pico
   kibi->minute
   kibi->hour
   kibi->day
   kibi->week
   kilo->pebi
   kilo->peta
   kilo->gibi
   kilo->giga
   kilo->mebi
   kilo->mega
   kilo->kibi
   kilo->kilo
   kilo->hecto
   kilo->deka
   kilo->normal
   kilo->deci
   kilo->centi
   kilo->milli
   kilo->micro
   kilo->nano
   kilo->pico
   kilo->minute
   kilo->hour
   kilo->day
   kilo->week
   hecto->pebi
   hecto->peta
   hecto->gibi
   hecto->giga
   hecto->mebi
   hecto->mega
   hecto->kibi
   hecto->kilo
   hecto->hecto
   hecto->deka
   hecto->normal
   hecto->deci
   hecto->centi
   hecto->milli
   hecto->micro
   hecto->nano
   hecto->pico
   hecto->minute
   hecto->hour
   hecto->day
   hecto->week
   deka->pebi
   deka->peta
   deka->gibi
   deka->giga
   deka->mebi
   deka->mega
   deka->kibi
   deka->kilo
   deka->hecto
   deka->deka
   deka->normal
   deka->deci
   deka->centi
   deka->milli
   deka->micro
   deka->nano
   deka->pico
   deka->minute
   deka->hour
   deka->day
   deka->week
   normal->pebi
   normal->peta
   normal->gibi
   normal->giga
   normal->mebi
   normal->mega
   normal->kibi
   normal->kilo
   normal->hecto
   normal->deka
   normal->normal
   normal->deci
   normal->centi
   normal->milli
   normal->micro
   normal->nano
   normal->pico
   normal->minute
   normal->hour
   normal->day
   normal->week
   deci->pebi
   deci->peta
   deci->gibi
   deci->giga
   deci->mebi
   deci->mega
   deci->kibi
   deci->kilo
   deci->hecto
   deci->deka
   deci->normal
   deci->deci
   deci->centi
   deci->milli
   deci->micro
   deci->nano
   deci->pico
   deci->minute
   deci->hour
   deci->day
   deci->week
   centi->pebi
   centi->peta
   centi->gibi
   centi->giga
   centi->mebi
   centi->mega
   centi->kibi
   centi->kilo
   centi->hecto
   centi->deka
   centi->normal
   centi->deci
   centi->centi
   centi->milli
   centi->micro
   centi->nano
   centi->pico
   centi->minute
   centi->hour
   centi->day
   centi->week
   milli->pebi
   milli->peta
   milli->gibi
   milli->giga
   milli->mebi
   milli->mega
   milli->kibi
   milli->kilo
   milli->hecto
   milli->deka
   milli->normal
   milli->deci
   milli->centi
   milli->milli
   milli->micro
   milli->nano
   milli->pico
   milli->minute
   milli->hour
   milli->day
   milli->week
   micro->pebi
   micro->peta
   micro->gibi
   micro->giga
   micro->mebi
   micro->mega
   micro->kibi
   micro->kilo
   micro->hecto
   micro->deka
   micro->normal
   micro->deci
   micro->centi
   micro->milli
   micro->micro
   micro->nano
   micro->pico
   micro->minute
   micro->hour
   micro->day
   micro->week
   nano->pebi
   nano->peta
   nano->gibi
   nano->giga
   nano->mebi
   nano->mega
   nano->kibi
   nano->kilo
   nano->hecto
   nano->deka
   nano->normal
   nano->deci
   nano->centi
   nano->milli
   nano->micro
   nano->nano
   nano->pico
   nano->minute
   nano->hour
   nano->day
   nano->week
   pico->pebi
   pico->peta
   pico->gibi
   pico->giga
   pico->mebi
   pico->mega
   pico->kibi
   pico->kilo
   pico->hecto
   pico->deka
   pico->normal
   pico->deci
   pico->centi
   pico->milli
   pico->micro
   pico->nano
   pico->pico
   pico->minute
   pico->hour
   pico->day
   pico->week
   minute->pebi
   minute->peta
   minute->gibi
   minute->giga
   minute->mebi
   minute->mega
   minute->kibi
   minute->kilo
   minute->hecto
   minute->deka
   minute->normal
   minute->deci
   minute->centi
   minute->milli
   minute->micro
   minute->nano
   minute->pico
   minute->minute
   minute->hour
   minute->day
   minute->week
   hour->pebi
   hour->peta
   hour->gibi
   hour->giga
   hour->mebi
   hour->mega
   hour->kibi
   hour->kilo
   hour->hecto
   hour->deka
   hour->normal
   hour->deci
   hour->centi
   hour->milli
   hour->micro
   hour->nano
   hour->pico
   hour->minute
   hour->hour
   hour->day
   hour->week
   day->pebi
   day->peta
   day->gibi
   day->giga
   day->mebi
   day->mega
   day->kibi
   day->kilo
   day->hecto
   day->deka
   day->normal
   day->deci
   day->centi
   day->milli
   day->micro
   day->nano
   day->pico
   day->minute
   day->hour
   day->day
   day->week
   week->pebi
   week->peta
   week->gibi
   week->giga
   week->mebi
   week->mega
   week->kibi
   week->kilo
   week->hecto
   week->deka
   week->normal
   week->deci
   week->centi
   week->milli
   week->micro
   week->nano
   week->pico
   week->minute
   week->hour
   week->day
   week->week
   )))
