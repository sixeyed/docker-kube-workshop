# Kubernetes in Docker for Mac and Docker for Windows

## Pre-reqs

Mac:

```
brew install jq
brew install kubernetes-helm

export HELM_HOME=~/helm
helm init
```

Add `docker.for.mac.localhost:5000` as insecure registry.

Windows

```
choco install jq
choco install kubernetes-helm

$env:HELM_HOME=$(~/helm)
helm init
```

Add `docker.for.win.localhost:5000` as insecure registry.

# 0.1 Setup Kubernetes & verify

Preferences...Kubernetes

```
kubectl version

docker version -f '{{ .Client.Orchestrator }}'
```

> Updating Docker will update Kubernetes, right now it's 1.9

# 1 - Stateless deployments & stacks

# 1.1 - Simple deployment with load balanced service

```
kubectl apply -f ./part-1/nginx-deployment.yaml

kubectl get all
```

> Browse to [localhost:8081](http://localhost:8081)

```
curl http://localhost:8081
```

Get pod name; exec into pod:

```
pod=$(kubectl get pods -o json | jq -r '.items[0].metadata.name')

kubectl exec -it $pod sh

cd /usr/share/nginx/html

echo '<h1>This is v3</h1>' > index.html

exit
```

Refresh without cache (shift cmd-R) or:

```
curl --keepalive-time 0 http://localhost:8081
```

# 1.3 - Deploy compose stack to Kube

```
docker version -f '{{ .Client.Orchestrator }}'
```

> You can switch orchestrators with the `DOCKER_ORCHESTRATOR` environment variable, setting it to `kubernetes` or `swarm`.

Deploy:

```
docker stack deploy -c ./part-1/nginx2-compose.yaml nginx2

docker stack ls

kubectl get deployments
```

> Browse to [localhost:8082](http://localhost:8082)

```
curl -v http://localhost:8082
```

# 1.4 - Patch kube

```
kubectl patch deployment nginx2 --patch "$(cat ./part-1/nginx2-patch.yaml)"
```

curl and check server version

```
curl -v http://localhost:8082
```

# 1.5 Deploy Compose to Swarm

```
docker swarm init

export DOCKER_ORCHESTRATOR=swarm

docker stack deploy -c ./part-1/nginx3-compose.yaml nginx3
```

> Browse to [localhost:8083](http://localhost:8083)

```
curl -v http://localhost:8083
```

# 1.6 - Clean Up

Swarm stack:

```
docker stack rm nginx3
```

Kube stack:

```
export DOCKER_ORCHESTRATOR=kubernetes

docker stack rm nginx2

kubectl get all
```

Native Kube deployment:

```
kubectl delete deployment nginx-deployment

kubectl delete svc nginx
```

# 2 - Stateful services and PVs

# 2.1 Deploy MySQL

Run mysql with PV

```
kubectl apply -f ./part-1/mysql-deployment.yaml
```

Check the PV:

```
path=$(kubectl get pv -o json | jq -r '.items[0].spec.hostPath.path')

cd $path

ll
```

MySQL shell:

```
kubectl run -it --rm --image=mysql:8.0.11 --restart=Never mysql-client -- mysql -h mysql -ppassword

CREATE USER 'k8s'@'localhost' IDENTIFIED BY 'kubernetes';
```

# 2.2 Recreate MySQL

Replace deployment:

```
kubectl delete deployment mysql

kubectl apply -f ./part-1/mysql-deployment.yaml
```

Verify original data still available:

```
kubectl run -it --rm --image=mysql:8.0.11 --restart=Never mysql-client -- mysql -h mysql -ppassword

SELECT User FROM mysql.user;
```

# 3 - Helm

Initiliaze & check Tiller:

```
helm init --debug

kubectl get svc -n kube-system
```

Deploy Docker Registry:

```
helm install --name registry \
 --set service.type=LoadBalancer \
 --set persistence.enabled=true \
 stable/docker-registry

curl http://localhost:5000/v2/_catalog
```

Tag and push an image:

```
docker image pull alpine:3.7

docker image tag alpine:3.7 docker.for.mac.localhost:5000/my-alpine:gold

docker image push docker.for.mac.localhost:5000/my-alpine:gold

curl http://localhost:5000/v2/_catalog
```

Clean up:

```
helm delete --purge registry
```
