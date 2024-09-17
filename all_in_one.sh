# 构建镜像
./build_hadoop.sh
# 启动容器
docker-compose up -d
# 执行所有的初始化脚本
./init_all_containers.sh