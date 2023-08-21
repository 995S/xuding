#!/bin/bash
apt-get update #更新版本号
sed -i 's/#Port\ 22/Port\ 2969/' /etc/ssh/sshd_config && systemctl reload ssh #修改端口为2969
apt install net-tools -y #安装一些常用缺失的库
sudo apt-get install python3-pip -y #安装pip
python3 -m pip install --upgrade pip #升级pip

#同步sh库
cd /tmp
rm -rf /tmp/sh
git clone https://user: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@ghproxy.com/https://github.com/955s/sh
cd sh
chmod u+x *
/tmp/sh/new_directory.sh

#探针
cp /tmp/sh/status-psutil.py /usr/sju/py/status-psutil.py
cp /tmp/sh/status-psutil.sh /usr/sju/sh/status-psutil.sh
chmod u+x /usr/sju/sh/status-psutil.sh
/usr/sju/sh/status-psutil.sh install
/usr/sju/sh/status-psutil.sh nohup
echo 'nohup python3 /usr/sju/py/status-psutil.py >/var/ds/status.log 2>&1 &' >> /usr/sju/sh/Self_starting.sh

#ddns
pip3 install aliyun-python-sdk-alidns pyaml #安装ali ddns需要的库
cp /tmp/sh/ddns.py /usr/sju/py/ddns.py
python3 /usr/sju/py/ddns.py
crontab -l > /tmp/crontab.$$
echo '*/5 * * * * python3 /usr/sju/py/ddns.py >/var/ds/ddns.log 2>&1' >> /tmp/crontab.$$
crontab /tmp/crontab.$$

#mtg
cd /tmp/sh/
tar zxvf /tmp/sh/mtg-2.1.7.tar.gz
cp -r /tmp/sh/mtg-2.1.7 /usr/sju/mtg-2.1.7
nohup /usr/sju/mtg-2.1.7/mtg run /usr/sju/mtg-2.1.7/mtg.toml >/var/ds/mtg.log 2>&1 &
echo 'nohup /usr/sju/mtg-2.1.7/mtg run /usr/sju/mtg-2.1.7/mtg.toml >/var/ds/mtg.log 2>&1 &' >> /usr/sju/sh/Self_starting.sh

#cron
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime #恢复Cron时区为UTC+8
cp /tmp/sh/config/crontab /var/spool/cron/crontabs/root
cp /tmp/sh/re_cron.sh /usr/sju/sh/re_cron.sh
service rsyslog restart
sleep 1s
/etc/init.d/cron restart #重启cron任务
crontab -l

#恢复rc.local开机自启动文件
rm -rf /etc/rc.local
echo '#!/bin/bash' > /etc/rc.local #创建rc.local
echo "nohup /usr/sju/sh/Self_starting.sh > /var/ds/Self_starting.log 2>&1 &" >> /etc/rc.local #在rc.local添加sh脚本启动项
echo "exit 0" >> /etc/rc.local #在rc.local添加sh脚本启动项
chmod +x /etc/rc.local
echo '#!/bin/bash' > /usr/sju/sh/Self_starting.sh #创建开机启动的sh脚本
#echo "sleep 3s" >> /usr/sju/sh/Self_starting.sh #在sh脚本内追加延时3s命令
chmod u+x /usr/sju/sh/Self_starting.sh
systemctl restart rc-local #重新启动开机自启动服务
cat /etc/rc.local

#搭建梯子
wget https://raw.githubusercontent.com/veip007/hj/main/trojan-go.sh
chmod u+x * trojan-go.sh
./trojan-go.sh
#us1.hagoni.org
#https://www.bing.com
#passwd: lB3IZxL3vVmrgvbI
netstat -tln

#rclone_status
cp /tmp/sh/bk/bk.sh /usr/sju/sh/bk.sh
chmod u+x /usr/sju/sh/bk.sh
/tmp/sh/i_rclone.sh
rclone config file #查看rclone配置文件路径
cp /tmp/sh/config/rclone.conf /root/.config/rclone/rclone.conf
crontab -l > /tmp/crontab.$$
echo '0 0 * * * /usr/sju/sh/bk.sh >/var/ds/bk.log 2>&1' >> /tmp/crontab.$$
crontab /tmp/crontab.$$
/etc/init.d/cron restart #重启cron任务
crontab -l
cp /tmp/sh/rclone_mount_cooe_b.sh /usr/sju/sh/rclone_mount_cooe_b.sh
echo '/usr/sju/sh/rclone_mount_cooe_b.sh nohup >/var/ds/rclone_mount.log 2>&1 &' >> /usr/sju/sh/Self_starting.sh
/usr/sju/sh/rclone_mount_cooe_b.sh start #手动挂载测试 正常挂载后再再用nohup参数后台挂载

#echo '/usr/sju/Status/sergate.sh start >/var/ds/sergate.log 2>&1 &' >> /usr/sju/sh/Self_starting.sh
#fusermount -qzu cooe_b #手动卸载

#服务器状态推送到TG机器人
cp /tmp/sh/status-client /usr/sju/status-client
cp /tmp/sh/status-tg.sh /usr/sju/sh/status-tg.sh
chmod +x /usr/sju/status-client
chmod +x /usr/sju/sh/status-tg.sh
/usr/sju/sh/status-tg.sh nohup >/var/ds/status-tg.log 2>&1 &
echo '/usr/sju/sh/status-tg.sh nohup >/var/ds/status-tg.log 2>&1 &' >> /usr/sju/sh/Self_starting.sh


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