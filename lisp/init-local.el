;;; package -- my config
;;; Commentary:
;;; Code:
;; 快速打开初始化文件
(defun open-my-init-file () "OPEN MY INITFILE."
       (interactive)
       (find-file "~/.emacs.d/lisp/init-local.el")
       )
;; 绑定到f8
(global-set-key (kbd "<f8>") 'open-my-init-file)
;; 设置光标默认样式
(setq-default cursor-type 'bar)
;; 关闭文件备份
(setq make-backup-files nil)
;; 高亮当前行
(global-hl-line-mode t)
;; 设置org-mode默认缩进
(setq org-startup-indented t)
;;-------------------------------------------------
;; 下面是字符和字体设置
;;-------------------------------------------------
(set-face-attribute 'default nil :font "Consolas-12")

;; 定义校验函数
(defun luogh-font-existsp (font) "校验FONT字体在系统中是否存在."
       (if (null (x-list-fonts font))
           nil
         t))
;; 定义要使用的字体
(defvar font-list '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
;; 函数在执行local文件之前应该已经被加载了
;; (require 'cl)
;; find-if 函数必须在cl引入后才能使用
(find-if 'luogh-font-existsp font-list)

;; 生成字体字符串
(defun luogh-make-font-string (font-name font-size) "设置 FONT-NAME 字体名称，FONT-SIZE 字体大小."
       (if (and (stringp font-size)
                (equal ":" (string (elt font-size 0))))
           (format "%s%s" font-name font-size)
         (format "%s %s" font-name font-size)))

;; 设置字体函数
(defun luogh-set-font (english-fonts
                       english-font-size
                       chinese-fonts
                       &optional chinese-font-size)
  "ENGLISH-FONTS CHINESE-FONTS could be set to \":pixelsize=18\" or a integer.If set/leave CHINESE-FONT-SIZE to nil, it will follow ENGLISH-FONT-SIZE."
  ;; (require 'cl) ; 函数在执行local文件之前应该已经被加载了
  (let ((en-font (luogh-make-font-string
                  (find-if 'luogh-font-existsp english-fonts)
                  english-font-size))
        (zh-font (font-spec :family (find-if 'luogh-font-existsp chinese-fonts)
                            :size chinese-font-size)))

    (message "Set English Font to %s" en-font)
    (set-face-attribute 'default nil :font en-font)

    ;; Set Chinese font
    ;; Do not use 'unicode charset, it will cause the English font setting invalid
    (message "Set Chinese Font to %s" zh-font)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset zh-font))))

(luogh-set-font
 '("Consolas" "Monaco" "DejaVu Sans Mono" "Monospace" "Courier New") ":pixelsize=16"
 '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))

(provide 'init-local)
;;; init-local.el ends here
