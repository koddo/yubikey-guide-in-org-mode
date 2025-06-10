(xterm-mouse-mode 1)
(cua-mode 1)
(setq shift-select-mode t)
(setq org-support-shift-select 'always)
(setq confirm-kill-processes nil)   ; we have a shell session, kill it without hesitation on exit

(setq org-babel-min-lines-for-block-output 1000)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)
   ))

(setq org-confirm-babel-evaluate nil)
