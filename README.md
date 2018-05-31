基础：

http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html

http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html



为什么用？

方便部署



前提：

uname -m查看ubuntu多少位的i686是32位

ok，docker不支持ubuntu32，因为很多镜像都是64位，手动创建不太必要- - 



自动化工具docker-compose：

一般：Python容器+Django容器+mysql容器+Nginx容器+redis容器

简单：Python+Django+mysql容器使用：

1.结构

db/ 

docker-compose.yml 

Dockerfile 

izone/ 

requirements.txt



2.Dockerfile文件

3.docker-compose.yml文件

4.修改izone项目数据库等配置

5.Dockerfile如果全是官方镜像可以直接docker-compose up

如果还有自己打包的镜像，需要docker-compose build再up -d(后台)

然后在容器里执行makemigrations、migrate、createsuperuser



附录

1、查看当前docker容器中已有的image

docker image ls

2、查看所有的容器

docker ps -a

3、批量停止在运行中的容器

docker ps -a | grep 'Up' | awk '{print $1}'| xargs docker container stop

4、批量删除Exited状态的容器

docker ps -a | grep 'Exited' | awk '{print $1}'| xargs docker container rm

5、批量删除name为none的image

docker image ls | grep none | awk '{print $3}' | xargs docker image rm





二级评论
用户认证
第三方登陆
评论Ajax提交
响应式页面
被@通知推送(Undone)


## 使用步骤：

### 克隆项目到本地
使用如下命令讲项目克隆到本地：
```
git clone git@github.com:Hopetree/izone.git
```

### 创建网站关键信息文件
由于涉及到网站的一些隐私信息，所以这个项目有一个文件没有上传到Github中，所以要在克隆项目之后自己创建这个文件。
在settings.py文件所在的文件夹下创建一个base_settins.py文件，然后在里面写入如下代码：
```
# -*- coding: utf-8 -*-
# 邮箱配置
EMAIL_HOST = 'smtp.163.com'
EMAIL_HOST_USER = 'your-email@163.com'
EMAIL_HOST_PASSWORD = 'your-password'  # 这个不是邮箱密码，而是授权码
EMAIL_PORT = 465  # 由于阿里云的25端口打不开，所以必须使用SSL然后改用465端口
# 是否使用了SSL 或者TLS，为了用465端口，要使用这个
EMAIL_USE_SSL = True
# 默认发件人，不设置的话django默认使用的webmaster@localhost，所以要设置成自己可用的邮箱
DEFAULT_FROM_EMAIL = 'your-webname <your-email@163.com>'

# 网站默认设置和上下文信息
DEFAULT_IMG_LINL = '一个默认的图片地址，用来给文章添加默认图片'
SITE_END_TITLE = '网站的名称'
SITE_DESCRIPTION = '网站描述'
SITE_KEYWORDS = '网站关键词，多个词用英文逗号隔开'
```

### 在虚拟环境中安装依赖
本项目的依赖文件可以在项目根目录看到，如何安装依赖可以查看我博客文章 http://www.seoerzone.com/article/virtualenv-for-python/

### 创建数据库
在自己的MySQL中创建一个数据,根据自己的数据信息去更改项目的setting.py文件中的信息：
```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',  # 修改数据库为MySQL，并进行配置
        'NAME': 'izone',
        'USER': 'root',
        'PASSWORD': 'python',
        'HOST': '127.0.0.1',
        'PORT': 3306,
        'OPTIONS': {'charset': 'utf8mb4', }
    }
}
```

### 在虚拟环境中运行项目
首先要创建数据库表格，命令是：
```
(izone_env) F:\DjangoSpace\izone>python manage.py makemigrations
```
然后确认迁移：
```
(izone_env) F:\DjangoSpace\izone>python manage.py migrate
```
然后运行程序
```
(izone_env) F:\DjangoSpace\izone>python manage.py runserver --settings=izone.settings_dev
```

### 打开浏览器查看项目运行效果
在浏览器中输入 http://127.0.0.1:8000/ 即可查看项目的运行效果

### 要进入后台的话，需要先创建一个超级管理员账号:
```
(izone_env) F:\DjangoSpace\izone>python manage.py createsuperuser
```
