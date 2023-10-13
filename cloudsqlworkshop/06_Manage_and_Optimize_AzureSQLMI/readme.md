# Exercises for Managing and Optimizing Azure SQL Managed Instance

This is a pre-production version of exercises to manage and optimize Azure SQL Managed Instance.

## Prerequisites

- You must have completed Exercise 5.1 to deploy an Azure SQL Managed Instance.
- You will need a client computer that can use the Remote Desktop Protocol(RDP) and web browser to use the Azure Portal. Any client computer of any Operating System can be used provided it can use RDP.
- You will use RDP to connect into the *jumpbox* virtual machine in Azure you deployed in Exercise 5.1.
- You will need access to files from the workshop at https://aka.ms/cloudsqlworkshop.

## Exercise 6.1 - Explore and optimize the Azure SQL Managed Instance deployment

In this exercise, you will use the Azure Portal and Azure Cloud Shell to explore various aspects of the Azure SQL Managed Instance deployment.

### Explore your deployment in the Azure Portal

1. Find your Azure SQL Managed Instance in the Azure Portal. You can use the search bar at the top of the Azure Portal to search for the name of your Azure SQL Managed Instance or you can find it in the resource group you deployed it to.
1. Select **November 2022 Feature Wave** from the left-hand menu and review the new innovations that are in the feature wave.
1. Select **Compute + Storage** from the left-hand menu. Review the various choices you have for service-tiers, Zone Redundancy, Hardware generation, vCores, and storage.
    1. Scroll down to the **Compute + Storage** section and select **View pricing details** and take note of the cost. Scroll back up to SQL Server License and select **Azure Hybrid Benefit (AHB)** and check the "I confirm..." option. Scroll down and see the Cost Savings.
    1. Scroll back up and Review the Backup Storage Redundancy options.
    1. Click on Apply to apply the AHB option. This will take a few minutes to apply.
1. Select **Maintenance** from the left-hand menu. Select the Maintenance drop-down and **review only** the options for Maintenance schedule and Maintenance window. The option for SQL Service health alerts are to setup notifications for maintenance events.
1. Scroll down and select **Private endpoint connections**. This is where you would create a private endpoint should it be needed for the security of your deployment.
1. Scroll down and select **Resource Health**. This is where you can view a history of the health of your deployment including any failover events that have occurred.

### Bonus Exercise: Use Azure CLI to explore your deployment

For instructor led workshops if time allows, you can use Azure CLI to explore your deployment. You can use the Azure Cloud Shell in the Azure Portal

1. Open the Azure Cloud Shell in the Azure Portal. You can use the search bar at the top of the Azure Portal to search for "Cloud Shell" or you can find it in the top right-hand corner of the Azure Portal.
2. The default is the Bash shell which works just fine for us to use Azure CLI.
3. Run the following command to see what is possible for az CLI for Managed Instances:

```azurecli-interactive
az sql mi --help
```
4. To see details of your Managed Instance run the following command:

```azurecli-interactive
az sql mi show --name <your managed instance name> --resource-group <your resource group name>
```
Examine the JSON output of the deployment including all the properties of the deployment. **Tip:** You can add the **--output table** option to see the output in a table format.

## Exercise 6.2 - Test perf

Notes:

TODO: Can we use 24 vCores for this with Spektra. But I'm still see tlog throttling on 24 vCores

- Study the blog with new I/O log throughput rates for BC tiers. https://techcommunity.microsoft.com/t5/azure-sql-blog/your-max-log-rate-on-sql-managed-instance-business-critical-is/ba-p/3899817
- Calculate the max log I/O throughput for your deployment
- Install QPI library from https://github.com/JocaPC/qpi
- Create a table with 1 million rows that is small
- Snapshot waits and I/O stats
- Do a SELECT INTO to populate the table. Show it uses parallelism.
- Show the stats and I/O throughput
- Change the table to make it bigger (using a padded char column)
- Populate the table with 1 million rows
- Snapshot waits and I/O stats
- Do the same SELECT INTO to populate the table. Show it uses parallelism.
- Show the stats again and see that you are throttled on log I/O throughput.
- If you use more vCores you can increase this throughput.

