;;; test-helper.el

;;; Code:
(require 'ert)
(require 'cl-macs)
(require 'undercover)
(require 'noflet)

(undercover "http-agent-util.el")

;;; test-helper.el ends here
