;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require-package 'evil)
(require-package 'evil-surround)
(require-package 'evil-matchit)
(require-package 'evil-leader)
(require-package 'evil-nerd-commenter)
(require-package 'evil-org)

;; @see https://bitbucket.org/lyro/evil/issue/360/possible-evil-search-symbol-forward
;; evil 1.0.8 search word instead of symbol
(setq evil-symbol-word-search t)
;; load undo-tree and ert
;(add-to-list 'load-path "~/.emacs.d/site-lisp/evil/lib")
(require 'ert)
(require 'undo-tree)
(require 'evil)
(evil-mode 1)

;; {{@see https://github.com/timcharper/evil-surround
(require 'evil-surround)
(global-evil-surround-mode 1)
(evil-define-key 'visual evil-surround-mode-map "s" 'evil-substitute)
;; }}

;; {{ evil-matchit
(require 'evil-matchit)
(global-evil-matchit-mode 1)
;; }}

(eval-after-load "evil" '(setq expand-region-contract-fast-key "z"))

;; {{ evil-leader config
(setq evil-leader/leader ",")
(require 'evil-leader)
;; }}

;; {{ evil-nerd-commenter
;; comment/uncomment lines
(require 'evil-nerd-commenter)
(evilnc-default-hotkeys)
;; }}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/site-list/eim")

;; EIM Input Method. Use C-\ to toggle input method.
(autoload 'eim-use-package "eim" "Another emacs input method")
(setq eim-use-tooltip nil)              ; don't use tooltip
(setq eim-punc-translate-p nil)         ; use English punctuation
(register-input-method
 "eim-py" "euc-cn" 'eim-use-package
 "pinyin" "EIM Chinese Pinyin Input Method" "py.txt"
 'my-eim-py-activate-function)
(setq default-input-method "eim-py")
;; (toggle-input-method nil)               ; default is turn off
(defun my-eim-py-activate-function ()
  (add-hook 'eim-active-hook
            (lambda ()
              (let ((map (eim-mode-map)))
                (define-key eim-mode-map "-" 'eim-previous-page)
                (define-key eim-mode-map "=" 'eim-next-page)))))

;; make ime compatible with evil-mode
(defun evil-toggle-input-method ()
  "when toggle on input method, switch to evil-insert-state if possible.
when toggle off input method, switch to evil-normal-state if current state is evil-insert-state"
  (interactive)
  ;; some guy donot use evil-mode at all
  (if (fboundp 'evil-insert-state)
      (if (not current-input-method)
          (if (not (string= evil-state "insert"))
              (evil-insert-state))
        (if (string= evil-state "insert")
            (evil-normal-state)
          )))
  (toggle-input-method))

;(global-set-key (kbd "S-SPC") 'evil-toggle-input-method)
;(require 'eim-extra)  
;(global-set-key ";" 'eim-insert-ascii)  

(custom-set-variables '(default-input-method "eim-py"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(provide 'init-local)
