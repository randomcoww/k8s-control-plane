### Container for Kubernetes components

https://github.com/kubernetes/kubernetes

- API server
- Controller manager
- Scheduler
- Kube proxy

Latest release

```bash
curl -s https://api.github.com/repos/kubernetes/kubernetes/releases/latest | grep tag_name | cut -d '"' -f 4 | tr -d 'v'
```
