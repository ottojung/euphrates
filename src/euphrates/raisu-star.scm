;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-syntax raisu*
  (syntax-rules (:from :type :message :args)
    ((_ :from from :type type :message message :args args)
     (generic-error
      (append
       (if from
           (list (cons generic-error:from-key from))
           '())
       (list
        (cons generic-error:type-key type)
        (cons generic-error:message-key message)
        (cons generic-error:irritants-key args)))))
    ((_ :type type :message message :args args)
     (raisu* :from #f
             :type type
             :message message
             :args args))))
