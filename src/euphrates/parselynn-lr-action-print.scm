;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define parselynn:lr-action:print
  (case-lambda
   ((action)
    (parselynn:lr-action:print action (current-output-port)))

   ((action port)
    (cond
     ((parselynn:lr-shift-action? action)
      (fprintf
       port
       "s~s"
       (parselynn:lr-shift-action:target-id action)))

     ((parselynn:lr-reduce-action? action)
      (fprintf
       port
       "~s← ~a"
       (car (parselynn:lr-reduce-action:production action))
       (words->string
        (map ~s (cadr (parselynn:lr-reduce-action:production action))))))

     ((parselynn:lr-accept-action? action)
      (display "ACC" port))

     ((parselynn:lr-reject-action? action)
      (display "" port))

     ((parselynn:lr-goto-action? action)
      (write (parselynn:lr-goto-action:target-id action) port))

     (else
      (raisu* :from "parselynn:lr-action:print"
              :type 'unknown-action
              :message (stringf "Unknown action ~s." action)
              :args (list action)))))))
