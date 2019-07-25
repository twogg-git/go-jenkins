# go-jenkins
Simple CI with jenkins blue ocean.

```sh
docker run -d --name blueocean -p 8282:8080 --user root \
    -v /Users/catherincruz/Devs/jenkins:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock jenkinsci/blueocean
```

```sh
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

```sh
docker rm -f blueocean
```
