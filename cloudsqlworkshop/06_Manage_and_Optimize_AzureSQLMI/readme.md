# Exercises for Managing and Optimizing Azure SQL Managed Instance

This is a pre-production version of exercises to manage and optimize Azure SQL Managed Instance. Exercises in this Module are dependent on exercises in Module 5 but are independent of other modules in this workshop.

## Prerequisites

- You must have completed Exercise 5.1 to deploy an Azure SQL Managed Instance.
- You will need a client computer that can use the Remote Desktop Protocol(RDP) and web browser to use the Azure Portal. Any client computer of any Operating System can be used provided it can use RDP.
- You will use RDP to connect into the *jumpbox* virtual machine in Azure you deployed in Exercise 5.1.
- You will need access to files from the workshop at https://aka.ms/cloudsqlworkshop.

## Exercise 6.1 - Explore the Azure SQL Managed Instance deployment

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

### Use Azure CLI to explore your deployment

Learn how to use Azure CLI to explore your deployment. You can use the Azure Cloud Shell in the Azure Portal. You will need the name of the resource group for your deployment and the instance name (not the full hostname).

1. Open the Azure Cloud Shell in the Azure Portal (refer to this documentation page for a quick start: https://learn.microsoft.com/azure/cloud-shell/quickstart?tabs=azurecli#start-cloud-shell). You can use the search bar at the top of the Azure Portal to search for "Cloud Shell" or you can find it in the top right-hand corner of the Azure Portal.
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

## Exercise 6.2 - Test transaction log I/O performance

In this exercise you will create a new database, create a table, populate it with data, and then perform a test to observe transaction log I/O performance and possible limits. Like SQL Server, when you deploy an Azure SQL Managed Instance only system databases exist. You will need to create a new database to perform this exercise.

1. Using the following documentation page: https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/resource-limits?view=azuresql#service-tier-characteristics, calculate the **Log write throughput limit** for your deployment.

3. Create a new database, table, and populate data in your Azure SQL Managed Instance. Use the following T-SQL to create the database. This will take about 1 minute to execute:

    ```tsql
    -- Create a new database
    --
    DROP DATABASE IF EXISTS customersdb;
    GO
    CREATE DATABASE customersdb;
    GO

    -- Create a table
    --
    USE customersdb;
    GO
    DROP TABLE IF EXISTS customers;
    GO
    CREATE TABLE customers (tabkey int, customer_id nvarchar(10), customer_information char(100) not null);
    GO

    -- Populate 1 million rows of data into the table
    --
    WITH cte
    AS
    (
    SELECT ROW_NUMBER() OVER(ORDER BY c1.object_id) id FROM sys.columns c1 CROSS JOIN sys.columns c2
    )
I   INSERT customers
    SELECT id, CONVERT(nvarchar(10), id),'customer details' FROM cte;
    GO
    ```

2. To observe I/O performance we can use built in Dynamic Management Views (DMV) in SQL Server such as **sys.dm_io_virtual_file_stats**. To assist you in using these DMVs we will use the QPI library set of scripts.

    Pull up this site https://raw.githubusercontent.com/JocaPC/qpi/master/src/qpi.sql. Select all the contents of the file and copy it to your clipboard. Connect with SSMS to your Managed Instance and paste all the code into a new query window in the context of the customersdb database. Execute the query to create the QPI library

4. In a new query window load his query to take a snapshot for I/O and wait statistics:

    ```tsql
    USE customersdb;
    GO
    EXEC qpi.snapshot_file_stats
    GO
    EXEC qpi.snapshot_wait_stats;
    GO
    ```

5. In a new query window execute this query to create a new table from the existing table. This will use DOP to populate the new table and put pressure on transaction log I/O.

    ```tsql
    USE customersdb;
    GO
    DROP TABLE IF EXISTS customers2;
    GO
    SELECT * INTO customers2 FROM customers;
    GO
    ```

6. In a new query window run the following queries to monitor I/O performance and waits while the SELECT INTO is running.

    ```tsql
    USE customersdb;
    GO
    SELECT * FROM qpi.file_stats
    WHERE file_name = 'log';
    GO
    SELECT * FROM qpi.wait_stats;
    GO
    ```

Run this query repeatedly *while the SELECT INTO is executing*. You can see the I/O throughput is limited to the number of vCores * 4.5MB/sec. In addition you can see some waits on INSTANCE_LOG_RATE_GOVERNOR which shows that the log I/O is being throttled. Executing this script after the workload is finished will show lower numbers since no log I/O is occurring.

This test is a stress test of log I/O and may not represent your normal workload. However, if you are seeing throttling on log I/O you can increase the number of vCores to increase the log I/O throughput. In addition, Microsoft has increased possible log I/O rates for Business Critical service tier. See the following blog post for more information: https://techcommunity.microsoft.com/t5/azure-sql-blog/your-max-log-rate-on-sql-managed-instance-business-critical-is/ba-p/3899817

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

Look at common SQL diagnostics you also use for SQL Server.

1. Open a new query in SSMS and run the following query in the context of the master database so you can see a common ***catalog view*** you use in SQL Server is supported:

    ```tsql
    SELECT name, database_id, compatibility_level, is_query_store_on, is_encrypted, is_accelerated_database_recovery_on, * FROM sys.databases;
    GO
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
2. Fill out the name of the job as "CheckDB" and click Steps on the left-hand side.
3. Click New and fill out the name of the step as "CheckDB" and select the database you created in Exercise 6.2. Click OK.
4. Type in the following T-SQL command for the step:

```tsql
DBCC CHECKDB;
```
5. Click OK to save the step and then OK to save the job.
6. Right-click on the new job and select Start Job at Step. You will see the job run and complete successfully.
7. Select Close.
8. Right-click on the job and View History.
9. Expand the with the "+" on the Job Summary and click on the Step. Expand the window below and you will see the output of CHECKDB for the database.

You have now been able to create and run a SQL Agent job that executes DBCC CHECKDB on your database just like you can in SQL Server.

## Exercise 6.4 - Built-in HADR with Azure SQL Managed Instance

One of the key benefits of Azure SQL Managed Instance is that it is a fully managed service and capabilities like backups and high availability are built-in and automatic. In this exercise, you will explore some of these features.

### Exploring automatic backups in Azure SQL Managed Instance

Let's explore automatic backups that are created for your database for Azure SQL Managed Instance.

1. Use the Azure Portal to discover your Azure SQL Managed Instance and select **Backups** from the left-hand menu under Data Management.
    1. Notice the Earliest PITR point has a date and time. This is the earliest date and time you can restore your database to.
    1. Click on Restore. Notice you have a screen where you can perform a PITR on a new database. Notice it can even be to a different Managed Instance. Close out this blade
    1. Click on the Retention Policies tab. This is where you can configure the retention policy for your backups. Notice the default is 7 days. You can change this up to 10 years. If you click the database and select Configure Policies you can see how to change the retention.
1. You can track the history of the automatic backups using the *normal* backup history tables in msdb. Connect to SSMS and run the following query:
    
    ```tsql
    SELECT database_name, case when type = 'D' then 'Full' when type = 'I' then 'Differential' when type = 'L' then 'Log' end,
    has_backup_checksums, backup_size, compressed_backup_size, backup_start_date, backup_finish_date
    FROM msdb.dbo.backupset
    ORDER BY backup_finish_date DESC;
    GO
    ```

    As you look at the result set, notice the combination of Full, Differential, and log backups. You can also tell by the output that these backups use checksum and compression. Note: Do not rely on the time differences between backups. There is no specific guarantee how often we will take backups but you can read more about the normal backup frequency schedule at https://learn.microsoft.com/azure/azure-sql/managed-instance/automated-backups-overview?view=azuresql#what-are-automated-database-backups

### Explore the built-in replicas for Azure SQL Managed instance databases

The Business Critical service tier for Azure SQL Managed Instance comes with a set of built-in replicas based on the Always On Availability Group technology. In this part of the exercise, you will explore more about the state of replicas and how to use them.

#### Explore DMVs on replica states

There are Dynamic Management views that are unique to Azure SQL Managed Instance that you can use to explore the state of replicas but also you can use one that works in SQL Server.

Run the following queries in a query window with SSMS against your Azure SQL Managed Instance:

```tsql
SELECT db_name(database_id), * FROM sys.dm_database_replica_states;
GO
SELECT db_name(database_id), * FROM sys.dm_hadr_database_replica_states;
GO
SELECT DISTINCT replication_endpoint_url, fabric_replica_role_desc 
FROM sys.dm_hadr_fabric_replica_states;
GO
```

The first query will show you a list of databases that are being replicated including your database and system databases. The result set of the 2nd query shows that there is a single primary replica and four other secondary replicas. The result of the 3rd query is a list of the URL endpoint for each node in the Always On Availability Group and the role of the replica. **Take note of these values** for primary and secondaries as you will use them later in this module.

### Connect to a read replica

You get one free read replica to use with the Business Critical service tier. Let's see how to connect to it and run some queries:

1. Use SSMS to disconnect your current session with your Azure SQL Managed Instance. Perform a new connection in SSMS to your Azure SQL Managed Instance. Use the following documentation page to learn how to connect to a read replica for Azure SQL Managed Instance with SSMS using your Managed Instance host, admin, and password: https://learn.microsoft.com/azure/azure-sql/database/read-scale-out?view=azuresql#connect-to-a-read-only-replica

2. Verify you are connected to a read replica with the following query in SSMS connected to Azure SQL Managed Instance:

    ```tsql
    SELECT DATABASEPROPERTYEX('<your db>', 'Updateability');
    GO
    ```

    Your result should be **READ_ONLY**.

3. Let's run the same queries as you did before to see the state of replicas:

    ```tsql
    SELECT db_name(database_id), * FROM sys.dm_database_replica_states;
    GO
    ```

    You can see in this case the is_primary_replica = 0 for all databases indicating you are in the context of a secondary replica.

### Do a manual failover

Since Microsoft is managing the replicas for you, you don't have to worry about failover. However, you can do a manual failover if you want to test it out. Let's do that now. You will use the Azure Cloud Shell and the az CLI to perform the failover. And then you will reconnect with SSMS to see you are connected to the new primary replica without having to change your connection string.

You will need the name of the resource group and managed instance name (not the full hostname) for this exercise. You can get this information from the Azure Portal. You this documentation page for reference: https://learn.microsoft.com/azure/azure-sql/managed-instance/user-initiated-failover.

1. Disconnect any connections in SSMS on your jumpstart VM to your Azure SQL Managed Instance.
2. Open the Azure Cloud Shell in the Azure Portal (refer to this documentation page for a quick start: https://learn.microsoft.com/azure/cloud-shell/quickstart?tabs=azurecli#start-cloud-shell). You can use the search bar at the top of the Azure Portal to search for "Cloud Shell" or you can find it in the top right-hand corner of the Azure Portal.
3. The default is the Bash shell which works just fine for us to use Azure CLI.
4. Run the following command to manually failover your Azure SQL Managed Instance:

    ```azurecli-interactive
    az sql mi failover -g <resource group> -n <instance name>
    ```

    You will see a status or Starting and then Running and then you will be put back to the bash shell prompt. You can close the cloud shell.
5. Go back to SSMS on your jumpstart VM and try to connect to the Azure SQL Managed Instance. **Important:** Be sure to remove any Additional Properties you had for read only connections. You should be able to connect within less than a minute.
6. Using SSMS in Object Explorer notice your user database and SQL Server Agent Job you created earlier in this module are still there. 
7. You can also run the following query to see the state of replicas:

    ```tsql
    SELECT db_name(database_id), * FROM sys.dm_database_replica_states;
    GO
    SELECT db_name(database_id), * FROM sys.dm_hadr_database_replica_states;
    GO
    SELECT DISTINCT replication_endpoint_url, fabric_replica_role_desc 
    FROM sys.dm_hadr_fabric_replica_states;
    GO
    ```

    The results should look similar to what you saw earlier except for the last result set notice the replication_endpoint_url for the REPLICA_ROLE_PRIMARY is different indicating you have failed over to a previous secondary.
8. In the Azure Portal find your Azure SQL Managed Instance and click on Activity log from the left-hand menu. You should see an event that a failover was issued.

## Bonus Exercise 6.5 - Backup and restore to SQL Server 2022

UNDER CONSTRUCTION