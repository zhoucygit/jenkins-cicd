FROM registry.cn-beijing.aliyuncs.com/basetools/oracle-jdk:8u291
MAINTAINER mulw156 <mulw156@tydic.com>
ARG app_name
RUN mkdir -p /app/${app_name}
COPY ./bin/ /app/${app_name}/bin/
COPY ./config/ /app/${app_name}/config/
COPY ./lib/ /app/${app_name}/lib/
ENV TZ=Asia/Shanghai
EXPOSE 8080
WORKDIR /app/${app_name}
ENV JAVA_INIT_OPTS="-XX:+UseContainerSupport -XX:InitialRAMPercentage=75.0 -XX:MaxRAMPercentage=75.0 -XX:MinRAMPercentage=75.0 -XX:+UseConcMarkSweepGC -XX:+UseParNewGC"
ENTRYPOINT java $JAVA_OPTS $JAVA_INIT_OPTS -cp "lib/*" datart.DatartServerApplication
