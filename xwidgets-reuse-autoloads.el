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
in the current window. If RELOAD is non-nil, then force reloading
the URL even if it is already shown. If NO-HIDE is non-nil, then
don't hide the session from xwidgets, i.e., after switching to
the session, xwidgets considers this to be the previous session
which is required for, e.g., browsing to a new url to work.
However, the disadvantage of not hidding is that calls to
functions like `xwidget-browse-url' will target this session
which may not be what you want from a dedicated named session. If
USE-MINOR-MODE is provided then turn on this minor
mode (typically used for defining key-bindings). If WINDOW is
non-nil, then show the xwidget session in this window.

(fn SESSIONNAME &key URL SWITCH-TO-SESSION RELOAD NO-HIDE USE-MINOR-MODE WINDOW FOCUS-WINDOW)" t)
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
