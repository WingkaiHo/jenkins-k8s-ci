## 1.1 部署jenkins in kubernets

### 1.1.1 创建jenkins持久化目录 
  在local-pv.yaml配置目录在所在的节点以及位置。
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: jenkins
  labels:
     app: jenkins   
  annotations:
    volume.alpha.kubernetes.io/node-affinity: >
      {
         "requiredDuringSchedulingIgnoredDuringExecution": {
           "nodeSelectorTerms": [
            { "matchExpressions": [
               { "key": "kubernetes.io/hostname",
                 "operator": "In",
                 # 配置持久化目录所在节点
                 "values": ["k8s-2"]
               }
           ]}
         ]}
      }
spec:
  capacity:
    # 配置目录大小
    storage: 20Gi
  accessModes:
  - ReadWriteOnce
  storageClassName: local-storage
  local:
    ## 配置目录路径
    path: /var/lib/docker/jenkins
```
  配置完毕以后需要先把路径在对应机器上面创建以后，才把local pv 加入kubernetes集群
```
$ kubectl create -f local-pv.yaml --namespace=kube-system 
```


### 1.1.2 配置PVC
  让PVC选择指定的pv, jenkins-pvc.yaml如下：
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: jenkins-pvc
  labels:
    docs-app: jenkins
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi
  storageClassName: local-storage
  selector:
    # 需要和local-pv.yaml label一致
    app: jenkins
```
  把PVC在kubernetes上创建

```
$kubectl create -f jenkins-pvc.yaml
```

### 1.1.3 创建jenkins service
  
   配置jenkins对外开发集群端口，可以通过k8s集群任意机器访问jenkins服务。jenkins-pvc.yaml如下：
```
kind: Service
apiVersion: v1
metadata:
  labels:
      app: jenkins
  name: jenkins
spec:
  type: NodePort
  ports:
  - port: 8080
    targetPort: 8080
    # 把jenkins 8080 端口绑定集群30800 
    nodePort: 30800
    name: web
  - port: 50000
    targetPort: 50000
    name: agent
  selector:
    app: jenkins
```

### 1.1.4 启动jenkins
  把jenkins部署到kubernetes kube-system 命名空间里面. 
```
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: jenkins
spec:
  replicas: 1
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 2
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      containers:
      - name: jenkins
        image: jenkins:2.60.3-alpine
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 8080
          name: web
          protocol: TCP
        - containerPort: 50000
          name: agent
          protocol: TCP
        volumeMounts:
        - name: jenkinshome
          mountPath: /var/jenkins_home
        env:
        - name: JAVA_OPTS
          value: "-Duser.timezone=Asia/Shanghai"
      volumes:
      - name: jenkinshome
        persistentVolumeClaim:
          claimName: jenkins-pvc
```

  把jenkins部署到kubernets上
```
$kubectl create -f jenkins-master-controller.yml
``` 
