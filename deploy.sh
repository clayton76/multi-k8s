docker build -t clayton76/multi-client:latest -t clayton76/multi-client:$SHA -f .client/Dockerfile ./client
docker build -t clayton76/multi-server:latest -t clayton76/multi-server:$SHA  -f .server/Dockerfile ./server
docker build -t clayton76/multi-worker:latest -t clayton76/multi-worker:$SHA  -f .worker/Dockerfile ./worker
docker push clayton76/multi-client:latest
docker push clayton76/multi-server:latest
docker push clayton76/multi-worker:latest
docker push clayton76/multi-client:$SHA
docker push clayton76/multi-server:$SHA
docker push clayton76/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=clayton76/multi-server:$SHA
kubectl set image deployments/client-deployment client=clayton76/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=clayton76/multi-worker:$SHA