echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker buid -t gorbar/multi-client ./client
docker buid -t gorbar/multi-server ./server
docker buid -t gorbar/multi-worker ./worker
docker buid -t gorbar/multi-client:$SHA ./client
docker buid -t gorbar/multi-server:$SHA ./server
docker buid -t gorbar/multi-worker:$SHA ./worker
docker push gorbar/multi-client
docker push gorbar/multi-server
docker push gorbar/multi-worker
docker push gorbar/multi-client:$SHA
docker push gorbar/multi-server:$SHA
docker push gorbar/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=gorbar/multi-client:$SHA
kubectl set image deployments/server-deployment server=gorbar/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=gorbar/multi-worker:$SHA
