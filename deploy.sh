docker build -t ligangjapan/multi-client:latest -t ligangjapan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ligangjapan/multi-server:latest -t ligangjapan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ligangjapan/multi-worker:latest -t ligangjapan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ligangjapan/multi-client:latest 
docker push ligangjapan/multi-server:latest 
docker push ligangjapan/multi-worker:latest

docker push ligangjapan/multi-client:$SHA 
docker push ligangjapan/multi-server:$SHA 
docker push ligangjapan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment  server=ligangjapan/multi-server:$SHA
kubectl set image deployments/client-deployment  client=ligangjapan/multi-client:$SHA
kubectl set image deployments/worker-deployment  worker=ligangjapan/multi-worker:$SHA
