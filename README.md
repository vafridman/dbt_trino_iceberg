The goal of this project is to show how [dbt](https://www.getdbt.com/) and the [Stackable Data Platform](https://stackable.tech/en/) work together.
To get started, we used one of Stackable's easy-to-access [demos](https://docs.stackable.tech/home/stable/demos/trino-iceberg) featuring a Trino-Iceberg stack. 

In it, we pick up the well-known TPC-H dataset. For dbt, we chose a local installation of dbt Core on Arch WSL.
As a result, we deployed a very small data stack, following the bronze/silver/gold pattern of data architecture separation. In addition, we implemented the first two of the standard TPC-H queries (_pricing_summary_report.sql_ and _minimum_cost_suppliers.sql_ in the mart folder).
 
Prerequisits: 

- Install Stackable's Trino-Iceberg stack in a Kubernetes cluster of your choice.
- Create persistent demo data and schemas via e.g. connecting with DBeaver: 
```SQL
CREATE SCHEMA lakehouse.tpch WITH (location = 's3a://lakehouse/tpch');
 
use lakehouse.tpch;
 
create table nation as select * from tpch.sf1.nation;
create table region as select * from tpch.sf1.region;
create table part as select * from tpch.sf1.part;
create table partsupp as select * from tpch.sf1.partsupp;
create table supplier as select * from tpch.sf1.supplier;
create table customer as select * from tpch.sf1.customer;
create table orders as select * from tpch.sf1.orders;
create table lineitem as select * from tpch.sf1.lineitem;
 
CREATE SCHEMA lakehouse.dbt WITH (location = 's3a://lakehouse/dbt');
```


1.	Locally install **dbt core** und **dbt-trino** connector first: 

**python -m pip install dbt-trino**

2.	Create **~/.dbt/profiles.yml** file in your home .dbt folder(it is not on github/other version control) and save in the file the connection proprieties and credentials using the following schema:

```python:
dbt_trino_iceberg:
  target: dev
  outputs:

    dev:
      type: trino
      method: ldap # none one of {none | ldap | kerberos}
      user: admin
      password: ***
      host: 34.38.**.***
      port: ****
      database: lakehouse
      schema: dbt
      threads: 1
      http_scheme: https
      session_properties:
        query_max_run_time: 10m
        exchange_compression: True
    target: dev
```
3.	Check the connection with **dbt debug**
   
4.	If needed, create **packages.yml** in the project folder and run **dbt deps** to install the packages.
   
5.	tbd
