[![License: GPL 3](https://img.shields.io/badge/license-GPL_3-green.svg)](http://www.gnu.org/licenses/gpl-3.0.txt) [![Build Status](https://secure.travis-ci.org/lordpretzel/xwidgets-reuse.png)](http://travis-ci.org/lordpretzel/xwidgets-reuse)
[![MELPA Stable](http://stable.melpa.org/packages/xwidgets-reuse-badge.svg)](http://stable.melpa.org/#/xwidgets-reuse)
[![MELPA](http://melpa.org/packages/xwidgets-reuse-badge.svg)](http://melpa.org/#/xwidgets-reuse)

# xwidgets-reuse

Enables convenient reuse of xwidgets sessions for multiple purposes (less resource consumption). Since we may want multiple key bindings deepening on the purpose, e.g., viewing articles in `elfeed`, the package maintains a list of minor modes that will be deactivated when a session is reused for a different purpose.

## Usage

- call `xwidgets-reuse-xwidget-reuse-browse-url(URL &optional use-minor-mode)` to browse a `URL` in xwidgets reusing an existing session if it exists. If `use-minor-mode` is given, it should be a minor mode that is activated in the xwidgets buffer (presumably binding keys for the specific purpose).
- `xwidgets-reuse-register-minor-mode(minor-mode)` - Registers minor mode `minor-mode` with `xwidgets-reuse`.  This minor mode will automatically be turned off when another minor mode from `xwidgets-reuse--xwidgets-specialization-minor-modes` is used through ‘xwidgets-reuse-xwidget-reuse-browse-url’.

### Example

As an example, this is how you can setup elfeed to use xwidgets to view feeds. Using the minor mode `lordpretzel-elfeed-xwidgets-mode`, pressing `q` in the xwidget window returns to the elfeed search window. Note how this minor mode is registered with `xwidget-reuse` to ensure that it will be turned off if the xwidget session is reused for a different purpose.

~~~elisp
(define-minor-mode lordpretzel-elfeed-xwidgets-mode
  "Minor mode for setting up keys when viewing elfeed entry in xwidgets."
  :init-value nil
  :lighter "elfeed-browsing"
  :keymap
  `((,(kbd "q")
     . lordpretzel/elfeed-search-window-only))
  :global nil)

;; register minor mode with xwidgets-reuse to turn it on or off
(xwidgets-reuse-register-minor-mode 'lordpretzel-elfeed-xwidgets-mode)

(defun lordpretzel/elfeed-search-window-only ()
  "Show only the search window of elfeed."
  (interactive)
  (switch-to-buffer (elfeed-search-buffer))
  (delete-other-windows)
  )

(defun lordpretzel/elfeed-open-entry-in-xwidgets
    (entry)
  (interactive
   (list
    (elfeed-search-selected :ignore-region)))
  (require 'elfeed-show)
  (when
      (elfeed-entry-p entry)
    (elfeed-untag entry 'unread)
    (elfeed-search-update-entry entry)
    (forward-line)
    (let
        ((link
          (elfeed-entry-link entry)))
      (when link
        (let
            ((window
              (selected-window))
             newwindow)
          (delete-other-windows)
          (setq newwindow
                (split-window-right))
          (select-window newwindow)
          (lordpretzel/elfeed-xwidget-reuse-browse-url link)
          (select-window window))))))

(define-key elfeed-mode-map (kbd "<RET>") lordpretzel/elfeed-open-entry-in-xwidgets)
~~~

## Installation

### MELPA

`xwidgets-webkit` is available from MELPA (both [stable](http://stable.melpa.org/#/xwidgets-reuse) and [unstable](http://melpa.org/#/xwidgets-reuse)).  Assuming your `package-archives` lists MELPA, just type

~~~sh
M-x package-install RET xwidgets-reuse RET
~~~

to install it.

### Quelpa

Using [use-package](https://github.com/jwiegley/use-package) with [quelpa](https://github.com/quelpa/quelpa).

~~~elisp
(use-package
  :quelpa ((xwidgets-reuse
    :fetcher github
    :repo "lordpretzel/xwidgets-reuse")
  :upgrade t)
)
~~~

### straight

Using [use-package](https://github.com/jwiegley/use-package) with [straight.el](https://github.com/raxod502/straight.el)

~~~elisp
(use-package xwidgets-reuse
  :straight (xwidgets-reuse :type git :host github :repo "lordpretzel/xwidgets-reuse"))
~~~

### Source

Alternatively, install from source. First, clone the source code:

~~~sh
cd MY-PATH
git clone https://github.com/lordpretzel/xwidgets-reuse.git
~~~

Now, from Emacs execute:

~~~
M-x package-install-file RET MY-PATH/xwidgets-reuse
~~~

Alternatively to the second step, add this to your Symbol’s value as variable is void: \.emacs file:

~~~elisp
(add-to-list 'load-path "MY-PATH/xwidgets-reuse")
(require 'xwidgets-reuse)
~~~
