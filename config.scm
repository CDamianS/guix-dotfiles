;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu) (nongnu packages linux))

(use-service-modules cups 
		     sddm
		     desktop 
		     networking 
		     ssh 
		     xorg)

(use-package-modules wm
		     dunst
		     vim
		     disk
		     gnupg
		     emacs
		     terminals
		     version-control
		     linux
		     shells
		     certs
		     pulseaudio
		     xdisorg
		     glib
		     gtk
		     gnome
		     password-utils
		     image
		     video)


(operating-system
  (kernel linux)
  (firmware (list linux-firmware))
  (locale "en_US.utf8")
  (timezone "America/Mexico_City")
  (keyboard-layout (keyboard-layout "us" "altgr-intl"))
  (host-name "virtguixia")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "damian")
                  (comment "Damian Suarez")
                  (group "users")
                  (home-directory "/home/damian")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (cons* sway
		   swaybg
		   swaylock
		   waybar
		   fuzzel
		   git
		   slurp
		   grimshot
		   pamixer
		   brightnessctl
		   dunst
		   password-store
		   gnupg
		   vim
		   network-manager-applet
		   yad
		   lf
		   fish
		   foot
		   kitty
		   mpv
		   nss-certs
		   %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list
            (service openssh-service-type)
            (service elogind-service-type)
            (service sddm-service-type)
            (service network-manager-service-type)
            (service wpa-supplicant-service-type)
            (service ntp-service-type))

           (modify-services
            %base-services
            (guix-service-type
             config =>
             (guix-configuration
              (inherit config)
              (substitute-urls
               (append
		(list "https://substitutes.nonguix.org")
	        %default-substitute-urls))
              (authorized-keys
               (append
		%default-authorized-guix-keys
		(list (local-file "./signing-key.pub")
                      ))))))))
  ;; (services
  ;;  (append (list
  ;;                (service openssh-service-type)
  ;;                (service elogind-service-type)
  ;;                (service sddm-service-type)
  ;;                (service network-manager-service-type)
  ;;                (service wpa-supplicant-service-type)
  ;;                (service ntp-service-type))

  ;;          ;; This is the default list of services we
  ;;          ;; are appending to.
  ;;          %base-services))
  
  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets (list "/dev/sda"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "be8ea3c2-dde0-475c-bb01-a1a587b02eeb")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "d1be02d7-aa56-476c-ba4c-25e3f72522de"
                                  'ext4))
                         (type "ext4")) %base-file-systems)))
