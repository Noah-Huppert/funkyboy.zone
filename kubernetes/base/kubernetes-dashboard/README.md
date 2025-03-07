# Kubernetes Dashboard
Default Kubernetes dashboard.

# Table Of Contents
- [Overview](#overview)
- [Operations](#operations)

# Overview
Default Kubernetes dashboard.

Setup using [these instructions](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/). The `./resources/manifests.yaml` file's contents are the curl contents from this tutorial.

# Operations
To get a service account token to login:

```
kubectl -n kubernetes-dashboard get secret admin-user-token -o go-template='{{ .data.token | base64decode }}'
```

To access the dashboard run:

```
kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard 8443:443
```

Access the dashboard on [https://localhost:8443](https://localhost:8443) (You will get a warning about an invalid certificate, ignore this). Use the token from above to authenticate.
