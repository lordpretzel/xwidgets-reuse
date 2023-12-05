;;; xwidgets-reuse.el --- Reuse xwidgets sessions to reduce resource consumption -*- lexical-binding: t -*-

;; Author: Boris Glavic <lordpretzel@gmail.com>
;; Maintainer: Boris Glavic <lordpretzel@gmail.com>
;; Version: 0.2
;; Package-Requires: ((emacs "26.1"))
;; Homepage: https://github.com/lordpretzel/xwidgets-reuse
;; Keywords: hypermedia


;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.


;;; Commentary:

;; Xwidget sessions are relatively heavy-weight.  This packages allows a single
;; xwidgets session to be reused for browsing.  This can be useful for tasks
;; like viewing html email in xwidgets or elfeed feeds or dash documentation.  To
;; customize behavior, you can register minor modes with `xwidgets-reuse' that
;; bind custom keys.  Call `xwidgets-reuse-register-minor-mode' to register your
;; minor mode.  Use `xwidgets-reuse-xwidget-reuse-browse-url(url &optional
;; use-minor-mode)' to browse `url' reusing an xwidget session.  This turns off
;; all minor modes registered with `xwidgets-reuse' in the reused xwidgets
;; session.  If `use-minor-mode' is provided, then this minor mode is turned on
;; in the xwidgets session.

;;; Code:

