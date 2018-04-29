# Kubernetes in Docker Enterprise Edition

## Pre-reqs

PWD intro

## Docker Trusted Registry

1.0 in UI:

-- create org

![](./img/part-2/dtr-new-org.jpg)

![](./img/part-2/dtr-new-org-2.jpg)

-- create first repo

![](./img/part-2/dtr-new-repo.jpg)
![](./img/part-2/dtr-new-repo-2.jpg)

-- create team CI & user

![](./img/part-2/dtr-new-team.jpg)

![](./img/part-2/dtr-new-user.jpg)

-- create team humans & user

![](./img/part-2/dtr-new-team-2.jpg)

![](./img/part-2/dtr-new-user-2.jpg)

-- get access key > env

![](./img/part-2/dtr-profile.jpg)

![](./img/part-2/dtr-new-access-token.jpg)

![](./img/part-2/dtr-new-access-token-2.jpg)

![](./img/part-2/dtr-new-access-token-3.jpg)

1.1 script

```
export DTR_HOST=<your-DTR-domain>
export DTR_USERNAME=<your-DTR-admin-username>
export DTR_API_KEY=<your-api-key>
```

```
chmod +x ./part-2/dtr-01-create-repos.sh
./part-2/dtr-01-create-repos.sh
```

```
chmod +x ./part-2/dtr-02-set-repo-access.sh
./part-2/dtr-02-set-repo-access.sh
```

1.2 build & push

```
git clone...
cd ...
./scripts/01-build.sh
./scripts/02-ship.sh
```

> TODO - DTR image pic

## Universal Control Plane

* deploy v1 as kube

![](./img/part-2/ucp-create-stack.jpg)

![](./img/part-2/ucp-create-stack-2.jpg)

* check app via load balancer

![](./img/part-2/ucp-kube-load-balancers.jpg)

![](./img/part-2/signup-homepage.jpg)

* configure stack, deploy v2

![](./img/part-2/ucp-stack-configure.jpg)

![](./img/part-2/ucp-stack-configure-2.jpg)

![](./img/part-2/ucp-kube-pods.jpg)

![](./img/part-2/ucp-kube-load-balancers-v2.jpg)

* check app

![](./img/part-2/ucp-container-logs.jpg)

![](./img/part-2/ucp-container-logs-2.jpg)

## Managing Kubernetes on Docker EE from Docker for Mac and Docker for Windows

* download client bundle to laptop

![](./img/part-2/ucp-container-logs.jpg)

![](./img/part-2/ucp-container-logs-2.jpg)

* cat kube.yml
* kubectl get all, logs, exec
