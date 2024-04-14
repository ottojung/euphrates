;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(cond-expand
 (guile

  (define (open-file-port path mode)
    (if (member mode '("r" "w" "a" "rb" "wb" "ab"))
        (open-file path mode)
        (raisu 'open-file-mode-not-supported `(args: ,path ,mode))))

  )

 (racket

  (define (open-file-port path mode)
    (match mode
       ["r" (open-input-file path #:mode 'text)]
       ["w" (open-output-file path #:mode 'text #:exists 'truncate/replace)]
       ["a" (open-output-file path #:mode 'text #:exists 'append)]
       ["rb" (open-input-file path #:mode 'binary)]
       ["wb" (open-output-file path #:mode 'binary #:exists 'truncate/replace)]
       ["ab" (open-output-file path #:mode 'binary #:exists 'append)]
       [other (raisu 'open-file-mode-not-supported `(args: ,path ,mode))]))

  ))