(require 'seq)
(require 'xwidget)
(require 'cl-macs)

;; ********************************************************************************
;; customizations and defvars
(defcustom xwidgets-reuse-xwidgets-default-specialization-minor-modes
  nil
  "Minor modes applied to specialize xwidgets buffers for a purpose.
For example, such a purpose could be reading html email with mu4e.  Since we are
reusing a single xwidgets buffer, these minor modes need to be turned on / off
when reusing the buffer for a different purpose."
  :group 'xwidgets-reuse
  :type '(list symbol))

(defvar xwidgets-reuse--xwidgets-specialization-minor-modes
  xwidgets-reuse-xwidgets-default-specialization-minor-modes
  "Current list of specialization minor modes.
Allows for runtime registration of new modes.")

(defvar xwidgets-reuse-named-sessions
  nil
  "Alist storing xwidgets sessions that have been assigned names.

Such sessions can be reused using `xwidget-reuse-named-session-...' functions.")

;; ********************************************************************************
;; functions
(defun xwidgets-reuse-turn-off-all-xwidgets-specialization-minor-modes ()
  "Turn of all specialization minor modes for xwidgets."
  (with-current-buffer (current-buffer)
    (when (memq major-mode '(xwidget-webkit-mode))
      (dolist (mmode xwidgets-reuse--xwidgets-specialization-minor-modes)
        (funcall mmode -1)))))

;;;###autoload
(defun xwidgets-reuse-register-minor-mode (minor-mode)
  "Registers a MINOR-MODE with xwidgets-reuse.
This minor mode will automatically be turned off when another minor mode from
`xwidgets-reuse--xwidgets-specialization-minor-modes' is used through
`xwidgets-reuse-xwidget-reuse-browse-url'."
  (if (boundp minor-mode)
      (add-to-list 'xwidgets-reuse--xwidgets-specialization-minor-modes minor-mode)
    (error "`MINOR-MODE' needs to be a function corresponding to a minor mode")))

;;;###autoload
(defun xwidgets-reuse-xwidget-reuse-browse-url (url &optional use-minor-mode)
  "Open URL using xwidgets, reusing an existing xwidget buffer if possible.
Optional argument USE-MINOR-MODE is a minor mode to be activated
in the xwidgets session (e.g., for custom keybindings)."
  (interactive "sURL to browse in xwidgets: ")
  (let ((buf (car (seq-filter (lambda (x) (string-match "*xwidget webkit:" (buffer-name x))) (buffer-list)))))
    (if buf
        (progn (unless (eq (window-buffer) buf)
                 (switch-to-buffer buf))
               (xwidget-webkit-goto-url url))
      (xwidget-webkit-browse-url url))
    (xwidgets-reuse-turn-off-all-xwidgets-specialization-minor-modes)
    (when use-minor-mode
      (funcall use-minor-mode 1))))

(defun xwidgets-reuse-kill-all-sessions (&optional sessionnames)
  "Kill all named xwidgets sessions handeled by xwidgets-reuse."
  (interactive)
  (mapc #'xwidgets-reuse-named-session-close
      (mapcar 'car (or sessionnames xwidgets-reuse-named-sessions))))

(defun xwidets-reuse-xwidget-from-buffer (buf)
  "Return xwidget session associated with buffer BUF."
    (if (buffer-live-p buf)
      (with-current-buffer xwidget-webkit-last-session-buffer
        (xwidget-at (point-min)))
    nil))

;;;###autoload
(cl-defun xwidgets-reuse-named-session-browse-url (sessionname &key url switch-to-session reload no-hide use-minor-mode window focus-window)
  "Browse URL in xwidget session SESSIONNAME.

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
non-nil, then show the xwidget session in this window."
  (interactive "sSessionName: \nsURL to browse in xwidgets: ")
  (let ((session (alist-get sessionname xwidgets-reuse-named-sessions nil nil 'string-equal))
        (curwin (selected-window))
        previous-session)
    (unless session
      (setq session (xwidget-webkit--create-new-session-buffer url))
      (add-to-list 'xwidgets-reuse-named-sessions (cons sessionname session)))

    (setq previous-session xwidget-webkit-last-session-buffer)
    (with-current-buffer session
      (setq xwidget-webkit-last-session-buffer session)
      (when (and url (or reload (not (string-equal url (xwidget-webkit-uri (xwidget-webkit-current-session))))))
        (xwidget-webkit-goto-uri (xwidets-reuse-xwidget-from-buffer session) url))
      (when use-minor-mode
        (funcall use-minor-mode 1)))
    ;; if we switch to session, then use this as last session, otherwise hide our session use from xwidget. Optionally show in user provided window.
    (when switch-to-session
      (when window
        (select-window window))
      (switch-to-buffer (xwidget-buffer (xwidget-webkit-current-session)))
      (when (and window (not focus-window))
        (select-window curwin)))
    (when (and switch-to-session no-hide)
      (setq xwidget-webkit-last-session-buffer previous-session))))

(cl-defun xwidget-reuse-named-session-switch-to (sessionname &key hide)
  "Switch to named xwidget session SESSIONNAME.

If HIDE is non-nil then hide this session from xwidgets."
  (interactive "sSession name:")
  (let ((session (alist-get sessionname xwidgets-reuse-named-sessions nil nil 'string-equal))
        (previous-session xwidget-webkit-last-session-buffer))
    (when session
      (switch-to-buffer session)
      (if hide
          (setq xwidget-webkit-last-session-buffer previous-session)
        (with-current-buffer session
          (setq xwidget-webkit-last-session-buffer session))))))

;;;###autoload
(defun xwidgets-reuse-named-session-close (sessionname)
  "Close a named xwidget session SESSIONNAME."
  (interactive "sClose ssession: ")  
  (let ((session (alist-get sessionname xwidgets-reuse-named-sessions nil nil 'string-equal)))
    (when session
      (kill-buffer session)
      (setq xwidgets-reuse-named-sessions (assoc-delete-all sessionname xwidgets-reuse-named-sessions)))))

;; ********************************************************************************
;; utility functions for minor modes to bind if they like to

;;;###autoload
(defun xwidgets-reuse-xwidget-external-browse-current-url ()
  "Externally browse url shown in current xwidget session."
  (interactive)
  (when (memq major-mode '(xwidget-webkit-mode))
    (let* ((urlstr (xwidget-webkit-current-url)))
      (browse-url urlstr))))

(provide 'xwidgets-reuse)
;;; xwidgets-reuse.el ends here
