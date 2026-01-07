FROM apache/airflow:2.8.0-python3.11

USER root

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER airflow

# Install Python packages
RUN pip install --no-cache-dir \
    dbt-core==1.7.4 \
    dbt-trino==1.7.1 \
    apache-airflow-providers-trino \
    trino \
    pymysql \
    cryptography

# Set working directory
WORKDIR /opt/airflow
