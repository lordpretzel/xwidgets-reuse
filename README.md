[![License: GPL 3](https://img.shields.io/badge/license-GPL_3-green.svg)](http://www.gnu.org/licenses/gpl-3.0.txt)
<!-- [![GitHub release](https://img.shields.io/github/release/lordpretzel/xwidgets-reuse.svg?maxAge=86400)](https://github.com/lordpretzel/xwidgets-reuse/releases) -->
<!-- [![MELPA Stable](http://stable.melpa.org/packages/xwidgets-reuse-badge.svg)](http://stable.melpa.org/#/xwidgets-reuse) -->
<!-- [![MELPA](http://melpa.org/packages/xwidgets-reuse-badge.svg)](http://melpa.org/#/xwidgets-reuse) -->
[![Build Status](https://secure.travis-ci.org/lordpretzel/xwidgets-reuse.png)](http://travis-ci.org/lordpretzel/xwidgets-reuse)


# xwidgets-reuse

Enables convenient reuse of xwidgets sessions for multiple purposes (less resource consumption). Since we may want multiple key bindings deepening on the purpose, e.g., viewing articles in `elfeed`, the package maintains a list of minor modes that will be deactivated when a session is reused for a different purpose.

## Usage

- call `xwidgets-reuse/xwidget-reuse-browse-url(URL &optional use-minor-mode)` to browse a `URL` in xwidgets reusing an existing session if it exists. If `use-minor-mode` is given, it should be a minor mode that is activated in the xwidgets buffer (presumably binding keys for the specific purpose).
- `xwidgets-reuse/register-minor-mode(minor-mode)` - Registers minor mode `minor-mode` with `xwidgets-reuse`.  This minor mode will automatically be turned off when another minor mode from `xwidgets-reuse--xwidgets-specialization-minor-modes` is used through ‘xwidgets-reuse/xwidget-reuse-browse-url’.

## Installation

<!-- ### MELPA -->

<!-- Symbol’s value as variable is void: $1 is available from MELPA (both -->
<!-- [stable](http://stable.melpa.org/#/xwidgets-reuse) and -->
<!-- [unstable](http://melpa.org/#/xwidgets-reuse)).  Assuming your -->
<!-- ((melpa . https://melpa.org/packages/) (gnu . http://elpa.gnu.org/packages/) (org . http://orgmode.org/elpa/)) lists MELPA, just type -->

<!-- ~~~sh -->
<!-- M-x package-install RET xwidgets-reuse RET -->
<!-- ~~~ -->

<!-- to install it. -->

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
