登录时 自动解锁gpg
1. emerge sys-auth/pam-gnupg #from guru
1. 需要保证user 登录时的密码与 gpg 的蜜码相同
2. /etc/pam.d/system-local-login 
   auth 最后一行添加
  auth     optional  pam_gnupg.so store-only
  session 最后一行添加
  session  optional  pam_gnupg.so
3. /etc/pam.d/swaylock 末尾添加
auth     optional  pam_gnupg.so
