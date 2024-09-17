@REM // 复制依赖
@REM docker cp images/hadoop/cp_dependencies.sh bigdata-docker-master1-1:/app/hadoop
@REM docker cp images/hadoop/cp_dependencies.sh bigdata-docker-master2-1:/app/hadoop
@REM docker cp images/hadoop/cp_dependencies.sh bigdata-docker-worker1-1:/app/hadoop
@REM docker cp images/hadoop/cp_dependencies.sh bigdata-docker-worker2-1:/app/hadoop
@REM docker cp images/hadoop/cp_dependencies.sh bigdata-docker-worker3-1:/app/hadoop
@REM docker exec bigdata-docker-master1-1 sh /app/hadoop/cp_dependencies.sh
@REM docker exec bigdata-docker-master2-1 sh /app/hadoop/cp_dependencies.sh
@REM docker exec bigdata-docker-worker1-1 sh /app/hadoop/cp_dependencies.sh
@REM docker exec bigdata-docker-worker2-1 sh /app/hadoop/cp_dependencies.sh
@REM docker exec bigdata-docker-worker3-1 sh /app/hadoop/cp_dependencies.sh
@REM  启动hdfs
@REM docker exec  bigdata-docker-master1-1 /bin/bash /app/hadoop/sbin/stop-all.sh
docker exec  bigdata-docker-master1-1 /bin/bash /app/hadoop/sbin/start-all.sh
timeout /T 10 /NOBREAK
@REM // 启动hive
docker exec bigdata-docker-hive-1 /bin/bash /app/hive/start_hive.sh
@REM sleep 10秒用于hdfs的初始化
timeout /T 5 /NOBREAK
@REM 启动spark-thrfit
docker exec bigdata-docker-spark-1 /bin/bash /app/spark/start_thrift.sh
@REM // 启动zeppelin
@REM docker exec bigdata-docker-zeppelin-1 /bin/bash /app/zeppelin/bin/zeppelin-daemon.sh start
@REM 创建topic test
@REM docker exec kafka kafka-topics.sh --bootstrap-server kafka:9092 --create --topic example --partitions 1 --replication-factor 1
@REM 启动canal
@REM docker exec canal sh /opt/canal/bin/startup.sh
@REM 提交任务
@REM ./bin/flink run-application -t yarn-application -t yarn-application -c com.fishsun.bigdata.flink.Kafka2IcebergApp /root/mock-cdc-1.0-SNAPSHOT-jar-with-dependencies.jar iceberg.catalog.type=hive iceberg.uri=thrift://hive:9083 hive.catalog.name=hive_iceberg hive.namespace.name=test hive.table.name=t_busi_detail_flink

@REM ./bin/flink run -m localhost:6123 -p 1 -c com.fishsun.bigdata.flink.Kafka2IcebergApp /root/kafka2iceberg-1.0-SNAPSHOT-jar-with-dependencies.jar iceberg.catalog.type=hive iceberg.uri=thrift://hive:9083 hive.catalog.name=hive_iceberg hive.namespace.name=test hive.table.name=t_busi_detail_flink_2 bootstrap.servers=kafka:9092 topics=example group.id=flink-group source-database=test source-table=t_busi_detail fields.bid.seq=1 fields.bid.type=bigint fields.bid.is_nullable=false fields.bid.is_primary_key=true fields.user_id.seq=2 fields.user_id.type=bigint fields.user_id.is_nullable=true fields.user_id.is_primary_key=false fields.goods_id.seq=3 fields.goods_id.type=int fields.goods_id.is_nullable=true fields.goods_id.is_primary_key=false fields.goods_cnt.seq=4 fields.goods_cnt.type=bigint fields.goods_cnt.is_nullable=true fields.goods_cnt.is_primary_key=false fields.fee.seq=5 'fields.fee.type=decimal(16,4)' fields.fee.is_nullable=true fields.fee.is_primary_key=false fields.collection_time.seq=6 fields.collection_time.type=timestamp_ntz fields.collection_time.is_nullable=true fields.collection_time.is_primary_key=false fields.order_time.seq=7 fields.order_time.type=timestamp_ntz fields.order_time.is_nullable=true fields.order_time.is_primary_key=false fields.is_valid.seq=8 fields.is_valid.type=int fields.is_valid.is_nullable=true fields.is_valid.is_primary_key=false fields.create_time.seq=9 fields.create_time.type=timestamp_ntz fields.create_time.is_nullable=true fields.create_time.is_primary_key=false fields.update_time.seq=10 fields.update_time.type=timestamp_ntz fields.update_time.is_nullable=true fields.update_time.is_primary_key=false fields.offset.seq=11 fields.offset.type=bigint fields.offset.is_nullable=true fields.offset.is_primary_key=false fields.partition_idx.seq=12 fields.partition_idx.type=int fields.partition_idx.is_nullable=true fields.partition_idx.is_primary_key=false fields.is_cdc_delete.seq=13 fields.is_cdc_delete.type=bool fields.is_cdc_delete.is_nullable=false true.is_cdc_delete.is_primary_key=false fields.es.seq=14 fields.es.type=bigint fields.es.is_nullable=true fields.es.is_primary_key=false fields.ts.seq=15 fields.ts.type=bigint fields.ts.is_nullable=true fields.ts.is_primary_key=false fields.dt.seq=16 fields.dt.type=date fields.dt.is_nullable=false fields.dt.is_primary_key=true fields.dt.ref=data.create_time 

./bin/flink run -m localhost:6123 -p 1 -c com.fishsun.bigdata.flink.Kafka2IcebergApp /root/flink-app-1.0-SNAPSHOT-jar-with-dependencies.jar iceberg.catalog.type=hive iceberg.uri=thrift://hive:9083 hive.catalog.name=hive_iceberg hive.namespace.name=test hive.table.name=t_busi_detail_flink_2 bootstrap.servers=kafka:9092 topics=example group.id=flink-group source-database=test source-table=t_busi_detail fields.bid.is_primary_key=true fields.dt.is_primary_key=true fields.dt.ref=data.create_time
./bin/flink run-application -t yarn-application -t yarn-application -c com.fishsun.bigdata.flink.Kafka2IcebergApp /root/kafka2iceberg-1.0-SNAPSHOT-jar-with-dependencies.jar iceberg.catalog.type=hive iceberg.uri=thrift://hive:9083 hive.catalog.name=hive_iceberg hive.namespace.name=test hive.table.name=t_busi_detail_flink_2 bootstrap.servers=kafka:9092 topics=example group.id=flink-group source-database=test source-table=t_busi_detail fields.bid.is_primary_key=true fields.dt.is_primary_key=true fields.dt.ref=data.create_time