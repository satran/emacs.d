;; Setting the default load-directory
(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))

(setenv "GOROOT" "/usr/local/go")
(setenv "PATH" (concat (getenv "PATH") ":" (expand-file-name "~/bin")))
(setenv "PATH" (concat (getenv "PATH") ":" "/usr/local/go/bin"))
(setenv "GOPATH"(getenv "HOME"))

(setq exec-path (append exec-path '("/usr/local/go/bin" "/Users/satran/bin")))

;; Adding custom theme directory
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/solarized-theme-20150122.15")
;;(add-to-list 'custom-theme-load-path "~/src/github.com//emacs-color-theme-solarized")

;; Setting line numbers to all files
;;(global-linum-mode 1)

;; Setting column number
(column-number-mode 1)

;; Offset the number by two spaces to work around some weird fringe 
(setq linum-format "%3d ")

;; Disable splash screen
(setq inhibit-startup-message t)

;; Set C style to k&r
(setq c-default-style "linux")

;; Set the cursor to a bar
(setq default-cursor-type 'bar)

;; Disable the menubar for terminal
(menu-bar-mode -1)

;; Globally disable syntax highlight
(global-font-lock-mode 0)

;; Move across split windows using the shit+arrow keys
(windmove-default-keybindings)

;; GUI specific settings
;; Load the customizations after an emacsclient startsup.
(defun disable-crappy-frames (&optional frame)
  "Disables scrollbars, toolbars and fringe while in graphical mode."
  (when (or window-system frame)
    ;; Setting the color scheme.
    ;; (load-theme 'oceanic t)
    (load-theme 'acme t)

    ;; Highlighting current line
    (global-hl-line-mode 1)

    (set-face-italic-p 'italic nil)

    ;; Disabling the fringe
    ;;(set-fringe-mode '(0 . 0))
    ;;'(fringe-mode (quote (1 . 1)) nil (fringe))
    ;; Disable the scrollbar
    (scroll-bar-mode -1)

    ;; check if we're on OSX to set the font
    (when (featurep 'ns-win)
      (custom-set-faces
       '(default ((t (:height 120 :width normal :family "Menlo"))))))
    ;; Setting the default font
    ;; (set-default-font "Meslo-12")
    (set-face-attribute 'default nil :font "Meslo LG M 14")

    ;; Disable the toolbar
    (tool-bar-mode -1)))
(disable-crappy-frames)

;; Disabling bold fonts
(set-face-bold-p 'bold nil)

;; Automatically indent code after RET
(electric-indent-mode +1)

;; Have those awesome matching pairs
(electric-pair-mode t)

;; Setting up Marmalade and gny and melpa
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;; Width and Height
(add-to-list 'default-frame-alist '(height . 80))
(add-to-list 'default-frame-alist '(width . 100)) 

;; On enter new line and indent
(defun set-newline-and-indent ()
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'c-mode 'set-newline-and-indent)

;; CMake mode
(autoload 'cmake-mode "cmake-mode" "Loads mode for CMake files." t)
(add-to-list 'auto-mode-alist '("\\CMakeLists.txt\\'" . cmake-mode))

;; Disable the gaudy colors in shell
(setq ansi-color-names-vector		; better contrast colors
      ["black" "red4" "chartreuse4" "goldenrod3"
       "DodgerBlue4" "magenta4" "cyan4" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Tramp settings
(setq tramp-default-method "ssh")
(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))

(setq recentf-auto-cleanup 'never) 

(require 'git)

;; IDO mode.
(require 'ido)
(ido-mode t)
(ido-vertical-mode 1)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

					; Settings for enforcing to use UNIX endlines
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-default default-buffer-file-coding-system 'utf-8-unix)

;; Set such that emacs does not use the ugly word-wrapping
(global-visual-line-mode 1)

;; Keybinding to start the shell
(global-set-key (kbd "C-z") 'eshell)
(global-set-key (kbd "C-S-z") 'ansi-term)
(setq Eshell-directory-name "/home/satran/.emacs.d/eshell")
(setq eshell-prompt-function (lambda () (concat "% ")))
(setq eshell-prompt-regexp "% ")

;; Settings keybindings for Scroll line by line.
(global-set-key (kbd "C-M-g") 'scroll-up-line)
(global-set-key (kbd "C-M-y") 'scroll-down-line)

;; CTags settings
(setq path-to-ctags "/usr/bin/etags")
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (let ((full-dir-name (directory-file-name dir-name)))
    (shell-command
     (format "find %s -iname \"*.[c,h]\" | xargs %s -f %s/TAGS -R"
	     full-dir-name path-to-ctags full-dir-name))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(ecb-options-version "2.40")
 '(erc-hide-list (quote ("JOIN" "KICK" "MODE")))
 '(erc-notice-highlight-type (quote prefix))
 '(erc-prompt ">")
 '(global-font-lock-mode nil)
 '(gnus-visible-headers (quote ("^From:" "^Subject:" "^Date:" "^To:" "^[BGF]?Cc:")))
 '(ruler-mode-current-column-char 42)
 '(ruler-mode-fill-column-char 124)
 '(speedbar-directory-button-trim-method (quote trim))
 '(speedbar-frame-parameters
   (quote
    ((minibuffer)
     (width . 40)
     (border-width . 0)
     (menu-bar-lines . 0)
     (tool-bar-lines . 0)
     (unsplittable . t)
     (left-fringe . 0))))
 '(speedbar-hide-button-brackets-flag t)
 '(speedbar-show-unknown-files t)
 '(speedbar-tag-face ((t (:foreground "gray80"))))
 '(speedbar-use-images nil)
 '(sr-speedbar-right-side nil))

(setq gdb-many-windows t)

;; My Shortcuts
(global-set-key (kbd "C-S-f") 'speedbar-get-focus)

;; Shortcut for compiling
(global-set-key [(f9)] 'compile)

;; Javascript mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(require 'fill-column-indicator)
(setq-default fci-rule-column 80)
(setq-default fci-rule-color "#555555")

;; Eldoc mode for C
(setq c-eldoc-includes "`pkg-config glib-2.0 tokyocabinet --cflags` -I./ -I../ ")
(load "c-eldoc")
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)


;; A few of my own customizations
;; Disable all extras of GUI.
(add-hook 'server-visit-hook 'disable-crappy-frames)
(add-hook 'after-make-frame-functions 'disable-crappy-frames)

;; Jumping windows
(global-set-key "\C-x\C-n" 'other-window)
(defun other-window-backward(&optional n)
  "Select the Nth previous window."
  (interactive "P")
  (other-window (prefix-numeric-value n)))
(global-set-key "\C-x\C-p" 'other-window-backward)


;; Move past a given character, like vims f
(defun move-past-next-char (x)
  "Move the next occurrence of the character x"
  (interactive "k")
  (progn
    (search-forward x)))
(global-set-key "\C-\M-f" 'move-past-next-char)



;; A few key bindings that I would want to remember
;; C-x r <SPC> <char-for-register> - Mark a register
;; C-x r j <char-for-register> - Jump to a register
;; C-u C-<SPC> jump to the previous mark in the buffer

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

;; Full screen in Linux
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth))
  (progn
    (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))  ;; no toolbar
    (menu-bar-mode -1) ;;no menubar
    (scroll-bar-mode -1) ;; no scroll bar
    ))

(global-set-key [f11] 'fullscreen)

;; Go lang setup
;; Install go-mode, go-eldoc
;; Go modules required
;;     go get code.google.com/p/rog-go/exp/cmd/godef
;;     go get -u github.com/nsf/gocode
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c i") 'go-goto-imports)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "M-.") 'godef-jump)))
(add-hook 'go-mode-hook 'go-eldoc-setup)

(setq linum-disabled-modes-list
      '(eshell-mode term-mode wl-summary-mode compilation-mode eww-mode erc-mode
		    mu4e-about-mode mu4e-compose-mode mu4e-headers-mode
		    mu4e-main-mode mu4e-view-mode mu4e~main-toggle-mail-sending-mode))
(defun linum-on ()
  (unless (or (minibufferp)
	      (member major-mode linum-disabled-modes-list)) (linum-mode 1)))

(setq gnus-summary-line-format "%I- %s [%a|%d]\n")

(mapc
 (lambda (face)
   (set-face-attribute face nil :weight 'normal :underline nil))
 (face-list))

(display-time-mode t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(erc-default-face ((t (:foreground "light gray"))))
 '(erc-input-face ((t (:foreground "dark gray"))))
 '(erc-nick-default-face ((t (:foreground "gray" :weight normal))))
 '(erc-notice-face ((t (:foreground "dim gray"))))
 '(erc-timestamp-face ((t (:foreground "dim gray"))))
 '(magit-item-highlight ((t nil))))
