---
layout: post
title:  "阿里云ECS安装MYSQL"
date:   2020-01-05 20:42:32 +0800
categories: 阿里云
---

前提 操作系统 centeros7.5  mysql 6.5

#### 进入主题


首先 yum list mysql 发现没货

#####  第一步 获取repo 解压 安装到系统 如下三行

```
wget http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm

rpm -ivh mysql-community-release-el6-5.noarch.rpm

yum repolist all | grep mysql

```

发现 enable的只有5.6的社区版
```
mysql-connectors-community/x86_64 MySQL Connectors Community     enabled:    113
mysql-connectors-community-source MySQL Connectors Community - S disabled
mysql-tools-community/x86_64      MySQL Tools Community          enabled:     84
mysql-tools-community-source      MySQL Tools Community - Source disabled
mysql55-community/x86_64          MySQL 5.5 Community Server     disabled
mysql55-community-source          MySQL 5.5 Community Server - S disabled
mysql56-community/x86_64          MySQL 5.6 Community Server     enabled:    549
mysql56-community-source          MySQL 5.6 Community Server - S disabled
mysql57-community-dmr/x86_64      MySQL 5.7 Community Server Dev disabled
mysql57-community-dmr-source      MySQL 5.7 Community Server Dev disabled
```

#####  第二步 开始安装
```
yum install mysql-community-server -y
```


#####  第三步 启动 
```
service mysqld start
```

#####  第四步 安全设置
```
mysql_secure_installation
```

Enter current password for root (enter for none): 
这里有点意思
首先让你输密码 因为是刚刚安装的 直接enter键 
然后设置密码

Remove anonymous users
是否删除匿名用户 => y 删除

Disallow root login remotely? 
是否允许远程登录 => n 允许 (根据不同环境灵活处理)

Remove test database and access to it?
是否删除测试库 => y 删除

Reload privilege tables now?
是否更新权限 => y 是


#####  第五步 数据库设置
登录数据库  ```mysql  -u root -p```
显示字符集  ```show variables like 'character%';```

```
 +--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8                       |
| character_set_connection | utf8                       |
| character_set_database   | latin1                     |
| character_set_filesystem | binary                     |
| character_set_results    | utf8                       |
| character_set_server     | latin1                     |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
8 rows in set (0.00 sec)
```
改字符集开始 
```
vim /etc/my.cnf
```
在[mysqld]下加一行
```
[mysqld]
character-set-server=utf8
```
重启mysql
``` 
service mysqld restart 
```

登录 显示字符集 同上，结果如下。 配置完成
```
+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8                       |
| character_set_connection | utf8                       |
| character_set_database   | utf8                       |
| character_set_filesystem | binary                     |
| character_set_results    | utf8                       |
| character_set_server     | utf8                       |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
8 rows in set (0.00 sec)

```

