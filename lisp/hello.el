;;; hello.el --- Echo "Hello, world!"  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(defun hello-world ()
  (interactive) ; 命令时带是interactive的函数，可以通过M-x来执行
  (message "Hello, world!!!"))

(provide 'hello) ; 意为“导出本模块，名为 hello”。这样就可以在其它地方进行 require 

;;; hello.el ends here
