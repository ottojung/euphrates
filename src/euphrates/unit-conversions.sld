
(define-library
  (euphrates unit-conversions)
  (export
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
    week->week/unit)
  (import
    (only (scheme base)
          *
          /
          begin
          define
          define-values
          lambda
          let
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/unit-conversions.scm")))
    (else (include "unit-conversions.scm"))))
