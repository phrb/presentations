cd node-bulletin-board/bulletin-board-app
sudo docker image build --tag bulletinboard:1.0 .
sudo docker container run --publish 8000:8080 --detach --name bb bulletinboard:1.0
