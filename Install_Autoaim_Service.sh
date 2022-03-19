#!/bin/bash
sudo chmod a+xrw /home/nvidianx/auto-aim/bash/*.sh
sudo cp ./sources/auto-aim.service /lib/systemd/system/auto-aim.service
sudo systemctl daemon-reload

echo 'alias autoaim-enable="sudo systemctl enable auto-aim.service"' >> ~/.bashrc
echo 'alias autoaim-disable="sudo systemctl disable auto-aim.service"' >> ~/.bashrc
echo 'alias autoaim-start="sudo systemctl start auto-aim.service"' >> ~/.bashrc
echo 'alias autoaim-stop="sudo systemctl stop auto-aim.service"' >> ~/.bashrc
echo 'alias autoaim-status="sudo systemctl status auto-aim.service"' >> ~/.bashrc
echo 'alias autoaim-help=/home/nvidianx/auto-aim/bash/auto-aim-help.sh' >> ~/.bashrc
runuser -l nvidianx -c "source ~/.bashrc"
