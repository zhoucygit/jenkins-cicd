---
apiVersion: v1
kind: Service
metadata:
  name: {app_name}
  namespace: {namespace}
spec:
  type: ClusterIP
  selector:
    app: {app_name}
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
