(setq inhibit-splash-screen t)
(add-hook 'c-mode-common-hook
		  '(lambda ()
			 (c-set-style "k&r")
			 (setq c-basic-offset 4)
			 (setq indent-tabs-mode t)
			 (setq tab-width 4)))
; Disable backup
(setq make-backup-files nil)
; Disable auto-save
(setq auto-save-default nil)
