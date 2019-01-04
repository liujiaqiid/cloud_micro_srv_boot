

#### Jenkins Setup
1. [官网下载](https://jenkins.io/download/)
    ```
    wget https://pkg.jenkins.io/redhat-stable/jenkins-2.150.1-1.1.noarch.rpm
    ```
2. 安装
    ```
    rpm -ivh ./jenkins-*.rpm
    ```
3. 启动
    ```bash
    ## 查看已安装的jenkins命令脚本
    ll /etc/init.d/ | grep jenkins
    
    ## 服务控制，查看，启动
    systemctl status jenkins
    systemctl start jenkins
    systemctl enable jenkins
    ```  
4. 初始化
    ```bash
    ## 此时可以通过 http://ip:8080 访问Jenkins服务
    ## 初次访问Jenkins会要求用户输入admin的初始密码
    ## 查看初始密码：
    cat /var/lib/jenkins/secrets/initialAdminPassword
    
    ## 修改Jenkins配置
    vim /etc/init.d/jenkins  # 查看脚本中的JENKINS_CONFIG设置
    vim /etc/sysconfig/jenkins # 修改配置
    
    ## 重启服务
    systemctl restart jenkins
    ```
    
