1. 先关闭虚拟机中的 Linux，回到虚拟机主界面，在菜单栏中找到 `编辑` >> `虚拟网络编辑器` 选择 VMnet1 网卡，即主机模式( Host-only )
2. 在菜单中找到`虚拟机`>> `设置`>>`网络适配器`, 选择仅主机模式
3. 打开真实机中网络连接，找到拨号上网的那个网卡，右键点击`属性`>>`共享`
选择`允许其它网络用户通过此计算机的INTERNET连接来连接`,在`家庭网络连接`下拉框中选择 VMnet1 对应的网卡。选择完后保存。
4. 设置完成后在 CMD 中运行 ipconfig 获取 VMnet1 的IP地址，后面设置 Linux 的IP地址有用。
5. 运行 ipconfig/all 获取 拨号上网的NDS
6. 设置 Linux 中的网卡信息，在CentOS 中可运行 setup 命令，通过图像界面来设置选择`Network configuration` >> `Device configuration` >> `eht0` 来设置，也可通过 `vim /etc/sysconfig/network-script/ifcfg-eth0` 来设置。
7. 重启网络：`service network restart`
此时，只要主机拨号上网后，虚拟机就可以上网，而且不用再拨号。
