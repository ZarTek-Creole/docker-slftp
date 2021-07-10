Example Setup
===

# !!!IMPORTANT!!! NOT FOR PRODUCTION USE !!!IMPORTANT!!!

Don't try to use this example compose setup for production. You will only hurt yourself and your users!

This setup is mainly to quickly bootstrap a test setup during development to check back changes.

## How to use

Edit the `docker-compose.yml` and run `docker-compose up -d`.

If you need to check back something in Anope's filesystem run:

```console
docker exec -it $(docker-compose ps -q services) /bin/sh
```

To check everything is up and running:

```console
docker-compose ps
```

To rebuild anope after you did changes to the image sources:

```console
docker-compose build services
```