## Exercise 6.3 - Look at SQL Server compatibility

Azure SQL Managed Instance is very compatible with SQL Server. Use this exercise to do a brief learning to see how. **Tip:** If you have SQL Server installed in the same VM or available on your network you can connect to both SQL Server and Azure SQL Managed Instance at the same time in SSMS to compare and contrast.

### Explore with SSMS

1. Connect to your Azure SQL Managed Instance using SSMS. Use the **Host** in the Azure Portal main pane as the Server Name and the SQL admin and password you used to deploy the Azure SQL Managed Instance. Some instructor-led workshops may have the Azure SQL Managed Instance pre-deployed and you will be provided the connection information in these situations
1. Use Object Explorer to browse the various options that look the same as SQL Server and some are missing or different:
    1. Right-click the *service* and see that the options to Start, Stop, or Restart are greyed out. This is because the service is managed by Azure.
    1. Right-click **Databases** and see that the options to Detach or Attach are not available. You don't have access to the filesystem in the underlying virtual machine so don't have access to detach or attach databases.
    1. Right-click **Databases** and select Restore Database. Click on "..." next to Device. Select the drop down for the Backup media type and you can see that you can only restore from URL or S3. You don't have access directly to the filesystem of the underlying VM so can only restore from Azure Storage or S3 storage.
    1. Looking at the high-level list of Object Explorer options notice the Always On High Availability option is missing. This is because Always On is built-in and you don't have to configure it.
    1. Expand the **Management** folder in Object Explorer. Notice features like Resource Governor, Extended Events, and DTC are there.
    1. Right-click on *the database* you created in Exercise 6.2. Select Properties and then Files. Expand out the window. Notice you can modify size and even add or remove files and notice the path which is a local drive within the VM (because Business Critical service tier databases are stored on local SSD drives). Click add to add a new file. Notice you are not allowed to change the path because you don't have access to the underlying filesystem of the VM.

### Look at SQL diagnostics

Look at common SQL diagnostics you also use for SQL Server and.

1. Open a new query in SSMS and run the following query in the context of the master database so you can see a common ***catalog view*** you use in SQL Server is supported:

```tsql
SELECT name, database_id, compatibility_level, is_query_store_on, is_encrypted, is_accelerated_database_recovery_on, * FROM sys.databases;
```

Notice the results are the same as you might see in SQL Server with a few interesting differences:

- The **recovery model** is FULL for all databases (event system databases) and cannot be modified.
- The default **compatibility level** is 150 (SQL Server 2019) but you can change this for your user database. Note: Azure SQL Managed Instance can change the default dbcompat in the future.
- **Query store** is ON by default for your user database.
- Your database is encrypted with **TDE** by default.
- **Accelerated Database Recovery** is ON by default and cannot be disabled (this is required for Microsoft to honor SLAs).

2. Run the following queries to see common ***Dynamic Management Views (DMV)*** you use in SQL Server are supported:

```tsql
SELECT * FROM sys.dm_exec_sessions;
GO
SELECT * FROM sys.dm_exec_requests;
GO
SELECT * FROM sys.dm_os_wait_stats;
GO
SELECT * FROM sys.dm_os_schedulers;
GO
```
Try to execute any of your favorite DMVs to see they are supported since this is full instance of SQL Server.

3. See how you can run live **Extended Events sessions**.
 
In SSMS in Object Explorer, expand **XEProfiler** and right-click on Standard. Select Launch Session. You will see a new window showing a live Extended Events session. Even though you are not running queries you can see activity of various background services that support Azure SQL Managed Instance and observe the activity.

**Note:** Any Extended Event session you want to persist to disk must be done to Azure Storage since you don't have access to the underlying filesystem of the VM. 

4. Let's look at sp_configure to see what is the same and different for Azure SQL Managed Instance. Run the following query:

