# The Secure Software Supply Chain with Kubernetes and Docker EE

setup

* delete stack in ucp
* create namespace in Kube

```
kubectl create namespace hybrid-app
```

dtr

* promotion policies

- new org `production`
- new repo `hybrid-app-db`

![]()

* scanning

- push updated db

```
docker image build --tag $DTR_HOST/dockersamples/hybrid-app-db:v2 --file ./Dockerfile.v2

docker image push $DTR_HOST/dockersamples/hybrid-app-db:v2
```

ucp

* teams - see inherited from DTR
  -- add tester user & team
  -- check repo access in DTR

* collections
  -- add grant View Only for Kube namespace for tester
  -- create Node Manager role w/ all nodes operations & add tester
  -- login, can only see one ns, but can manage nodes

* content trust
* signing
