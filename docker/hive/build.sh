docker buildx build \
-t yonryzhu/hive:3.1.3 \
--build-arg "BUILD_ENV=archive" \
--build-arg "HIVE_VERSION=3.1.3" \
--build-arg "HADOOP_VERSION=3.1.0" \
--build-arg "TEZ_VERSION=0.9.1" \
--platform=linux/arm64 \
.
