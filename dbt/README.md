# Retail Data Warehouse - dbt Project

This dbt project transforms raw retail data into a dimensional model suitable for analytics.

## Architecture

- **Source**: MySQL (OLTP retail database)
- **Query Engine**: Trino
- **Transformation**: dbt Core
- **Orchestration**: Apache Airflow

## Project Structure

```
models/
├── staging/        # Staging models (views)
├── dimension/      # Dimension tables (SCD Type 2)
├── fact/          # Fact tables
└── mart/          # Data marts for specific use cases
```

## Data Model

### Staging Layer
- Raw data from source systems with minimal transformations

### Dimension Layer
- dim_customer
- dim_product
- dim_store
- dim_shipper
- dim_date

### Fact Layer
- fact_sales

### Mart Layer
- mart_sales_summary
- mart_product_performance
