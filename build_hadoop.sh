# cp -r thirdparty images/hadoop/thridparty
docker build -t hadoop:1.0 images/hadoop/
docker image prune -f