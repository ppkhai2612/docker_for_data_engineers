# base image
# working dir of this image is /opt/spark/work-dir
FROM deltaio/delta-docker:0.8.1_2.3.0

# set the username
USER root

# install libs
COPY ./requirements.txt ./
RUN pip install -r requirements.txt

# copy SQL scripts to working dir
COPY ./setup.sql ./count.sql ./

# copy tpch data generator into the image
COPY ./tpch-dbgen ./tpch-dbgen/

# install rsync
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    rsync && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# SPARK_HOME=/opt/spark
COPY ./conf/spark-defaults.conf "$SPARK_HOME/conf/spark-defaults.conf"
COPY ./conf/metrics.properties "$SPARK_HOME/conf/metrics.properties"
ENV SPARK_CONF_DIR="$SPARK_HOME/conf"
ENV SPARK_MASTER="spark://spark-master:7077"
ENV SPARK_MASTER_HOST spark-master
ENV SPARK_MASTER_PORT 7077
ENV PYSPARK_PYTHON python3

# create and event logging directory to store job logs
RUN mkdir /tmp/spark-events

RUN chmod u+x /opt/spark/sbin/* && \
    chmod u+x /opt/spark/bin/*

ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
ENV PYTHONPATH=/opt/spark/work-dir/capstone/:$PYTHONPATH
ENV PYTHONPATH=/opt/spark/work-dir/etl/:$PYTHONPATH

# run script when containers start
COPY entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]