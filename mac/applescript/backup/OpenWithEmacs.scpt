FasdUAS 1.101.10   ��   ��    k             l     ��  ��      -*- coding:utf-8 -*-     � 	 	 *   - * -   c o d i n g : u t f - 8   - * -   
  
 l     ��  ��    O I http://superuser.com/questions/457484/how-to-open-emacs-from-macs-finder     �   �   h t t p : / / s u p e r u s e r . c o m / q u e s t i o n s / 4 5 7 4 8 4 / h o w - t o - o p e n - e m a c s - f r o m - m a c s - f i n d e r      l     ��  ��    = 7 https://gist.github.com/ambethia/304964#comment-799519     �   n   h t t p s : / / g i s t . g i t h u b . c o m / a m b e t h i a / 3 0 4 9 6 4 # c o m m e n t - 7 9 9 5 1 9      l     ��  ��    $  ?Finder ?????emacsclient ????     �   <  W( F i n d e r  N-S�.Ou( e m a c s c l i e n t  bS_ e�N�      l     ��  ��    = 7  ?????automator.app ??app  ,?applescript.app ???app ??     �   n    ��N*� ��u( a u t o m a t o r . a p p  [Xb a p p     ,u( a p p l e s c r i p t . a p p  [Xbv� a p p  N�L      i        !   I     �� "��
�� .aevtoappnull  �   � **** " J       # #  $�� $ o      ���� 	0 input  ��  ��   ! k     P % %  & ' & r      ( ) ( n      * + * 1    ��
�� 
strq + n      , - , 1    ��
�� 
psxp - o     ���� 	0 input   ) o      ���� 0 filepath   '  . / . l   �� 0 1��   0 = 7 if you donot  use ITerm  you can use Terminal instead     1 � 2 2 n   i f   y o u   d o n o t     u s e   I T e r m     y o u   c a n   u s e   T e r m i n a l   i n s t e a d   /  3 4 3 O    B 5 6 5 Q    A 7 8 9 7 k    . : :  ; < ; l   �� = >��   = w q we look for <= 2 because Emacs --daemon seems to always have an entry in visibile-frame-list even if there isn't    > � ? ? �   w e   l o o k   f o r   < =   2   b e c a u s e   E m a c s   - - d a e m o n   s e e m s   t o   a l w a y s   h a v e   a n   e n t r y   i n   v i s i b i l e - f r a m e - l i s t   e v e n   i f   t h e r e   i s n ' t <  @ A @ r     B C B I   �� D��
�� .sysoexecTEXT���     TEXT D m     E E � F F � / A p p l i c a t i o n s / E m a c s . a p p / C o n t e n t s / M a c O S / b i n / e m a c s c l i e n t   - e   ' ( < =   2   ( l e n g t h   ( v i s i b l e - f r a m e - l i s t ) ) ) '��   C o      ���� 0 framevisible frameVisible A  G�� G Z    . H I�� J H =    K L K o    ���� 0 framevisible frameVisible L m     M M � N N  t I I   $�� O��
�� .sysoexecTEXT���     TEXT O b      P Q P m     R R � S S t / A p p l i c a t i o n s / E m a c s . a p p / C o n t e n t s / M a c O S / b i n / e m a c s c l i e n t   - n   Q o    ���� 0 filepath  ��  ��   J k   ' . T T  U V U l  ' '�� W X��   W 1 + there is a not a visible frame, launch one    X � Y Y V   t h e r e   i s   a   n o t   a   v i s i b l e   f r a m e ,   l a u n c h   o n e V  Z�� Z I  ' .�� [��
�� .sysoexecTEXT���     TEXT [ b   ' * \ ] \ m   ' ( ^ ^ � _ _ z / A p p l i c a t i o n s / E m a c s . a p p / C o n t e n t s / M a c O S / b i n / e m a c s c l i e n t   - c   - n   ] o   ( )���� 0 filepath  ��  ��  ��   8 R      ������
�� .ascrerr ****      � ****��  ��   9 k   6 A ` `  a b a l  6 6�� c d��   c D > daemon is not running, start the daemon and open a frame         d � e e |   d a e m o n   i s   n o t   r u n n i n g ,   s t a r t   t h e   d a e m o n   a n d   o p e n   a   f r a m e           b  f g f I  6 ;�� h��
�� .sysoexecTEXT���     TEXT h m   6 7 i i � j j j / A p p l i c a t i o n s / E m a c s . a p p / C o n t e n t s / M a c O S / E m a c s   - - d a e m o n��   g  k�� k I  < A�� l��
�� .sysoexecTEXT���     TEXT l m   < = m m � n n x / A p p l i c a t i o n s / E m a c s . a p p / C o n t e n t s / M a c O S / b i n / e m a c s c l i e n t   - c   - n��  ��   6 m    	 o o�                                                                                  ITRM  alis    H  Macintosh HD               �̉H+   u��	iTerm.app                                                       �l����F        ����  	                Applications    ���      ��!�     u��  $Macintosh HD:Applications: iTerm.app   	 i T e r m . a p p    M a c i n t o s h   H D  Applications/iTerm.app  / ��   4  p q p l  C C��������  ��  ��   q  r s r l  C C�� t u��   t + % bring the visible frame to the front    u � v v J   b r i n g   t h e   v i s i b l e   f r a m e   t o   t h e   f r o n t s  w x w O  C M y z y I  G L������
�� .miscactvnull��� ��� null��  ��   z m   C D { {�                                                                                  EMAx  alis    H  Macintosh HD               �̉H+   u��	Emacs.app                                                       cI���w�        ����  	                Applications    ���      ��!     u��  $Macintosh HD:Applications: Emacs.app   	 E m a c s . a p p    M a c i n t o s h   H D  Applications/Emacs.app  / ��   x  | } | l  N N��������  ��  ��   }  ~�� ~ L   N P   o   N O���� 	0 input  ��     � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  ��� � l     ��������  ��  ��  ��       �� � ���   � ��
�� .aevtoappnull  �   � **** � �� !���� � ���
�� .aevtoappnull  �   � ****�� �� ���  �  ���� 	0 input  ��   � ���� 	0 input   � ������ o E���� M R ^���� i m {��
�� 
psxp
�� 
strq�� 0 filepath  
�� .sysoexecTEXT���     TEXT�� 0 framevisible frameVisible��  ��  
�� .miscactvnull��� ��� null�� Q��,�,E�O� 7 $�j E�O��  ��%j Y 	��%j W X 
 �j O�j UO� *j UO� ascr  ��ޭ