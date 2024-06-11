# Data Warehouse creation Project

This repository contains SQL scripts and instructions for creating and analyzing a data warehouse (dwh) using PostgreSQL. The project involves creating a set of tables to manage regions, sales representatives, accounts, web events, and orders. Additionally, the project includes several analytical tasks to generate insights from the data.

## Prerequisites

- PostgreSQL installed
- Access to `psql` command-line tool
- CSV data files for bulk uploading: `region.csv`, `sales_rep.csv`, `accounts.csv`, `web_events.csv`, `orders.csv` (refer to dataset folder in repo)

## Database Creation

To create the database and tables, use the provided SQL scripts.

```sql
-- Create the DWH database
CREATE DATABASE DWH;

-- Create the REGION table
CREATE TABLE REGION (
    ID INT PRIMARY KEY,
    NAME VARCHAR
);

-- Create the SALES_REP table
CREATE TABLE SALES_REP (
    ID INT PRIMARY KEY,
    NAME VARCHAR,
    REGION_ID INT,
    FOREIGN KEY (REGION_ID) REFERENCES REGION(ID)
);

-- Create the ACCOUNTS table
CREATE TABLE ACCOUNTS (
    ID INT PRIMARY KEY,
    NAME VARCHAR,
    WEBSITE VARCHAR,
    LAT FLOAT,
    LONG FLOAT,
    PRIMARY_POC VARCHAR,
    SALES_REP_ID INT,
    FOREIGN KEY (SALES_REP_ID) REFERENCES SALES_REP(ID)
);

-- Create the WEB_EVENTS table
CREATE TABLE WEB_EVENTS (
    ID INT PRIMARY KEY,
    ACCOUNT_ID INT,
    FOREIGN KEY (ACCOUNT_ID) REFERENCES ACCOUNTS(ID),
    OCCURED_AT TIMESTAMP,
    CHANNEL VARCHAR
);

-- Create the ORDERS table
CREATE TABLE ORDERS (
    ID INT PRIMARY KEY,
    ACCOUNT_ID INT,
    FOREIGN KEY (ACCOUNT_ID) REFERENCES ACCOUNTS(ID),
    OCCURED_AT TIMESTAMP,
    STANDARD_QTY INT,
    GLOSS_QTY INT,
    POSTER_QTY INT,
    TOTAL INT,
    STANDARD_AMOUNT_USD FLOAT,
    GLOSS_AMT_USD FLOAT,
    POSTER_AMT_USD FLOAT,
    TOTAL_AMT_USD FLOAT
);
```

## Bulk Uploading Data

Bulk upload data from CSV files into the corresponding tables using the following `psql` commands.

```sql
\copy REGION FROM '/path/to/region.csv' WITH DELIMITER ',' CSV HEADER;
\copy SALES_REP FROM '/path/to/sales_rep.csv' WITH DELIMITER ',' CSV HEADER;
\copy ACCOUNTS FROM '/path/to/accounts.csv' WITH DELIMITER ',' CSV HEADER;
\copy WEB_EVENTS FROM '/path/to/web_events.csv' WITH DELIMITER ',' CSV HEADER;
\copy ORDERS FROM '/path/to/orders.csv' WITH DELIMITER ',' CSV HEADER;
```

## Analytical Tasks

### Task 1: Sales Representative and Account Assignment

Join the `SALES_REP` and `ACCOUNTS` tables to retrieve sales representatives along with the accounts they are assigned to. Calculate the row number of each account per sales representative.

<figure>
  <img src="https://github.com/rohanshrma25/SQL_DatabaseCreation/assets/143126097/206722a5-e168-49ba-a006-f68368a71900" alt="Task 1" style="width:500px">
</figure>  

### Task 2: Yearly Revenue Percentage and Rank by Sales Representative

Calculate the yearly revenue percentage contributed by each sales representative. Rank the sales representatives based on their contribution to the yearly revenue.

<figure>
  <img src="https://github.com/rohanshrma25/SQL_DatabaseCreation/assets/143126097/ddc15d2f-a99b-43c7-86d6-8b7b4b8246b4" alt="Task 1" style="width:500px">
</figure>  


### Task 3: Yearly Revenue Percentage and Rank by Region

Calculate the yearly revenue percentage contributed by sales representatives grouped by their regions. Rank the regions based on their contribution to the yearly revenue.

<figure>
  <img src="https://github.com/rohanshrma25/SQL_DatabaseCreation/assets/143126097/62f0944d-0df8-444a-bf23-dc580a4fce03" alt="Task 1" style="width:500px">
</figure>

### Task 4: Yearly Revenue by Account

Calculate the yearly revenue generated by each account. Rank the accounts based on their yearly revenue contribution.

These tasks provide insights into the performance of sales representatives, regions, and accounts over time.

<figure>
  <img src="https://github.com/rohanshrma25/SQL_DatabaseCreation/assets/143126097/64b1dc17-6dbf-46e0-b67e-1c0485135c69" alt="Task 1" style="width:500px">
</figure>  

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
