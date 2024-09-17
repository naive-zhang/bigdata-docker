# 初始化hdfs并且启动
docker exec  bigdata-docker-master1-1 /bin/bash /app/hadoop/init_hadoop_master.sh
# 初始化hive
docker exec  bigdata-docker-hive-1 /bin/bash /app/hive/init_hive.sh
# 启动zeppelin
docker exec bigdata-docker-zeppelin-1 /bin/bash /app/zeppelin/bin/zeppelin-daemon.sh start