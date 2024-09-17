source /etc/profile
# hive 元数据启动 
nohup /app/hive/bin/hive --service metastore > /app/hive/logs/metastore.log 2>&1 &
# hive thift2服务器启动
nohup /app/hive/bin/hive --service hiveserver2 > /app/hive/logs/hiveserver2.log 2>&1 &
