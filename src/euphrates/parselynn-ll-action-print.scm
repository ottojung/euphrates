;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define parselynn:ll-action:print
  (case-lambda
   ((action)
    (parselynn:ll-action:print action (current-output-port)))

   ((action port)
    (cond
     ((parselynn:ll-match-action? action)
      (fprintf
       port
       "~s"
       (parselynn:ll-match-action:symbol action)))

     ((parselynn:ll-predict-action? action)
      (fprintf
       port
       "~s"
       (parselynn:ll-predict-action:nonterminal action)))

     ((parselynn:ll-choose-action? action)
      (let ()
        (define production
          (parselynn:ll-choose-action:production action))
        (fprintf port
                 "~s← ~a"
                 (bnf-alist:production:lhs production)
                 (words->string
                  (map ~s (bnf-alist:production:rhs production))))))

     ((parselynn:ll-accept-action? action)
      (display "ACC" port))

     ((parselynn:ll-reject-action? action)
      (display "" port))

     (else
      (raisu* :from "parselynn:ll-action:print"
              :type 'unknown-action-64618726387
              :message (stringf "Unknown action ~s." action)
              :args (list action)))))))
