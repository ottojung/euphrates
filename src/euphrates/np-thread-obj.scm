;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define-type9 <np-thread-obj>
  (np-thread-obj continuation cancel-scheduled? cancel-enabled?) np-thread-obj?
  (continuation np-thread-obj-continuation set-np-thread-obj-continuation!)
  (cancel-scheduled? np-thread-obj-cancel-scheduled? set-np-thread-obj-cancel-scheduled?!)
  (cancel-enabled? np-thread-obj-cancel-enabled? set-np-thread-obj-cancel-enabled?!)
  )
