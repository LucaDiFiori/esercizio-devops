all: up

up:
	docker compose -f ./srcs/docker-compose.yml up --build

down:
	docker compose -f ./srcs/docker-compose.yml down

clean:
	docker container prune -f
	docker volume ls -q | xargs -r docker volume rm
	docker images -q | xargs -r docker rmi -f


# Per ottenere le chiavi di accesso ai servizi
get-credential: jenkins-key nexus-key gitlab-key

jenkins-key:
	@echo -e "\033[0;32mDefault Jenkins key:\033[0m"
	@docker exec jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword
	@echo "" 

# forse il container si chiama nexus e non ubuntu_nexus_1
nexus-key:
	@echo -e "\033[0;32mDefault Nexus User: admin\033[0m"
	@echo -e "\033[0;32mDefault Nexus key:\033[0m"
	@docker exec nexus cat /nexus-data/admin.password 
	@echo "" 

# Lo username è "root"
gitlab-key:
	@echo ""
	@echo -e "\033[0;32mDefault Gitlab User: root\033[0m"
	@echo -e "\033[0;32mDefault Gitlab key:\033[0m"
	@docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password	
	@echo "" 
