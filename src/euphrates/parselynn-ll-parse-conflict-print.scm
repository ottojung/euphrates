;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define parselynn:ll-parse-conflict:print
  (case-lambda
   ((conflict)
    (parselynn:ll-parse-conflict:print conflict (current-output-port)))
   ((conflict port)
    (cond
     ((parselynn:ll-parse-first-first-conflict? conflict)
      (let ()
        (define candidate
          (parselynn:ll-parse-first-first-conflict:candidate conflict))
        (define productions
          (parselynn:ll-parse-first-first-conflict:productions conflict))

        (define show-production
          (compose ~s (compose-under with-output-stringified bnf-alist:production:print)))
        (define initial-productions
          (list-init productions))
        (define last-production
          (list-last productions))
        (define printed-productions
          (apply
           string-append
           (append
            (list-intersperse
             ", " (map show-production initial-productions))
            (list " and "
                  (show-production last-production)))))

        (fprintf
         port
         "Conflict between productions ~a. All of them derive token ~s first."
         printed-productions (~a candidate))))

     ((parselynn:ll-parse-recursion-conflict? conflict)
      (raisu* :from "parselynn:ll-parse-conflict:print"
              :type 'TODO
              :message "TODO"
              :args (list conflict)))

     (else
      (raisu* :from "parselynn:ll-parse-conflict:print"
              :type 'unknown-type-6481764387126
              :message (stringf "Unknown type of conflict in ~s." conflict)
              :args (list conflict)))))))
