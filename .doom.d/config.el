;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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

(use-package typescript-ts-mode
  :mode (("\\.ts\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode))
  :config
  (add-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook) #'lsp!))


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
      "g e" #'flycheck-next-error)

(map! :leader
      :desc "Consult flycheck"
      "s e" #'consult-flycheck)

(map! :n (kbd "C-e") #'consult-recent-file)

(map! :n (kbd "M-RET") #'lsp-execute-code-action)

(after! evil
  ;; Remove old bindings first (works even if they exist elsewhere in normal state)
  (map! :n "C-j" nil
        :n "C-k" nil)

  ;; Bind your commands (literal keys, no [remap …])
  (map! :n "C-j" #'goto-last-change
        :n "C-k" #'goto-last-change-reverse))

(map! :n (kbd "C-/") #'comment-dwim)
(map! :v (kbd "C-/") #'comment-dwim)


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


(use-package! kind-icon
  :after corfu
  :custom (kind-icon-default-face 'corfu-default)
  :config (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))


;; Fonts
;; (setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 14 :weight 'semi-bold)
;;      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font Propo" :size 15)
;;       doom-big-font (font-spec :family "FiraCode Nerd Font Mono" :size 24))

(setq doom-font (font-spec :family "Hack Nerd Font Mono" :size 16 :weight 'regular)
     doom-variable-pitch-font (font-spec :family "Hack Nerd Font Propo" :size 18)
      doom-big-font (font-spec :family "Hack Nerd Font Mono" :size 26))
