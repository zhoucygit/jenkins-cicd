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
            httpGet:
              path: /healthcheck
              port: 80
            initialDelaySeconds: 10
            failureThreshold: 3
            periodSeconds: 5
            timeoutSeconds: 3
          livenessProbe:
            httpGet:
              path: /healthcheck
              port: 80
            initialDelaySeconds: 30
            successThreshold: 1
            failureThreshold: 3
            periodSeconds: 5
            timeoutSeconds: 3
          ports:
          -  containerPort: 80
          env:
            - name: TZ
              value: Asia/Shanghai
          volumeMounts:
            - name: {app_name}-config-volume
              mountPath: /etc/nginx/{config_file}
              subPath: {config_file}
          resources:
            requests:
              cpu: 100m
              memory: 100Mi
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
