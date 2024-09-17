# 确保进程不存在或者被kill掉防止出现问题
kill -9 $(lsof -i tcp:10086 | grep java | awk '{print $2}')
# 确保event-logs有地方可以正常存放
/app/hadoop/bin/hdfs dfs -mkdir -p /spark/event-logs
# 启动thrift服务用于容器外测试
/app/spark/sbin/start-thriftserver.sh \
    --hiveconf hive.server2.thrift.port=10086 \
    --hiveconf hive.server2.thrift.bind.host=0.0.0.0 \
    --master local[4]
    # --master yarn \
    # --driver-memory 1g \
    # --executor-memory 1g \
    # --num-executors 1 \
    # --executor-cores 2