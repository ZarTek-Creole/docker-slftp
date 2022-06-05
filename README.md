[<span class="badge-opencollective"><a href="https://github.com/ZarTek-Creole/DONATE" title="Donate to this project"><img src="https://img.shields.io/badge/open%20collective-donate-yellow.svg" alt="Open Collective donate button" /></a></span>
[![CC BY 4.0][cc-by-shield]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
[![CC BY 4.0][cc-by-shield]][cc-by]
This work is licensed under a [Creative Commons Attribution 4.0 International License][cc-by].
[![CC BY 4.0][cc-by-image]][cc-by]
[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg

 <span class="badge-opencollective"><a href="https://github.com/ZarTek-Creole/DONATE" title="Donate to this project"><img src="https://img.shields.io/badge/open%20collective-donate-yellow.svg" alt="Open Collective donate button" /></a></span>
# Docker-slftp
slftp version docker

# Download
```
git clone github.com/ZarTek-Creole/docker-slftp.git slftp
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
  github.com/ZarTek-Creole/docker-slftp/issues/new
  
  # Donation
  github.com/ZarTek-Creole/DONATE
