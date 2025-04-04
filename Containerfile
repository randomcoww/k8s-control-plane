FROM golang:alpine as BUILD
ARG VERSION

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
    kube-scheduler \
    kube-proxy

FROM scratch AS control_plane

COPY --from=BUILD /go/src/kubernetes/_output/bin/kube-apiserver /usr/local/bin/
COPY --from=BUILD /go/src/kubernetes/_output/bin/kube-controller-manager /usr/local/bin/
COPY --from=BUILD /go/src/kubernetes/_output/bin/kube-scheduler /usr/local/bin/

FROM alpine:edge AS kube_proxy

COPY --from=BUILD /go/src/kubernetes/_output/bin/kube-proxy /usr/local/bin/
RUN set -x \
  \
  && apk add --no-cache \
    conntrack-tools \
    nftables \
    iptables \
    ipset \
    kmod