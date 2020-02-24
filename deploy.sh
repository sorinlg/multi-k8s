docker build -t sorinlacriteanu/multi-client:latest -t sorinlacriteanu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sorinlacriteanu/multi-server:latest -t sorinlacriteanu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sorinlacriteanu/multi-worker:latest -t sorinlacriteanu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sorinlacriteanu/multi-client:latest
docker push sorinlacriteanu/multi-server:latest
docker push sorinlacriteanu/multi-worker:latest

docker push sorinlacriteanu/multi-client:$SHA
docker push sorinlacriteanu/multi-server:$SHA
docker push sorinlacriteanu/multi-worker:$SHA

kubectl apply -f k8s --validate=false

kubectl set image deployments/server-deployment server=sorinlacriteanu/multi-server:$SHA
kubectl set image deployments/client-deployment client=sorinlacriteanu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sorinlacriteanu/multi-worker:$SHA
