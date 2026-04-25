gsettings set org.gnome.desktop.wm.preferences audible-bell false
gsettings set org.gnome.desktop.wm.preferences visual-bell true
gsettings set org.gnome.desktop.wm.preferences visual-bell-type frame-flash

sudo su -
cat > /etc/systemd/system/silence-console.service <<EOD
[Unit]
Description=Silence virtual console default beep

[Service]
Type=oneshot
Environment=TERM=linux
StandardOutput=tty
TTYPath=/dev/console
ExecStart=/usr/bin/setterm -blength 0

[Install]
WantedBy=multi-user.target 
EOD

systemctl daemon-reload
systemctl enable silence-console
systemctl start silence-console

cat > /etc/X11/Xsession.d/91custom-silence-beep <<EOD
#!/bin/sh
xset -b
EOD
chmod +x /etc/X11/Xsession.d/91custom-silence-beep

cat > /etc/modprobe.d/nobeep.conf <<EOD
blacklist pcspkr
EOD
sudo rmmod pcspkr

echo "set bell-style none" > ~/.inputrc
