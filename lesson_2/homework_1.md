#


Генерируем SSH ключ на первой машине
ssh-keygen -t ed25519 

cat .ssh/yandex_machine.pub
Копируем и вставляем этот ключ в файл autorized_keys



etc/ssh/sshd_config
Разрешаем от пользователя root



