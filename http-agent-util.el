;;; http-agent-util.el --- Utility functions for HTTP Agent

;; Copyright (C) 2015 USAMI Kenta

;; Author: USAMI Kenta <tadsan@zonu.me>
;; Created: 10 Jun 2015
;; Version: 0.0.1
;; Keywords: http client rest
;; Package-Requires: ((dash "2.9.0") (s "1.9.0"))

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'url-expand)

(defun http-agent-util:force-url (url)
  "Return url-obj."
  (if (url-p url)
      url
    (url-generic-parse-url url)))

(defun http-agent-util:merge-url (url default-url)
  "Merge URL object.

URL: URL string or url-object
DEFAULT-URL: "
  (let ((url-obj (http-agent-util:force-url url))
        (def-obj (http-agent-util:force-url default-url)))
    (url-default-expander url-obj def-obj)
    url-obj))

(defun http-agent-util:make-query (query-alist)
  "Make query from `QUERY' alist."
  (when query-alist
    (mapconcat
     (lambda (x)
       (let ((key (url-hexify-string (car x)))
             (val (url-hexify-string (cdr x))))
         (concat key "=" val)))
     query-alist
     "&")))

(provide 'http-agent-util)
;;; http-agent-util.el ends here
