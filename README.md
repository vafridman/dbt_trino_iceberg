The goal of this project is to test collaboration of dbt and Trino using TPC-H dataset in a [Stackable Cloud](https://stackable.tech/en/)  container.

We used a local installation of dbt Core on Arch WSL.

The first two of the standard TPC-H queries were implemented (pricing_summary_report.sql and minimum_cost_suppliers.sql in mart folder.)

1.	Install **dbt core** und **dbt-trino** connector first: 

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
