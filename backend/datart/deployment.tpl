apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: datart-data-storage
  namespace: {namespace}
spec:
  accessModes: [ "ReadWriteOnce" ]
  storageClassName: local-path-storage
  resources:
    requests:
      storage: 10Gi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {app_name}
  namespace: {namespace}
  labels:
    app: {app_name}
spec:
  selector:
    matchLabels:
      app: {app_name}
  replicas: {replicas}
  template:
    metadata:
      labels:
        app: {app_name}
    spec:
        enableServiceLinks: false
        imagePullSecrets:
        - name: harbor-secret
        containers:
        - name: {app_name}
          image: {image_url}
          imagePullPolicy: IfNotPresent
          readinessProbe:
            tcpSocket:
              port: 8080
            initialDelaySeconds: 30
            successThreshold: 1
            failureThreshold: 3
            periodSeconds: 10
            timeoutSeconds: 3
          livenessProbe:
            tcpSocket:
              port: 8080
            initialDelaySeconds: 60
            successThreshold: 1
            failureThreshold: 3
            periodSeconds: 10
            timeoutSeconds: 3
          ports:
          -  containerPort: 8080
          env:
            - name: JAVA_OPTS
              value: "{java_opts}  -Dserver.port=8080"
          volumeMounts:
            - name: {app_name}-config-volume
              mountPath: /app/{app_name}/config/{config_file}
              subPath: {config_file}
            - name: datart-storage
              mountPath: /app/{app_name}/files
          resources:
            requests:
              cpu: 100m
              memory: 500Mi
            limits:
              cpu: {cpu_limit}
              memory: {memory_limit}
        volumes:
          - name: {app_name}-config-volume
            configMap:
              name: {app_name}-config
              items:
              - key: {config_file}
                path: {config_file}
          - name: datart-storage
            persistentVolumeClaim:
              claimName: datart-data-storage
