"""
Retail Data Warehouse ETL DAG
Orchestrates dbt transformations for the retail data warehouse

This DAG runs the complete dbt pipeline:
1. Staging models
2. Dimension models  
3. Fact models
4. Mart models
"""

from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
import logging

# Default arguments
default_args = {
    'owner': 'data_engineering',
    'depends_on_past': False,
    'start_date': datetime(2024, 1, 1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
dag = DAG(
    'retail_dw_etl',
    default_args=default_args,
    description='Retail Data Warehouse ETL Pipeline using dbt and Trino',
    schedule_interval='@daily',  # Run daily
    catchup=False,
    tags=['dbt', 'retail', 'data-warehouse'],
)

def log_start():
    """Log the start of the pipeline"""
    logging.info("Starting Retail DW ETL Pipeline")
    logging.info(f"Execution date: {datetime.now()}")

def log_end():
    """Log the end of the pipeline"""
    logging.info("Retail DW ETL Pipeline completed successfully")
    logging.info(f"Completion time: {datetime.now()}")

# Task 1: Log start
start_task = PythonOperator(
    task_id='log_start',
    python_callable=log_start,
    dag=dag,
)

# Task 2: dbt debug - check connections (allow git error - not critical)
dbt_debug = BashOperator(
    task_id='dbt_debug',
    bash_command='cd /opt/airflow/dbt && dbt debug --profiles-dir . || true',
    dag=dag,
)

# Task 3: dbt deps - install dependencies
dbt_deps = BashOperator(
    task_id='dbt_deps',
    bash_command='cd /opt/airflow/dbt && dbt deps --profiles-dir .',
    dag=dag,
)

# Task 4: dbt seed - load seed data if any
dbt_seed = BashOperator(
    task_id='dbt_seed',
    bash_command='cd /opt/airflow/dbt && dbt seed --profiles-dir . || true',
    dag=dag,
)

# Task 5: Run staging models
dbt_run_staging = BashOperator(
    task_id='dbt_run_staging',
    bash_command='cd /opt/airflow/dbt && dbt run --profiles-dir . --models staging',
    dag=dag,
)

# Task 6: Test staging models
dbt_test_staging = BashOperator(
    task_id='dbt_test_staging',
    bash_command='cd /opt/airflow/dbt && dbt test --profiles-dir . --models staging',
    dag=dag,
)

# Task 7: Run dimension models
dbt_run_dimensions = BashOperator(
    task_id='dbt_run_dimensions',
    bash_command='cd /opt/airflow/dbt && dbt run --profiles-dir . --models dimension',
    dag=dag,
)

# Task 8: Run fact models
dbt_run_facts = BashOperator(
    task_id='dbt_run_facts',
    bash_command='cd /opt/airflow/dbt && dbt run --profiles-dir . --models fact',
    dag=dag,
)

# Task 9: Run mart models
dbt_run_marts = BashOperator(
    task_id='dbt_run_marts',
    bash_command='cd /opt/airflow/dbt && dbt run --profiles-dir . --models mart',
    dag=dag,
)

# Task 10: Test all models
dbt_test_all = BashOperator(
    task_id='dbt_test_all',
    bash_command='cd /opt/airflow/dbt && dbt test --profiles-dir .',
    dag=dag,
)

# Task 11: Generate documentation
dbt_docs_generate = BashOperator(
    task_id='dbt_docs_generate',
    bash_command='cd /opt/airflow/dbt && dbt docs generate --profiles-dir .',
    dag=dag,
)

# Task 12: Log end
end_task = PythonOperator(
    task_id='log_end',
    python_callable=log_end,
    dag=dag,
)

# Define task dependencies
start_task >> dbt_debug >> dbt_deps >> dbt_seed
dbt_seed >> dbt_run_staging >> dbt_test_staging
dbt_test_staging >> dbt_run_dimensions >> dbt_run_facts
dbt_run_facts >> dbt_run_marts >> dbt_test_all
dbt_test_all >> dbt_docs_generate >> end_task
