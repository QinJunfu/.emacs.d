;;; init-org.el --- orgmode configuration  -*- lexical-binding: t; -*-

;;; Code:

;; 0. 日程与任务文件
(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/tasks.org"))

;; 1. 告诉 Org Babel 加载哪些语言
(org-babel-do-load-languages
 'org-babel-load-languages
  '((C . t)                 ; 启用 C/C++ 支持（关键配置）
   (shell . t)             ; 启用 Shell 支持
   (python . t)            ; 启用 Python 支持
   (dot . t)
   ;; ... 在此添加你需要的其他语言
   ))
;; 2. （可选）关闭每次执行代码前的安全确认，以提升流畅度
(setq org-confirm-babel-evaluate nil)

(use-package htmlize
  :ensure t)

(use-package org-re-reveal
  :ensure t
  :after org
  :init
  :config
  (setq org-re-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
  (setq org-re-reveal-revealjs-version "4")
  )

(use-package graphviz-dot-mode
  :ensure t
  :config
  (setq graphviz-dot-indent-width 4)
  :hook
  (graphviz-dot-mode . flycheck-mode))

(use-package org-super-agenda
  :ensure t
  :config
  (org-super-agenda-mode 1)
  (setq org-super-agenda-groups
	`((:name "今天" :time-grid t)
	  (:name "本周截止" :deadline (before ,(format-time-string "%Y-%m-%d"
							       (time-add (current-time) (* 7 86400)))))
	  (:name "待办" :todo "TODO"))))

(provide 'init-org)

;;; init-org.el ends here
