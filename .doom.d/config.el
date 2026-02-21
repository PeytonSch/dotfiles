;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


;; multi threaded lsp -- this should be at the top of config to work
(use-package! lsp-bridge
  :demand t
  :init
  (global-lsp-bridge-mode))

(after! lsp-bridge
  (setq lsp-bridge-python-command
        (expand-file-name "~/.venvs/lsp-bridge/Scripts/python.exe")))

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (http . t)))


(after! treesit
  (setq treesit-language-source-alist
        '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src" nil nil)
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src" nil nil))))

;; disabled for lsp-bridge
;; (use-package typescript-ts-mode
;;   :mode (("\\.ts\\'" . typescript-ts-mode)
;;          ("\\.tsx\\'" . tsx-ts-mode))
;;   :config
;;   (add-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook) #'lsp!))


;; Change which-key popup delay
(setq which-key-idle-delay 0.1)


;; hjkl navigation in org-read-date prompt (Doom/Evil)
(with-eval-after-load 'org
  (let ((m org-read-date-minibuffer-local-map))
    ;; days/weeks (same as Shift-arrows)
    (define-key m (kbd "h") (kbd "S-<left>"))
    (define-key m (kbd "l") (kbd "S-<right>"))
    (define-key m (kbd "j") (kbd "S-<down>"))
    (define-key m (kbd "k") (kbd "S-<up>"))
    ;; months/years (same as M-Shift-arrows)
    (define-key m (kbd "H") (kbd "M-S-<left>"))
    (define-key m (kbd "L") (kbd "M-S-<right>"))
    (define-key m (kbd "J") (kbd "M-S-<down>"))
    (define-key m (kbd "K") (kbd "M-S-<up>"))))



;; force consult-locate to use es.exe explicitly (windows alternative)
(after! consult
  (setq consult-locate-args "es.exe -i -p -r")  ;; case-insensitive, full paths
  )


;; Use consult jump list
(map! :leader
      :desc "Jump list (Consult + Evil)"
      "s j" #'evil-collection-consult-jump-list)

(map! :leader
      :desc "Code / File Outline"
      "s o" #'consult-outline)


(map! :leader
      :desc "next error"
      "g e" #'lsp-bridge-diagnostic-jump-next)


(map! :n (kbd "gd") #'lsp-bridge-find-def)

(map! :leader
      :desc "Consult flycheck"
      "s e" #'lsp-bridge-diagnostic-list)

(map! :n (kbd "C-e") #'consult-recent-file)

;; (map! :n (kbd "M-RET") #'lsp-execute-code-action)

(after! evil
  ;; Remove old bindings first (works even if they exist elsewhere in normal state)
  (map! :n "C-j" nil
        :n "C-k" nil)

  ;; Bind your commands (literal keys, no [remap …])
  (map! :n "C-j" #'goto-last-change
        :n "C-k" #'goto-last-change-reverse))

(map! :n (kbd "C-/") #'comment-dwim)
(map! :v (kbd "C-/") #'comment-dwim)

(map! :leader
      :desc "Outline Jump"
      "e" #'lsp-bridge-imenu)

(after! lsp-bridge
  (defun my/lsp-bridge-peek-toggle ()
    "Toggle lsp-bridge peek at point.
If peek UI is active, close it; otherwise open peek."
    (interactive)
    (if (bound-and-true-p lsp-bridge-peek-mode)
        (lsp-bridge-peek-abort)
      (lsp-bridge-peek)
    )
 )

  (map! :n "K" #'my/lsp-bridge-peek-toggle)
)

(after! lsp-bridge-peek
  ;; Swap Meta-lowercase with Meta-uppercase in peek:
  ;; M-n/M-p => list navigation (what M-N/M-P used to do)
  ;; M-N/M-P => file scrolling    (what M-n/M-p used to do)
  (define-key lsp-bridge-peek-keymap (kbd "M-n") #'lsp-bridge-peek-list-next-line)
  (define-key lsp-bridge-peek-keymap (kbd "M-p") #'lsp-bridge-peek-list-prev-line)
  (define-key lsp-bridge-peek-keymap (kbd "M-N") #'lsp-bridge-peek-file-content-next-line)
  (define-key lsp-bridge-peek-keymap (kbd "M-P") #'lsp-bridge-peek-file-content-prev-line)
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-1 functionality to find current file and open/close tree view ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun +treemacs-toggle-reveal-focus ()
  "Toggle Treemacs; when opening, reveal current file and focus Treemacs.
If current buffer is not visiting a file, just open Treemacs at the project root."
  (interactive)
  (require 'treemacs)
  (if (eq (treemacs-current-visibility) 'visible)
      (treemacs)  ; hide
    (progn
      (condition-case _err
          (if buffer-file-name
              (treemacs-find-file)
            (treemacs))
        (error (treemacs)))
      (treemacs-select-window))))

(map! :n "C-1" #'+treemacs-toggle-reveal-and-focus)


(after! treemacs
  ;; Works regardless of Evil
  (map! :map treemacs-mode-map
        :g "C-1" #'+treemacs-toggle-reveal-focus
        :n "C-1" #'+treemacs-toggle-reveal-focus)

  ;; If you have evil-treemacs integration, bind there too
  (when (boundp 'evil-treemacs-state-map)
    (map! :map evil-treemacs-state-map
          :g "C-1" #'+treemacs-toggle-reveal-focus
          :n "C-1" #'+treemacs-toggle-reveal-focus)))



(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)


;; corfu removed with lsp-bridge
;; (use-package! kind-icon
;;   :after corfu
;;   :custom (kind-icon-default-face 'corfu-default)
;;   :config (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))


;; Fonts
;; (setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 14 :weight 'semi-bold)
;;      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font Propo" :size 15)
;;       doom-big-font (font-spec :family "FiraCode Nerd Font Mono" :size 24))

(setq doom-font (font-spec :family "Hack Nerd Font Mono" :size 16 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Hack Nerd Font Propo" :size 18)
      doom-big-font (font-spec :family "Hack Nerd Font Mono" :size 26))


(after! vterm
  (setq vterm-always-compile-module t
        ;; Prefer Ninja on Windows
        vterm-module-cmake-args "-G Ninja -DUSE_SYSTEM_LIBVTERM=ON"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Replace single quotes with backticks in  selected region or on current line ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my/hl-and-replace-single-quote-region-or-line-backtick ()
  "Highlight current line and replace all single quotes (') with backticks (`).
If a region is active, operate on that region; otherwise operate on the current line only."
  (interactive "*")
  ;; Enable current-line highlighting
  (hl-line-mode 1)
  ;; Define bounds: region if active, else current line
  (let* ((beg (if (use-region-p)
                  (region-beginning)
                (line-beginning-position)))
         (end (if (use-region-p)
                  (region-end)
                (line-end-position))))
    (save-excursion
      (save-restriction
        (narrow-to-region beg end)
        (goto-char (point-min))
        (while (search-forward "'" nil t)
          (replace-match "`" nil t))))))


;; ;; debugger
;; (use-package! dap-mode
;;   :after lsp-mode
;;   :config
;;   (dap-auto-configure-mode)

;;   ;; Load JS-related adapters
;;   (require 'dap-node)
;;   (require 'dap-chrome)
;;   (require 'dap-firefox) ;; optional
;; )

;; (use-package! dap-js
;;   :after dap-mode)


;; (dap-register-debug-template
;;  "Chrome :: launch (cgsweb multi-root + webpack maps)"
;;  (list :type "chrome"
;;        :request "launch"
;;        :name "Chrome :: Attach (cgsweb)"
;;        :port 9222
;;        ;; IMPORTANT: match your real app URL/port here
;;        :url "http://localhost:4461/tmb"
;;        ;; Your workspace root (top-level cgsweb folder)
;;        :webRoot "${workspaceFolder}"
;;        ;; Map URL path prefixes to local folders served by wds
;;        :pathMappings [
;;          ;; Root served directory
;;          (:url "/"       :path "${workspaceFolder}")
;;          ;; Extra roots from your wds logs
;;          (:url "/dev"    :path "${workspaceFolder}/dev")
;;          (:url "/assets" :path "${workspaceFolder}/assets")
;;        ]
;;        ;; Map webpack source URLs to local filesystem
;;        :sourceMapPathOverrides #s(hash-table
;;          data (
;;            ;; Your specific scheme: webpack://cgsweb/src/* → ${workspaceFolder}/src/*
;;            "webpack://cgsweb/src/*"          "${workspaceFolder}/src/*"

;;            ;; Common webpack variants seen across setups
;;            "webpack:///./src/*"              "${workspaceFolder}/src/*"
;;            "webpack:///src/*"                "${workspaceFolder}/src/*"
;;            "webpack:///./*"                  "${workspaceFolder}/*"
;;            "webpack:///*"                    "${workspaceFolder}/*"

;;            ;; Fallbacks for file:// style URIs
;;            "file:///*"                       "/*"
;;          ))))


;; garbage collection package
(use-package! gcmh
  :init
  ;; Aggressive settings (tune if memory pressure / big repos cause spikes)
  (setq gcmh-high-cons-threshold (* 512 1024 1024) ; 512MB
        gcmh-idle-delay 2.0)
  (gcmh-mode 1))


;; Show all symbols in one flat list instead of nested menus
(setq imenu-flatten 'prefix)     ;; alternatives: 'annotation or 'group
;; Optional: make the prefix formatting nicer
(setq imenu-level-separator " › ")
