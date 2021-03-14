#!/bin/bash

if [ $(id -u) != 0 ]
then
	echo 'Script harus run di root user'
	exit 0
fi

echo 'Clone repo Endlessh'
git clone https://github.com/skeeto/endlessh
sleep 1

echo 'Masuk ke endlessh folder'
cd endlessh
sleep 1

if [! -f '$(pwd)/Makefile']
then
	echo 'Makefile tidak ada'
	exit 1
fi
echo 'Compile Endlessh'
make sleep 1

echo 'Install despencies'
apt install libc6-dev
sleep 1

echo 'Memindah binari endlessh ke /bin/'
cp endlessh /bin/
sleep 1

echo 'Memindahkan config ke /etc/systemd/system/'
cp util/endlessh.service /etc/systemd/system
sleep 1

echo 'Mengaktifkan endlessh sercive'
systemctl enable endlessh
sleep 1

echo 'Membuat file configurasi'
mkdir -p /etc/endlessh
sleep 1

echo 'Set endlessh ke port 22'
echo 'Port 22' > /etc/endlessh/config
sleep 1

echo 'Start service endlessh'
systemctl start endlessh
sleep 1
echo 'Done'
