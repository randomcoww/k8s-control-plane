### Container for Kubernetes control plane components

https://github.com/kubernetes/kubernetes

- API server
- Controller manager
- Scheduler

Latest release

```bash
TAG=$(curl -s https://api.github.com/repos/kubernetes/kubernetes/releases/latest |grep tag_name | cut -d '"' -f 4)
git tag -a $TAG
git push origin $TAG
```
