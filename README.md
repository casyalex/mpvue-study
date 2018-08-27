# mpvue-study

> A Mpvue project

## Build Setup

``` bash
# install dependencies
npm install

# serve with hot reload at localhost:8080
npm run dev

# build for production with minification
npm run build

# build for production and view the bundle analyzer report
npm run build --report
```

For detailed explanation on how things work, checkout the [guide](http://vuejs-templates.github.io/webpack/) and [docs for vue-loader](http://vuejs.github.io/vue-loader).

## 学（踩）习（坑）笔记

#### 小程序架构

1 客户端 client 即Vue部分

2 服务端 server 即koa部分 用腾讯云方案可以包办 用NodeJS Demo修改一下就可以上线。与客户端通信的API 由wafer2负责

找时间了解 lodash的chunk函数 能让数组添加多一维

#### 结课 完坑 linet

#### 上传腾讯云开发环境

1.src/config.js host项改成 开发环境 request 域名

2.server端的 config.js，注释掉头部的本地开发，把数据库密码改成APPID

3.到腾讯云后台 登录mysql 账号root 密码appid，建表

4.建表可以用navicat的建表语句，对表格右键》对象信息》DDL 复制粘贴到 腾讯云的phpMyadmin SQL命令行中 点执行 完成

5.联调没问题，就已经部署完毕


