docker run -d \
  --name spark-master \
  --entrypoint ./entrypoint.sh \
  -p 4040:4040 \
  -p 9090:8080 \
  -p 7077:7077 \
  -v "$(pwd)/capstone:/opt/spark/work-dir/capstone" \
  -v "$(pwd)/data-processing-spark:/opt/spark/work-dir/data-processing-spark" \
  -v spark-logs:/opt/spark/spark-events \
  -v tpch-data:/opt/spark/tpch-dbgen \
  --env-file .env.spark \
  spark-image master