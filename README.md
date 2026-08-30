# Emacs 配置

这是我的个人 Emacs 配置，配置入口是 `init.el`，其他自定义代码位于 `lisp/` 目录。

## 要求

- 建议使用 Emacs 27 或更高版本。
- 首次启动需要能够访问 GNU ELPA 和 MELPA，以安装配置中的插件。
- `use-package` 必须可用。较旧版本的 Emacs 可能需要先手动安装它：

  ```elisp
  M-x package-refresh-contents
  M-x package-install RET use-package RET
  ```

配置中的插件使用 `use-package` 的 `:ensure t` 声明，缺少插件时 Emacs 会尝试自动安装。

## 安装

备份现有配置后，将仓库克隆到 Emacs 的用户配置目录：

```bash
mv ~/.emacs.d ~/.emacs.d.backup  # 如果该目录已存在且需要保留
git clone git@github.com:prtysil/emacs.d.git ~/.emacs.d
```

也可以使用 HTTPS：

```bash
git clone https://github.com/prtysil/emacs.d.git ~/.emacs.d
```

启动 Emacs 后，插件会按配置安装。首次安装可能需要一些时间。

## 系统工具

部分功能依赖 Emacs 之外的程序。按需安装：

- Git：Magit、Projectile 和 Treemacs 的 Git 集成
- C/C++ 编译器和 `clangd`：C/C++ 开发与 LSP
- Python 和 Python LSP 服务：Python 开发与 LSP
- Rust、Cargo 和 `rust-analyzer`：Rust 开发
- Graphviz：Org Babel 的 `dot` 支持
- Docker CLI/服务：`docker` 插件
- Nix：`nix-mode` 及 Nix 项目开发

例如 Arch Linux 可以按需安装常用工具：

```bash
sudo pacman -S git ripgrep graphviz docker clang python rust rust-analyzer
```

工具名称和包名可能随发行版不同，请以目标系统的软件仓库为准。

## Org 文件

Org 配置默认使用以下文件：

```text
~/org/tasks.org
```

如果使用 Org agenda，请创建该目录和文件：

```bash
mkdir -p ~/org
touch ~/org/tasks.org
```

## 跨平台说明

配置源码不包含 Mac 专用绝对路径，通常可以在 macOS 和 Arch Linux 之间共享。插件目录、缓存、历史记录和其他本地状态文件被 `.gitignore` 排除，不会通过 Git 同步；每台电脑都需要单独安装插件和系统工具。A

插件版本目前没有锁定，因此不同电脑或不同时间安装的版本可能存在差异。

## 更新配置

```bash
cd ~/.emacs.d
git pull
```

