;;; plugins.el --- Plugins' configuration via use-package  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; ============ 补全与搜索框架 ============
(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (counsel-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq search-default-mode #'char-fold-to-regexp)
  (setq ivy-count-format "(%d/%d) ")
  :bind
  (("C-s" . swiper)
   ("C-x b" . ivy-switch-buffer)
   ("C-c v" . ivy-push-view)
   ("C-c s" . ivy-switch-view)
   ("C-c V" . ivy-pop-view)
   ("C-x C-@" . counsel-mark-ring)     ; 在某些终端上 C-x C-SPC 会被映射为 C-x C-@，比如在 macOS 上，所以要手动设置
   ("C-x C-SPC" . counsel-mark-ring)
   ("C-x C-f" . counsel-find-file)
   :map minibuffer-local-map
   ("C-r" . counsel-minibuffer-history)))

(use-package counsel
  :ensure t)

(use-package amx
  :ensure t
  :init (amx-mode))

;; ============ 编辑增强 ============
(use-package mwim
  :ensure t
  :bind
  ("C-a" . mwim-beginning-of-code-or-line)
  ("C-e" . mwim-end-of-code-or-line))

(use-package ace-window
  :ensure t
  :bind (("C-x o" . 'ace-window)))

(use-package avy
  :ensure t
  :bind
  (("C-c j" . avy-goto-char-2)))

(use-package undo-tree
  :ensure t
  :init (global-undo-tree-mode)
  :custom
  (undo-tree-auto-save-history nil))

;; ============ 界面与显示 ============
(use-package dashboard
  :ensure t
  :config
  (setq dashboard-startup-banner
        (expand-file-name "assets/marivector.png" user-emacs-directory)) ; This picture come from: https://github.com/snackon/Witchmacs
  (setq dashboard-image-banner-max-width 300)
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10)
                          (projects . 10)
			  (bookmarks . 10)
			  (agenda . 10)))
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-projects-show-base t))

(use-package nerd-icons
  :ensure t
  :demand t
  :custom
  (nerd-icons-font-family "JetBrainsMono Nerd Font Mono"))

(use-package doom-modeline
  :ensure t
  :after nerd-icons
  :init (doom-modeline-mode 1))

(use-package which-key
  :ensure t
  :init (which-key-mode))

(use-package treemacs
  :ensure t
  :defer t
  :config
  ;; 设置侧边栏宽度为 25 个字符
  (setq treemacs-width 40)

  ;; 2. 增强视觉：启用图标和 Git 状态
  (treemacs-git-mode 'simple)

  ;; 3. 高级功能：代码符号跟随和项目跟随
  (treemacs-tag-follow-mode t)
  (treemacs-project-follow-mode t)

  ;; 4. 绑定快捷键
  :bind
  (("M-0" . treemacs-select-window)        ; 快速跳回 Treemacs 窗口
   ("<f8>" . treemacs)))                  ; 按 F8 打开/关闭侧边栏

;; ============ 项目管理 ============
(use-package projectile
  :ensure t
  :bind (("C-c p" . projectile-command-map))
  :config
  (setq projectile-mode-line "Projectile")
  (setq projectile-track-known-projects-automatically t))

(use-package counsel-projectile
  :ensure t
  :after (projectile)
  :init (counsel-projectile-mode))

;; ============ 版本控制 ============
; Use C-x g to call
(use-package compat
  :ensure t
  :demand t)

(use-package magit
  :ensure t
  :after compat)

;; ============ 代码检查 ============
(use-package flycheck
  :ensure t
  :config
  (setq truncate-lines nil) ; 如果单行信息很长会自动换行
  :hook
  (prog-mode . flycheck-mode))

;; ============ 语言服务 LSP ============
(use-package lsp-metals
  :ensure t
  :defer t)

(use-package scala-mode
  :ensure t
  :mode ("\\.scala\\'" "build\\.sc\\'")
  :hook (scala-mode . lsp-deferred)
  :config
  (require 'lsp-metals))

(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l"
	lsp-file-watch-threshold 500)
  :hook
  ((c-mode . lsp-deferred)
   (c++-mode . lsp-deferred)
   (lsp-mode . lsp-enable-which-key-integration)) ; which-key integration
  :commands (lsp lsp-deferred)
  :config
   (setq lsp-completion-provider :capf) ;; 使用 lsp 提供的 capf 作为 company 补全后端
  (setq lsp-headerline-breadcrumb-enable t)
  :bind
  ("C-c l s" . lsp-ivy-workspace-symbol)) ;; 可快速搜索工作区内的符号（类名、函数名、变量名等）

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-tooltip-align-annotations t)
  (global-company-mode 1))

(use-package lsp-ui
  :ensure t
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-position 'top))

(use-package lsp-ivy
  :ensure t
  :after (lsp-mode))

(use-package rustic
  :ensure t
  :config
  (setq rustic-format-on-save t)
  (setq rustic-lsp-client 'lsp-mode)
  :custom
  (rustic-cargo-use-last-stored-arguments t))

;; ============ Nix ============
(use-package nix-mode
  :ensure t
  :mode ("\\.nix\\'" "\\.nix.in\\'"))

;; ============ 开发工具 ============
; Use C-c / t to call
(use-package google-this
  :ensure t
  :init
  (google-this-mode))

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

(provide 'plugins)

;;; plugins.el ends here
