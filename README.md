# stttt2003pk_cod4server

## Introduction

正值新春佳节，有几天休息的时间，尝试写了一些和自动化运维有关的[demo](https://github.com/stttt2003pk/stttt2003pk_game_server_manager_api)，同时在自动化运维的调度服务器的时候需要有具体的游戏和相关的脚本，想想使命召唤到现在也10年了，从4到现在13，不管做的好坏都伴随了我的成长。大二的时候开始玩cod4的时候那个疯狂吖，所以这次也就选择了写个call of duty 4相关的脚本吧，也简单没花多少时间。放到相关demo里面去跑也是挺顺利的

* 比起[国庆时候写的cstrike的server相关的脚本](https://github.com/stttt2003pk/stttt2003pk.csserver)增加了自动安装和查看服务器信息的功能，当然这不是很难的事情，就当复习一下如何用几把漂亮的"瑞士军刀"把服务器监控内容print一下，非常经典的一些做法
* 增加自动安装的功能主要是为了能够放到[demo](https://github.com/stttt2003pk/stttt2003pk_game_server_manager_api)里面去跑，当然也可以写成python的不过想想还是没太大必要就当做复习

## Menu

![](https://raw.github.com/stttt2003pk/stttt2003pk.cod4server/master/screenshot/menu.png)

* 增加了自动安装的功能和查看服务器状态的功能

```
if [ -z "${autoinstall}" ]; then
    if [[ "${getopt}" == "install" ]] || [[ "${getopt}" == "i" ]]; then
        while true; do
            read -e -i "y" -p "Install the cod 4 server in your linux:[y|n]" yn
            case ${yn} in
                [Yy]*)
                    break;;
                [Nn]*)
                    exit 0;;
                *)
                    echo "Please answer yes or no.";;
            esac
        done
    fi
fi
```

## [Variables](https://github.com/stttt2003pk/stttt2003pk.cod4server/blob/master/releaseForJanCod4Shell/var.sh)

## Installation

![](https://raw.github.com/stttt2003pk/stttt2003pk.cod4server/master/screenshot/install.png)

可以用ai选项自动安装了，安装过程会自动检测需要的库并用yum补充完整，否则游戏启动是会被终止的，linux系统版本下面的游戏服务器都需要libstdc++的依赖

## Control

通过tmux启动和管理服务器，与之前的cstrike server类似，只是call of duty有自己特定的在linux上执行的二进制包，而不是用steamcmd去进行管理

![](https://raw.github.com/stttt2003pk/stttt2003pk.cod4server/master/screenshot/tmux1.png)

用root启动，cod会检测警告root不安全，因为有些外挂可以上传一些脚本获取到root权限，更改服务器端的数据，不过在这个实验中问题不大，有机会优化通过UID做个用户管理即可

![](https://raw.github.com/stttt2003pk/stttt2003pk.cod4server/master/screenshot/tmux2.png)

熟悉的交叉火力、地面战争模式。僵硬的是工作忙实在不想花心思研究具体的参数和配置，量化这些更具体的操作了，控制一下端口名字什么的，也不太讲究

## Server Detail

![](https://raw.github.com/stttt2003pk/stttt2003pk.cod4server/master/screenshot/de.png)

* 复习"瑞士军刀",最原始的方法获取一些[系统的信息](https://github.com/stttt2003pk/stttt2003pk.cod4server/blob/master/releaseForJanCod4Shell/functions/info_distro.sh)
* [打印具体的detail](https://github.com/stttt2003pk/stttt2003pk.cod4server/blob/master/releaseForJanCod4Shell/functions/command_details.sh)

## Plan&Vision

* 这次编写服务器执行脚本有了上次的经验，只用了不到一天的时间，加上自动化的一些功能后配合tornado的管理平台做了些测试也很顺利，包括打包发布解压安装配置等，游戏也能正常工作
* 有时间会将平台具体执行的更全面一些


