docker build -t lucheya/multi-client:latest -t lucheya/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t lucheya/multi-server:latest -t lucheya/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t lucheya/multi-worker:latest -t lucheya/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push lucheya/multi-client:latest
docker push lucheya/multi-client:$GIT_SHA

docker push lucheya/multi-server:latest
docker push lucheya/multi-server:$GIT_SHA

docker push lucheya/multi-worker:latest
docker push lucheya/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lucheya/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=lucheya/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=lucheya/multi-worker:$GIT_SHA
