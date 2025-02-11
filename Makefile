all: up

up:
	docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml down

clean:
	docker container prune -f
	docker volume rm $(docker volume ls -q)
	docker rmi -f $(docker images -q)

get-key: jenkins-key nexus-key

jenkins-key:
	echo -e "\033[0;32mJenkins key:\033[0m"
	docker exec jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword

# forse il container si chiama nexus e non ubuntu_nexus_1
nexus-key:
	echo -e "\033[0;nexus key:\033[0m"
	sudo docker exec ubuntu_nexus_1 cat /nexus-data/admin.password 
