# Kubernetes in Docker Enterprise Edition

## Pre-reqs

PWD intro

Setup:

```
mkdir scm

cd scm

git clone https://github.com/dockersamples/hybrid-app.git

git clone https://github.com/sixeyed/docker-kube-workshop.git
```

## Docker Trusted Registry

enable scanning:

![](./img/part-2/dtr-enable-image-scanning.jpg)

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
cd ~/scm/docker-kube-workshop

./part-2/dtr-01-create-repos.sh

./part-2/dtr-02-set-repo-access.sh
```

1.2 build & push

```
cd ~/scm/hybrid-app/scripts

./scripts/01-build.sh
```

Login with your human account:

```
docker login $DTR_HOST

./scripts/02-ship.sh
```

> FAIL! The human does not have permissions to push images

Now log in as Jenkins (in the real world, the CI user credentials would be secrets stored in Jenkins):

```
docker login $DTR_HOST --username jenkins

./scripts/02-ship.sh
```

![](./img/part-2/pwd-push-to-dtr.jpg)

![](./img/part-2/dtr-image-pushed.jpg)

## Universal Control Plane

* deploy v1 as kube stack

Inject DTR name:

```
docker-compose -f hybrid-app-v1/yml config > hybrid-app-v1-dtr.yml
```

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

![](./img/part-2/ucp-user-profile.jpg)

![](./img/part-2/ucp-user-profile-2.jpg)

```
cat env.sh

cat kube.yml

eval "$(<env.sh)"
```

* kubectl get all, logs, exec

```

```
