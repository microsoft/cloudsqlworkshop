# Exercises for Managing and Optimizing Azure SQL Managed Instance

This is a pre-production version of exercises to manage and optimize Azure SQL Managed Instance.

## Prerequisites

- You must have completed Exercise 5.1 to deploy an Azure SQL Managed Instance.
- You will need a client computer that can use the Remote Desktop Protocol(RDP).
- You will use RDP to connect into the jumbox virtual machine in Azure you deployed in Exercise 5.1.
- You will need access to files from the workshop at https://aka.ms/cloudsqlworkshop.

## Exercise 6.1 - Explore and optimize the Azure SQL Managed Instance deployment

Notes:

- Select AHUB and see the cost difference.
- Change the Maintenance schedule
- Evaluate the Start/Stop capabilities
- Explore Microsoft Entra admin
- Explore Private Endpoint connections

## Exercise 6.2 - Test perf

Notes:

- This would be about showing new tlog rates for BC tiers so we would create a table and show how initial ingestion with a SELECT INTO which runs in parallel is not hampered by tlog throttling.

## Exercise 6.3 - Look at SQL Server compatibility

Notes:

- Look at common DMVs and catalog views
- Look at sp_configure
- Look at Query Store
- Create a SQL Agent job that executes CHECKDB on the database you created in 6.2

## Exercise 6.4 - Built-in HADR

Notes:

- Explore the backups that were auto crated when you created the dtb and see how you could easily do a PITR
- Explore any metadata that shows your replica was auto-created. Any catalog view or DMV. 
- Do a read-only replica query with SSMS
- Do a manual failover and see how easy it is to connect back to your db. Show the SQL Agent job is part of the failover.

## Bonus Exercise 6.5 - Backup and restore to SQL Server 2022

Notes:

- Using the jumpstart VM execute a COPY_ONLY backup to Azure Storage
- Restore the database to SQL Server 2022 on the jumpstart VM