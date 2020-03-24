FROM jenkins/jnlp-slave:3.27-1-alpine

USER root

ENV HELM_VERSION="v2.16.3"
ENV KUBE_LATEST_VERSION="v1.17.4"

RUN apk add --no-cache ca-certificates bash docker git openssh curl \
	  && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm

USER jenkins

ENTRYPOINT ["jenkins-slave"]
