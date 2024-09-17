# 启动hdfs
docker exec  bigdata-docker-master1-1 /bin/bash 
# 启动hive
docker exec bigdata-docker-hive-1 /bin/bash /app/hive/start_hive.sh
# 启动zeppelin
docker exec bigdata-docker-zeppelin-1 /bin/bash /app/zeppelin/bin/zeppelin-daemon.sh start