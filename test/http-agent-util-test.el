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
           :input    (url-generic-parse-url "http://www.pixiv.net"))
          (list
           :expected (url-generic-parse-url "http://www.pixiv.net")
           :default  ""
           :input    "http://www.pixiv.net")
          (list
           :expected (url-generic-parse-url "http://www.pixiv.net:80/")
           :default  "http://www.pixiv.net"
           :input    "")
          (list
           :expected (url-generic-parse-url "http://www.pixiv.net:80/mypage.php?foo=bar#id=105589")
           :default  "http://www.pixiv.net"
           :input    "/mypage.php?foo=bar#id=105589")
          (list
           :expected (url-generic-parse-url "https://www.secure.pixiv.net/login.php#id=105589")
           :default  (url-parse-make-urlobj  nil    nil nil "www.pixiv.net" nil "/mypage.php?foo=bar" "id=105589" nil t)
           :input    (url-parse-make-urlobj "https" nil nil "www.secure.pixiv.net" nil "/login.php" "id=105589" nil t))
          )))
    (--each data
      (should
       (equal (plist-get it :expected)
              (http-agent-util:merge-url (plist-get it :input)
                                         (plist-get it :default)))))))

(ert-deftest http-agent-util-test\#make-query ()
  (let ((data
         (list
          (list
           "empty"
           :expected nil
           :src      '())
          (list
           "2-elm"
           :expected "a=b&c=d"
           :src      '(("a" . "b") ("c" . "d")))
          (list "Japanese"
           :expected "%E3%81%BB%E3%81%92=%E3%81%B5%E3%81%8C"
           :src      '(("ほげ" . "ふが")))
          (list "has &"
           :expected "org=B%26G"
           :src      '(("org" . "B&G"))))))
    (--each data
      (should (string=
               (plist-get (cdr it) :expected)
               (http-agent-util:make-query (plist-get (cdr it) :src)))))))

(ert-deftest http-agent-util-test\#parse-header-line ()
  (let ((data
         (list
          (list
           :expected '("Header" . "Foo")
           :src      "Header: Foo")
          (list
           :expected '("Header" . "Foo")
           :src      "Header : Foo")
          (list
           :expected '("Header" . "Foo:Foo : Foo")
           :src      "Header: Foo:Foo : Foo")
          )))
    (--each data
      (should (equal
               (plist-get it :expected)
               (http-agent-util:parse-header-line (plist-get it :src)))))))

;;; http-agent-util-test.el ends here
