;;; xwidgets-reuse-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "flycheck_xwidgets-reuse" "flycheck_xwidgets-reuse.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from flycheck_xwidgets-reuse.el

(autoload 'xwidgets-reuse-register-minor-mode "flycheck_xwidgets-reuse" "\
Registers a MINOR-MODE with xwidgets-reuse.
This minor mode will automatically be turned off when another minor mode from
`xwidgets-reuse--xwidgets-specialization-minor-modes' is used through
`xwidgets-reuse-xwidget-reuse-browse-url'.

\(fn MINOR-MODE)" nil nil)

(autoload 'xwidgets-reuse-xwidget-reuse-browse-url "flycheck_xwidgets-reuse" "\
Open URL using xwidgets, reusing an existing xwidget buffer if possible.
Optional argument USE-MINOR-MODE is a minor mode to be activated
in the xwidgets session (e.g., for custom keybindings).

\(fn URL &optional USE-MINOR-MODE)" t nil)

(autoload 'xwidgets-reuse-xwidget-external-browse-current-url "flycheck_xwidgets-reuse" "\
Externally browse url shown in current xwidget session." t nil)

(register-definition-prefixes "flycheck_xwidgets-reuse" '("xwidgets-reuse-"))

;;;***

;;;### (autoloads nil "xwidgets-reuse" "xwidgets-reuse.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from xwidgets-reuse.el

(autoload 'xwidgets-reuse-register-minor-mode "xwidgets-reuse" "\
Registers a `MINOR-MODE' with xwidgets-reuse.  This minor mode will automatically be turned off when another minor mode from `xwidgets-reuse--xwidgets-specialization-minor-modes' is used through `xwidgets-reuse-xwidget-reuse-browse-url'.

\(fn MINOR-MODE)" nil nil)

(autoload 'xwidgets-reuse-xwidget-reuse-browse-url "xwidgets-reuse" "\
Open `URL' using xwidgets, reusing an existing xwdiget buffer if possible.
Optional argument USE-MINOR-MODE is a minor mode to be activated in the xwidgets session (e.g., for custom keybindinds).

\(fn URL &optional USE-MINOR-MODE)" t nil)

(autoload 'xwidgets-reuse-xwidget-external-browse-current-url "xwidgets-reuse" "\
Browse url shown in current xwidget session in external browser." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "xwidgets-reuse" '("xwidgets-reuse-")))

;;;***


;;; Generated autoloads from xwidgets-reuse.el

(autoload 'xwidgets-reuse-register-minor-mode "xwidgets-reuse" "\
Registers a MINOR-MODE with xwidgets-reuse.
This minor mode will automatically be turned off when another minor mode from
`xwidgets-reuse--xwidgets-specialization-minor-modes' is used through
`xwidgets-reuse-xwidget-reuse-browse-url'.

(fn MINOR-MODE)")
(autoload 'xwidgets-reuse-xwidget-reuse-browse-url "xwidgets-reuse" "\
Open URL using xwidgets, reusing an existing xwidget buffer if possible.
Optional argument USE-MINOR-MODE is a minor mode to be activated
in the xwidgets session (e.g., for custom keybindings).

(fn URL &optional USE-MINOR-MODE)" t)
(autoload 'xwidgets-reuse-named-session-browse-url "xwidgets-reuse" "\
Browse URL in xwidget session SESSIONNAME.

If no xwidget session with this name exists, then create a new
one. If SWITCH-TO-SESSION is non-nil, then switch to this session
in the current window.

(fn SESSIONNAME URL &optional SWITCH-TO-SESSION RELOAD)" t)
(autoload 'xwidgets-reuse-named-session-close "xwidgets-reuse" "\
Close a named xwidget session SESSIONNAME.

(fn SESSIONNAME)" t)
(autoload 'xwidgets-reuse-xwidget-external-browse-current-url "xwidgets-reuse" "\
Externally browse url shown in current xwidget session." t)
(register-definition-prefixes "xwidgets-reuse" '("xwid"))


;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; xwidgets-reuse-autoloads.el ends here
