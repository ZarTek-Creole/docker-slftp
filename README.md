# Docker-slftp
slftp version docker

# Download
```
git clone https://github.com/ZarTek-Creole/docker-slftp.git slftp
```

# Install 
copy config files (backups) to slftp/example/slftp/slftp_data
```
cd slftp/example/slftp
docker-compose build slftp
docker-compose up -d
```

# Show logs
```
docker-compose logs slftp
```
# Connect to slftp from host
```
docker exec -it slftp slftp_screen
```

# Commands in container
 - slftp_run    -> Start an screen session with slftp (auto on startup)
 - slftp_screen -> Join the screen (docker exec -it <slftp> -it slftp_screen)
 - CTRL+a d       -> leave screen
 
 # Todo
 - use multi stage builds -> https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds (THANK to harrox)
 - Clean list of packages
 
  # Bugs, error, idea, ..
  https://github.com/ZarTek-Creole/docker-slftp/issues/new
  
  # Donation
  https://github.com/ZarTek-Creole/DONATE
