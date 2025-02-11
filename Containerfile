FROM golang:alpine as BUILD
ARG VERSION=v1.32.1

WORKDIR /go/src
RUN set -x \
  \
  && apk add --no-cache \
    git \
    make \
    bash \
    rsync \
  \
  && git clone --depth 1 -b $VERSION https://github.com/kubernetes/kubernetes.git \
  && cd kubernetes \
  && make \
    kube-apiserver \
    kube-controller-manager \
    kube-scheduler

FROM scratch

COPY --from=BUILD /go/src/kubernetes/_output/bin/kube-apiserver /usr/local/bin/
COPY --from=BUILD /go/src/kubernetes/_output/bin/kube-controller-manager /usr/local/bin/
COPY --from=BUILD /go/src/kubernetes/_output/bin/kube-scheduler /usr/local/bin/
