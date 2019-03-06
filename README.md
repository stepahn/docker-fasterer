# fasterer

dockerized https://github.com/DamirSvrtan/fasterer

docker build -t fasterer .
docker run --rm -ti -v $(PWD):/workdir fasterer app
