docker build -t scrouncha/fibo-client:latest -t scrouncha/fibo-client:$SHA -f ./client/Dockerfile ./client
docker build -t scrouncha/fibo-server:latest -t scrouncha/fibo-server:$SHA -f ./server/Dockerfile ./server
docker build -t scrouncha/fibo-worker:latest -t scrouncha/fibo-worker:$SHA -f ./worker/Dockerfile ./worker

docker push scrouncha/fibo-client:latest
docker push scrouncha/fibo-server:latest
docker push scrouncha/fibo-worker:latest

docker push scrouncha/fibo-client:$SHA
docker push scrouncha/fibo-server:$SHA
docker push scrouncha/fibo-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=scrouncha/fibo-server:$SHA
kubectl set image deployments/client-deployment client=scrouncha/fibo-client:$SHA
kubectl set image deployments/worker-deployment worker=scrouncha/fibo-worker:$SHA
