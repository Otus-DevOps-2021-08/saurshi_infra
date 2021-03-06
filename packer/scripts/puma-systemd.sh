#!/bin/bash
cat > /etc/systemd/system/puma.service <<\EOF
[Unit]
Description=Puma
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/reddit
ExecStart=/usr/bin/bundle exec puma
ExecReload=/bin/kill -USR1 $MAINPID
Restart=no

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable puma.service

