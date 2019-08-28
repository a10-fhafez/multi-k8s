docker build -t fadihafez/multi-client:latest -t fadihafez/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fadihafez/multi-server:latest -t fadihafez/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fadihafez/multi-worker:latest -t fadihafez/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push fadihafez/multi-client:latest
docker push fadihafez/multi-server:latest
docker push fadihafez/multi-worker:latest

docker push fadihafez/multi-client:$SHA
docker push fadihafez/multi-server:$SHA
docker push fadihafez/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=fadihafez/multi-server:$SHA
kubectl set image deployments/client-deployment client=fadihafez/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=fadihafez/multi-worker:$SHA