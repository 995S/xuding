#服务器状态推送到TG机器人temp 23.08.11
cd /tmp
rm -rf /tmp/sh
git clone https://user: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@ghproxy.com/https://github.com/955s/sh
cd sh
chmod u+x *
/tmp/sh/new_directory.sh
cp /tmp/sh/status-client /usr/sju/status-client
cp /tmp/sh/status-tg.sh /usr/sju/sh/status-tg.sh
chmod +x /usr/sju/status-client
chmod +x /usr/sju/sh/status-tg.sh
/usr/sju/sh/status-tg.sh nohup >/var/ds/status-tg.log 2>&1 &
echo '/usr/sju/sh/status-tg.sh nohup >/var/ds/status-tg.log 2>&1 &' >> /usr/sju/sh/Self_starting.sh
#添加注释14.22