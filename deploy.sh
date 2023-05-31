docker build -t mikethan/multi-client:latest -t mikethan/multi-client:$SHA -f .client/Dockerfile ./client
docker build -t mikethan/multi-server:latest -t mikethan/multi-server:$SHA -f .server/Dockerfile ./server
docker build -t mikethan/multi-worker:latest -t mikethan/multi-worker:$SHA -f .worker/Dockerfile ./worker
docker push mikethan/multi-client:latest
docker push mikethan/multi-server:latest
docker push mikethan/multi-worker:latest
docker push mikethan/multi-client:$SHA
docker push mikethan/multi-server:$SHA
docker push mikethan/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mikethan/multi-server:$SHA
kubectl set image deployments/client-deployment client=mikethan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mikethan/multi-worker:$SHA


