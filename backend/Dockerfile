FROM registry.cn-beijing.aliyuncs.com/basetools/oracle-jdk:8u291
MAINTAINER mulw156 <mulw156@tydic.com>
RUN /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 && /usr/glibc-compat/bin/localedef -i zh_CN -f UTF-8 zh_CN.UTF-8
ARG app_name
ARG jar_file
ENV WORK_PATH="/app/${app_name}"
ENV JAR_FILE=${WORK_PATH}/${jar_file}
RUN mkdir -p ${WORK_PATH}
copy ${jar_file} $WORK_PATH/
WORKDIR ${WORK_PATH}
ENV JAVA_INIT_OPTS="-XX:+UseContainerSupport -XX:InitialRAMPercentage=75.0 -XX:MaxRAMPercentage=75.0 -XX:MinRAMPercentage=75.0 -XX:+UseConcMarkSweepGC -XX:+UseParNewGC"
CMD java ${JAVA_OPTS} ${JAVA_INIT_OPTS} -jar ${JAR_FILE}
EXPOSE 8080
