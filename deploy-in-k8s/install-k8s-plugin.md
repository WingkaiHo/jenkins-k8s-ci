### 介绍

  - jenkins 可以通过kubernetes plugin 插件在kubernetes 上创建jnlp-slave pod, 并且把pod加入到 jenkins 集群的node， 如果构建完成以后可以把pod释放掉，以供其他构建使用。
  
  - kubernetes pipeline plugin 可以在pipline里面启用jnlp-slave pod 