```tsql
sp_configure 'show advanced', 1;
GO
reconfigure;
GO
sp_configure;
GO
```
Notice the options pretty much look the same as what is available in SQL Server. However, now try to run this query:

```tsql
sp_configure 'max server memory', 1024;
GO
```
You will get an error like this:

`Msg 5870, Level 16, State 1, Procedure sp_configure, Line 177 [Batch Start Line 6]
Changes to server configuration option 'max server memory (MB)' are not supported in this edition of SQL Server.
`

This is because memory limits are managed by Azure SQL Managed Instance and this configuration option is not needed.

5. As you have already seen the Query Store in on by default. Let's look at **Query Store reports** in SSMS.

In SSMS, expand your database you deployed earlier in this module. Right-click on **Query Store** and select **Top Resource Consuming Queries**. You will see a report showing the top resource consuming queries just like you can in SQL Server.

### Create a SQL Agent Job

Like SQL Server, Azure SQL Managed Instance allows you to create and schedule SQL Agent jobs. Let's create a SQL Agent job that runs CHECKDB on the database you created in Exercise 6.2.

1. Use SSMS and expand **SQL Server Agent**. Right-click on Jobs and select New Job.
1. Fill out the name of the job as "CheckDB" and click Steps on the left-hand side.
1. Click New and fill out the name of the step as "CheckDB" and select the database you created in Exercise 6.2. Click OK.
1. Type in the following T-SQL command for the step:

```tsql
DBCC CHECKDB;
```
1. Click OK to save the step and then OK to save the job.
1. Right-click on the new job and select Start Job at Step. You will see the job run and complete successfully.
1. Select Close.
1. Right-click on the job and View History.
1. Expand the with the "+" on the Job Summary and click on the Step. Expand the window below and you will see the output of CHECKDB for the database.

You have now been able to create and run a SQL Agent job that executes DBCC CHECKDB on your database just like you can in SQL Server.

## Exercise 6.4 - Built-in HADR with Azure SQL Managed Instance

One of the key benefits of Azure SQL Managed Instance is that it is a fully managed service and capabilities like backups and high availability are built-in and automatic. In this exercise, you will explore some of these features including options for you to move and copy databases to other Managed Instances.

### Exploring automatic backups in Azure SQL Managed Instance

Let's explore automatic backups that are created for your database for Azure SQL Managed Instance.

1. Use the Azure Portal to discover your Azure SQL Managed Instance and select **Backups** from the left-hand menu under Data Management.
    1. Notice the Earliest PITR point has a date and time. This is the earliest date and time you can restore your database to.
    1. Click on Restore. Notice you have a screen where you can perform a PITR on a new database. Notice it can even be to a different Managed Instance. Close out this blade
    1. Click on the Retention Policies tab. This is where you can configure the retention policy for your backups. Notice the default is 7 days. You can change this up to 10 years. If you click the database and select Configure Policies you can see how to change the retention.
1. You can track 
1. 
1. 
1. - Explore the backups that were auto crated when you created the dtb and see how you could easily do a PITR. Use the following doc link: https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/backup-activity-monitor?view=azuresql
- Explore any metadata that shows your replica was auto-created. Any catalog view or DMV. Here are some sample SQL queries:
```sql
SELECT db_name(database_id), * FROM sys.dm_database_replica_states;
GO
SELECT * FROM sys.dm_hadr_fabric_replicas;
GO
SELECT * FROM sys.dm_hadr_fabric_replica_states;
go
```
- Do a read-only replica query with SSMS
- Do a manual failover and see how easy it is to connect back to your db. Show the SQL Agent job is part of the failover. Use this doc page to show how and monitor it: https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/user-initiated-failover

## Bonus Exercise 6.5 - Backup and restore to SQL Server 2022

Notes:

- Using the jumpstart VM execute a COPY_ONLY backup to Azure Storage
- Restore the database to SQL Server 2022 on the jumpstart VM