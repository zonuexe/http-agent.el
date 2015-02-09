;;; http-agent-util-test.el --- test for http-agent util functions

;; Copyright (C) 2015 USAMI Kenta

;; Author: USAMI Kenta <tadsan@zonu.me>
;; Created: 17 Jun 2015

;;; Commentary:

;; This file is NOT part of GNU Emacs.

;;; Code:
(require 'http-agent-util)

(ert-deftest http-agent-util-test\#merge-url ()
  (let ((data
         (list
          (list
           :expected (url-generic-parse-url "http://www.pixiv.net")
           :default  ""
           :input    "http://www.pixiv.net")
          )))
    (--each data
      (should
       (equal (plist-get it :expected)
              (http-agent-util:merge-url (plist-get it :input)
                                         (plist-get it :default)))))))

;;; http-agent-util-test.el ends here
