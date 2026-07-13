;;; my_func.el --- My own function
;;; Code:

(defvar my--shell-window nil
  "存储 shell 窗口，用于切换关闭。")

(defun my-toggle-shell ()
  "切换 shell 窗口。按一次打开，再按关闭。"
  (interactive)
  (if (and (window-live-p my--shell-window)
           (with-selected-window my--shell-window
             (eq major-mode 'shell-mode)))
      (progn
        (delete-window my--shell-window)
        (setq my--shell-window nil))
    (split-window-below)
    (other-window 1)
    (shell)
    (setq my--shell-window (selected-window))))

;; 绑定快捷键为 F12，你可以换成自己喜欢的按键
(global-set-key (kbd "C-c t") 'my-toggle-shell)

;;; my_func.el ends here
