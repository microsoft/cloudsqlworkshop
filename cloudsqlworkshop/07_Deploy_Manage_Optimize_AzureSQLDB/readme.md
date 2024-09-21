# Exercises to Deploy, Manage, and Optimize Azure SQL Database

This is a set of exercises to deploy, manage, and optimize an Azure SQL Database. The exercises are designed to be completed in order as each exercise builds on the previous exercise. The exercises are designed to be completed in a workshop environment with an instructor; however, you can also complete them on your own if you have the necessary Azure subscription and resources. This Module is completely independent of previous modules and can be completed on its own.

In these exercises you will:

- Learn how to deploy an Azure SQL Database using the Azure Portal.
- Learn how to connect to an Azure SQL Database using SQL Server Management Studio.
- Learn how to view the deployment of an Azure SQL Database.
- Learn how to explore and configure an Azure SQL Database including Microsoft Entra authentication.
- Learn similarities and differences between SQL Server and Azure SQL Database.
- Learn how to scale an Azure SQL Database using Serverless.
- Learn how to explore built-in HADR capabilities of Azure SQL Database.

## Prerequisites

- You must have an Azure subscription with the ability to create an Azure SQL Database using the General Purpose Service Tier. You must have the ability to create an Azure SQL Database in the Azure region of your choice.
- You need a client computer to connect and run workloads against Azure SQL Database. You can use your own computer or use an Azure Virtual Machine like the one you deployed in Module 3. If you use an Azure Virtual Machine you will be automatically enabled to connect to Azure SQL Database because of your choices when deploying the Azure SQL Database. If you use your own client computer you will need to enable a firewall setting. This will be described in more detail in the exercise to deploy the Azure SQL Database.
- You will need access to the **Source Code** zip file which you can download into your deployed VM from https://aka.ms/cloudsqlworkshopfiles. *Extract* out the Source Code zip file which will put the files into the **`<user>`\Downloads\cloudsqlworkshop-1.0-release** folder. You can skip this step if you have already downloaded these files into your VM as part of a previous module. You do not need the tpch.bak file for this module.
- In your client computer you will use **SQL Server Management Studio** (https://aka.ms/ssms).

    > **Note:** For instructor led workshops you may use the same virtual machine you deployed in Module 3 of this workshop.

## Exercise 7.1 - Study the Scenario and Requirements

You are deploying a new Azure SQL Database for a proof of concept. You need to learn how to deploy, explore, manage, and optimize the deployment. The deployment must meet the following requirements:

### Logical Server requirements

You have a requirement to deploy a new Azure SQL Database Logical Server with the following requirements:

- Use the logical server name of your choice. **It must be a unique name across Azure.** Your instructor may also indicate a specific logical server name to use.
- Use the resource group of your choice. You can use an existing resource group from previous modules. Your instructor may also indicate a specific resource group to use.
- You can deploy in the region of your choice. For instructor led workshops, check with you instructor as the Azure SQL Database may require a specific region.
- For your initial deployment for Authentication method use the option called Use SQL Authentication and provide an admin and password. If you have access to a Microsoft Entra account you will change this option later in the module.

### Database requirements

You have a requirement to deploy a new Azure SQL Database with the following requirements:

#### Basic options

- Use the same resource group as your logical server.
- Create a new logical server based on the requirements above and use a database name of your choice.
- You will not be using elastic pools.
- Choose the Production Workload environment. **Note:** For a PoC you might normally choose the Development option here but in our workshop we want to show the difference when changing to Serverless. Choosing the Development option will default to the Serverless compute tier which is a good choice for development projects.
- Use the following Compute+Storage options:
    - Use the General Purpose service tier and Provisioned Compute Tier.
    - Use the Standard-series (Gen5) hardware
    - Use Azure Hybrid Benefit to Save Money. (i.e. I have a SQL Server License)
    - Use 2 vCores and 32GB Data Max size.
    - You do not have to make the database zone redundant.
- Use Geo-redundant backup storage.

#### Networking options

You will use the following Networking options for the deployment.

- You will enable Public endpoint access to the Azure SQL Database and enable Allow Azure services and resources to access this server.
- If you are connecting from a client computer not in Azure you will enable a firewall rule for your client computer later in this module.
- Use the Default connection policy.
- Use TLS 1.2 for encryption.

#### Security options

Leave the default options as listed in the Azure portal security options.

#### Additional Settings options

Use the following Additional settings options for the deployment:

- Since you are deploying a database for a proof of concept use the **Sample** option for existing data. This will force the use of the default collation of SQL_Latin1_CP1_CI_AS. The Sample option creates the database based on the AdventureWorksLT sample database. Learn more at https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks.

You do not need to use any Tags.

## Exercise 7.2: Deploy an Azure SQL Database

In this exercise you will deploy an Azure SQL Logical Server and Database per the scenario requirements listed above in this module. You will then perform a basic validation of the deployment by examining the Deployments for the resource group the duration of the Database deployment.

### Deployment Steps

1. Use the Azure Portal to deploy a new Azure SQL Logical Server and Database that meets the requirements of the scenario listed above in this module.
2. To help you get started in the Azure Portal type in Azure SQL in the search box and choose **Azure SQL** and then choose **Azure SQL** from the Marketplace section.
3. You should see three choices for Azure SQL. Use the choice called **SQL databases,** leave the default Single database, and click **Create**.
4. Now go to Basics through Additional Settings tabs based on the scenario requirements listed above in this module. Here are a few tips as you use the portal to deploy the database.

    > <strong>Tip</strong>: Notice in the Azure Portal the new option to create an Azure Database for free. You could use this offer during the workshop but may run out of free vCore usage based on the exercises in this module. This is a great way to get started with Azure SQL Database so consider this for the future. You can learn more at https://learn.microsoft.com/azure/azure-sql/database/free-offer.

    - For Server, select **Create new** and use the options listed in the scenario requirements above in this module.
    - For Networking, select Public Endpoint, Check Allow Azure services and resources to access this server and all other options should be left as default.
    - When you are done with your choices, click **Review + Create**. A brief validation will occur and then you can click **Create** to start the deployment. Your screen will change to say Deployment in progress. You can leave this screen up or change context as this is an async operation. If you stay on this screen click on **Go to Resource**.
    
    Most deployments of this size complete in a matter of minutes.

5. After the deployment completes take note in the Azure Portal of the Server Name and the database name. You can go back and find these at any time using the home page in the portal or through search.

### Post deployment steps

Perform the following steps after the deployment completes to perform a basic validation of the deployment by examining the Deployment for the resource group the duration of the Logical Server and Database deployment.

1. First let's look at the deployment from the perspective of the resource group. If you are looking at your SQL database in the Azure Portal you can click on your resource group or it may be listed in Resources on your home page. You can also search for your resource group in the search box at the top of the Azure Portal by typing in your resource group name and selecting it.
1. On the left-hand menu select **Deployments**.
1. The deployment name should start with "Microsoft.SQLDatabase.newDatabaseNewServer...". If you scroll to the right you can see the Duration of the deployment. This is the time it took to deploy the Azure SQL Logical Server and Database. You can click on the deployment name to see more details about the deployment.

## Exercise 7.3: Explore and connect to Azure SQL Database

In this exercise you will explore your Azure SQL Database deployment and perform some basic configuration.

### Explore Azure SQL Database in the Azure Portal

1. If look at the **Essentials** pane In the Azure Portal for you database you can see various properties under Essentials including your resource group, Status, Region (Location), and Subscription. One of the most important properties is Server name. This is the name of the logical server that hosts your database. This is the name of the SQL Server you will use to connect with tools like SSMS. You can also see the Earliest restore point for the database based on automatic backups (which may not be available immediately after you create the database but will be populated in minutes after deployment).
1. Under Essentials you can see options for Getting Started, Monitoring, Properties, Features, Notifications, Integrations, and Tutorials. A very rich set of options for your database.
1. On the left-hand menu, there is an option to open up a **Query Editor** to run queries from the Azure Portal. While you won't use the editor in this module you can learn more at https://learn.microsoft.com/azure/azure-sql/database/query-editor.
1. Under this on the left-hand menu, under **Settings** there are options to change Compute + Storage, view Connection Strings for applications, and change the default Maintenance Window. You will change Compute + Storage in a later exercise but you can click on each of these to explore how to use them.
1. Scrolling down on the left-hand menu is the section on **Security**. Here from the Azure Portal you can configure various options to configure Security. Click on **Auditing**. From here you can enable Azure SQL Auditing which is based on SQL Server Audit. You can learn about how to configure other security features for Azure SQL Database at https://learn.microsoft.com/azure/azure-sql/database/secure-database-tutorial?view=azuresql#enable-security-features.

### Connect to Azure SQL Database

In this section, you will connect Azure SQL Database and explore more about your deployment of the logical server and database.

1. If you are connecting from an Azure Virtual Machine, you can skip this step. If are you connecting from a client computer not inside Azure, you can create a server-level firewall rule as documented at https://learn.microsoft.com/azure/azure-sql/database/secure-database-tutorial?view=azuresql#create-firewall-rules.
1. You can use RDP or the Bastion service to connect to the Azure Virtual Machine you deployed in Module 3 as a client computer.
1. Connect on your client computer using SSMS with the Server Name as listed in the Azure Portal for the database using SQL Authentication with the SQL admin and password you specified when creating the logical server. You can select Remember password to make it easier to connect again in the future. **Tip:** Also connect with SSMS to the local SQL Server so you can compare and contrast.
1. Notice Object Explorer differences
    1. Right-click on logical server and notice there are no options to configure the logical server or see properties. This is because a Logical Server is not the same as a SQL Server instance. It is a logical construct that hosts one or more databases.
    1. Notice only master is listed as a system database.
    1. No other instance features are available in Object Explorer.
    1. There are two options for the logical server besides databases:
        - **Security** allows you to create other logins for the logical server. Read more at https://learn.microsoft.com/azure/azure-sql/database/logins-create-manage.
        - **Integration Services Catalog** is an option to allow you to configure SSIS with Azure Data Factory. You can learn more at https://docs.microsoft.com/azure/data-factory/tutorial-deploy-ssis-packages-azure.
        
1. Exploring the database through T-SQL

    Right-click on Logical Server and select New Query. This places you in the context of the master database of the logical server. You have permissions to do this because you are the sysadmin of the logical server.

1. Looking at the version
 
    Execute the following query:

    ```tsql
    SELECT @@VERSION;
     ```    

    You should see results that look similar to the following (the date/time may new newer):

    `Microsoft SQL Azure (RTM) - 12.0.2000.8   Sep 18 2023 12:22:37   Copyright (C) 2022 Microsoft Corporation`

    Notice the "edition" is called SQL Azure. This is the name of the edition of Azure SQL Database. The version number is 12.0.2000.8. This version never changes for *versionless* Azure SQL but it doesn't mean that your database doesn't contain all the latest features of SQL Server. The datetime in the version stamp indicates the last time the SQL Server instance for the database was updated.

1. Changing database context

    Try executing the following query:

    ```tsql
    USE <dbname>;
    ```

    where `<dbname>` is the name of your Azure SQL Database. You should encounter the following error:
    
    `Msg 40508, Level 16, State 1, Line 1
    USE statement is not supported to switch between databases. Use a new connection to connect to a different database.`
    
    This is because there is no way to switch context to your database since it is not physically associated with the logical server. To connect to the database you must make a direct connection in the context of the user database.
    
    You can do this in SSMS in your current connection, by using the drop-down in the upper left-hand corner and selecting your database. When you do this notice in the bottom right-hand corner of SSMS the connection string changes to include the database name. **Change the context now for the next step**.

### Explore Azure SQL Database through T-SQL

1. Examine resource limits of your database

    Try executing the following query:

    ```tsql
    SELECT * FROM sys.dm_user_db_resource_governance;
    ```
    
    Examine the columns from the result set. This allows you to view limits without always having to look at the documentation. You can learn more about this DMV at https://learn.microsoft.com/sql/relational-databases/system-dynamic-management-views/sys-dm-user-db-resource-governor-azure-sql-database. You can also read more about limits at https://learn.microsoft.com/azure/azure-sql/database/resource-limits-vcore-single-databases.
    
1. Create a basic table with data

    Let's create a simple table and populate it with data. You will use this table later in this module as part of a disaster recovery situation. In the context of the user database execute this query:

    ```tsql
    DROP TABLE IF EXISTS dontdropme;
    GO
    CREATE TABLE dontdropme (col1 int);
    GO
    INSERT INTO dontdropme VALUES (1);
    GO
    ```
1. View database properties with the following query:

    ```tsql
    SELECT name, database_id, recovery_model_desc, compatibility_level, is_query_store_on, is_encrypted, is_accelerated_database_recovery_on, is_read_committed_snapshot_on FROM sys.databases;
    GO
    ```
    There are a few things you can observe from the results:

    First you can see that only master from the logical server and your user database are listed. These properties are also set by default for your database.

     - The **recovery model** is FULL for all databases. This cannot be modified. (This is required for Microsoft to honor SLAs).
    - The default **compatibility level** is 150 (SQL Server 2019) but you can change this for your user database. Azure SQL Database supports dbcompat from older SQL Server versions. **Note:** Azure SQL Database can change the default dbcompat for new databases in the future.
    - **Query store** is ON by default for your user database.
    - Your database is encrypted with **TDE** by default.
    - **Accelerated Database Recovery** is ON by default and cannot be disabled (This is required for Microsoft to honor SLAs).
    - **Read Committed Snapshot Isolation** is ON by default.

1. Run the following queries to see common ***Dynamic Management Views (DMV)*** you use in SQL Server are supported:

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

    Since an Azure SQL Database runs on its own instance you can still use common DMVs from SQL Server. Note that each database even if on the same logical server will have its own set of metrics.

5. Now let's see some DMVs that are unique to Azure SQL Database: Run the following query:

    ```tsql
    SELECT * FROM sys.dm_db_wait_stats;
    GO
    SELECT * FROM sys.dm_resource_governor_workload_groups_history_ex;
    GO
    ```
    
    For the first result set, you will see there are far fewer results because these are waits only from user requests and only wait types with waiting_tasks_count > 0.

    The 2nd DMV can be used to see snapshots of resource usage for the database per resource governor workload groups. You can see several internal groups are deployed to manage the database. You can learn more about this DMV at https://learn.microsoft.com/sql/relational-databases/system-dynamic-management-views/sys-dm-resource-governor-workload-groups-history-ex-azure-sql-database.

    > **Note:** Most of the data surfaced by this DMV is intended for internal consumption and is subject to change.

6. Let's see another DMV that can be used for troubleshooting connectivity issues with Azure SQL Database. At the top of the query window change the database context in the dropdown back to master. Now execute the following query:

    ```tsql
    SELECT * FROM sys.event_log_ex ORDER BY start_time DESC;
    GO
    ```

    This DMV shows an aggregation of successful and failed connections to the logical server.

7. Now let's look at a query that does not work with Azure SQL Database due to the nature of the service. Run the following query:

    ```tsql
    EXEC sp_configure;
    GO
    ```

    You should get the following error:

    `Msg 2812, Level 16, State 62, Line 1
    Could not find stored procedure 'sp_configure'.`

    Even with a logical server, the SQL Server instance is managed by Microsoft and you cannot change instance level settings but that is a benefit of having a managed database service.

### Use Extended Events through SSMS

XEvent Profiler (XEProfiler) provides you similar capabilities as you may have seen in the past with SQL Profiler. XEProfiler allows you to quickly see a live stream of extended events for common events like SQL queries. XEProfiler has been supported for SQL Server and Azure SQL Managed Instance and is now supported for Azure SQL Database.

You can access XEProfiler in SSMS off the Object Explorer when connected to the logical server of an Azure SQL Database.

Expand the options in Object Explorer for your database and click on XEvent Profiler. Double-click Standard. You will see a new window with a live stream of events. If you wait a few seconds, new events will appear. These are examples of queries used by our infrastructure to monitor and manage your database.

### Configure and connect with Microsoft Entra

Learn to configure your Azure SQL Database to allow Microsoft Entra accounts to connect as users of the database. You will need access to a Microsoft Entra account to use in this exercise. For instructor led workshops, your instructor will provide this information for you.

1. Find the logical server in the Azure Portal.
1. Select **Microsoft Entra ID** on the left-hand menu in the portal.
1. Select **Set Admin** on the right hand page in the portal.
1. Search and find your Microsoft Entra account. Select your user and click **Select**.
1. Click **Save**. This operation will take a few seconds to complete.
1. In SSMS, disconnect the current session for the logical server.
1. In SSMS, connect using this new Microsoft Entra account similar to the documentation at https://learn.microsoft.com/sql/relational-databases/security/authentication-access/azure-ad-authentication-sql-server-setup-tutorial?view=sql-server-ver16#authentication-example-using-ssms. Your choice of authentication method depends on how your Entra account has been setup. Often you will use *Active Directory - Universal with MFA support*. For instructor led workshops, your instructor will provide this information for you.
1. Find another Microsoft Entra account to add as a user. For instructor led workshops, your instructor will provide this information for you.
1. In a query window, execute the following query in the *context of your user database*:

    ```tsql
    CREATE USER [<Microsoft Entra account>] FROM EXTERNAL PROVIDER;
    GO
    ```

    Where `<Microsoft Entra Account>` is the name of the other Microsoft Entra account.

1. Disconnect with SSMS and connect with the 2nd Microsoft Entra Account. Notice you only have access to the user database. This is an example of using Microsoft Entra to provide a user access to a database without creating a login.

    **Important:** When you connect with this 2nd user you must specify the user database name in the Connection Properties tab. If you get this error check the database context

    `Login failed for user '<token-identified principal>'. (Microsoft SQL Server, Error: 18456)`

1. Disconnect with SSMS the new connection.

## Exercise 7.4 - Scale Azure SQL Database with Serverless

In this exercise, you will learn how to run a workload against Azure SQL Database and scale the database using Serverless to meet the workload requirements.

### Setup

You might have already performed some of these steps if you completed Module 04 of this workshop.

- Download the ostress program for the workload from https://aka.ms/ostress. Run the install program from the GUI with all the defaults.
2. From a Powershell command prompt change context to the **`<user>`\Downloads\cloudsqlworkshop-1.0-release\cloudsqlworkshop-1.0-release\cloudsqlworkshop\07_Deploy_Manage_Optimize_AzureSQLDB** folder
- Edit the **workload.cmd** to put in your `<logical server>`, `<database>`, `<admin login>`, and `<password>`.
- Connect with SSMS with the SQL admin account using SQL Authentication (You could also use the Microsoft Entra admin account if you prefer). **Note:** Make sure to clear the Additional connection properties for read-only if that is still there from previous modules.
- In SSMS load the script files dbdbresourcestats.sql and dmexecrequests.sql from the **`<user>`\Downloads\cloudsqlworkshop-1.0-release\cloudsqlworkshop-1.0-release\cloudsqlworkshop\07_Deploy_Manage_Optimize_AzureSQLDB** folder in separate query windows under the context of the database. You will use these scripts to monitor performance.

### Run the workload and observe performance

1. Load the scripts **dmexecrequests.sql** and **dmdbresourcestats.sq**l from the **`<user>`\Downloads\cloudsqlworkshop-1.0-release\cloudsqlworkshop-1.0-release\cloudsqlworkshop\07_Deploy_Manage_Optimize_AzureSQLDB** folder in separate query windows *under the context of the user database*. You will use these scripts to monitor performance.
1. From the current Powershell command window run **workload.cmd**.
1. While this command is running execute the T-SQL queries from the script dmexecrequests.sql in SSMS to see the workload running. You will observe several requests with a status of runnable and last_wait_type of SOS_SCHEDULER_YIELD. This script uses common DMVs such as **sys.dm_exec_requests** to see what queries are actively running or waiting. SOS_SCHEDULER_YIELD is a common symptom of a CPU bound workload and lack of CPU resources.
1. Execute the T-SQL queries from the script dmdbresourcestats.sql in SSMS to see the resource usage of the database. This script uses the DMV sys.**dm_db_resource_stats** which is unique to Azure SQL Database. This DMV shows on a polling interval every 15 seconds. If you run this query repeatedly you will see several intervals where the avg_cpu_percent is 99%+. This is an indication that the database is CPU bound and is being limited by CPU resources.
1. You can continue to run these queries until the workload completes which will take around 1 minute 25 seconds.
1. In SSMS, under Object Explorer under the database context expand Query Store, and select Top Resource Consuming Queries. You will see the top query is the one you ran from the workload. Change the Metric to Wait Time (ms). You will see the top query is the one you ran from the workload. If you hover over the bar chart you will see the query is mostly waiting on CPU. This lines up with the SOS_SCHEDULER_YIELD waits you have seen.
1. Close out the Query Store reports. Leave the query windows open for monitoring performance.
1. Using the Azure Portal for your database scroll down and select Monitoring. From there scroll down and look at compute utilization. You will see a period of 100% CPU utilization for the database.

### Scale the database with Serverless

If you look at the Azure Portal, the database is provisioned with only 2 vCores. This is not enough to handle the workload. We could try to add more vCores and keep it as a Provisioned compute tier. But what if the application doesn't always need more than 2 vCores. This is where Serverless can help.

1. In the Azure Portal for your database select **Compute + Storage** from the left-hand menu.
1. Under Compute tier select **Serverless**.
1. Scroll down and use the slider to change Max vCores to 12. Leave Min vCores at 1.5.
1. Click **Apply**.
1. Your database is still online while a scaling deployment is taking place. A small amount of downtime can occur at the end of the deployment. In the Azure Portal you can click the Notification icon to see the progress. The operation should take a few minutes.
1. In the Azure Portal under Essentials you can see the Pricing tier is now Serverless.

    > **Tip:** You can also use the T-SQL ALTER DATABASE command to change properties like Serverless. Read more at https://learn.microsoft.com/sql/t-sql/statements/alter-database-transact-sql?view=azuresqldb-current

### Run the workload again to observe performance

Now that you have changed the database to Serverless, let's run the workload again and see how it performs.

1. From a Powershell command window run **workload.cmd**.
1. Use SSMS to run queries for dmexecrequests.sql and dmdbresourcestats.sql to monitor performance.

You will still see some runnable requests with SOS_SCHEDULER_YIELD (far less) but notice the avg_cpu_percent is lower. This is because Serverless allows your workload to autoscale to 12 vCores as needed.

The workload should finish in no more than 15 seconds.

If you look back at Monitoring in the Azure Portal you will also see  less CPU utilization. Note that by default Monitoring the portal is not refreshed on a low frequency so it make take a few minutes to see the new numbers. You can come back and look at this later if you want to proceed with further exercises.

Close out the existing query windows.

## Exercise 7.5 - Explore built-in HADR capabilities

Explore the built-in HADR capabilities of Azure SQL Database by looking at insights for automatic backups. Then you will perform a restore of the database after accidentally dropping a table

### Explore automatic backups

Let's use a DMV unique to Azure SQL Database to explore the automatic backups for the database.

1. Connect with SSMS to the logical server if not already connected.
1. Open a new query in the *context of your database*.
1. Execute the following query:

    ```tsql
    SELECT logical_database_name, case when backup_type = 'D' then 'Full' when backup_type = 'I' then 'Differential' when backup_type = 'L' then 'Log' end as backup_type_desc, backup_start_date, backup_finish_date, in_retention
    FROM sys.dm_database_backups
    ORDER BY backup_finish_date DESC;
    GO
    ```

    You can see a series of Full, Log, and in some cases Differential backups for the database. Depending on when you query this DMV, some backups may have fallen out of the retention period which is by default 7 days. Learn more about this DMV at https://learn.microsoft.com/sql/relational-databases/system-dynamic-management-views/sys-dm-database-backups-azure-sql-database. In order to allow point-in-time restore, some backups may be kept even if out of retention.

    > **Note:** This DMV is in preview. There may be an issue where some backups like Full show up as out of retention but are not. This is a known issue.

### Perform a Point in Time Restore

Let's use a great feature of a managed database service by using automatic backups to restore the database to a new name after a table was accidentally dropped. Consider a situation where you accidentally drop a table so need to restore the database to a new name to recover the table. You can use the backup history to decide at which point in time to restore the database to recover the table.

1. In SSMS, connect to the logical server (if not already connected) in the context of the database and execute the following query in a new query window:

    ```tsql
    SELECT GETDATE();
    GO
    DROP TABLE IF EXISTS dontdropme;
    GO
    ```
    Take note of the datetime returned;

2. Using what you learned in the previous exercise to look up the backup history, choose a backup datetime before the drop table was executed based on the datetime returned. Use the backup_finish_date as the time.
1. In the Azure Portal, change context to the logical server.
1. On the left-hand menu under Data Management, select **Backups**.
1. Select **Restore** under Action (you may need to scroll to the right see this option).
1. Fill in the restore time from your choice of the automatic backups. Leave the other options as default. Take the 24 hour backup_finish_date and type in the hour and minute format of HH:MM (AM or PM). For example, if the backup_finish_date is 2021-09-30 23:00:00.000 then you would type in 11:00:00 PM.
1. Leave all other defaults.
1. Click **Review + Create** and the click on **Create**.
1. While the restore is taking place, in SSMS in the context of **master** of your logical server, execute the following query:

    ```tsql
    SELECT resource_type_desc, major_resource_id, operation, state_desc, percent_complete
    FROM sys.dm_operation_status;
    GO
    ```

    You can use this to monitor the status of progress of the restore. You can also use the Azure Portal to monitor the status of the restore.

    It may take up to 5-6 minutes to complete the restore.

    **Note:** The new database may appear in SSMS in Object Explorer but may not be ready to be accessed.

1. In SSMS, refresh Object Explorer to see if the new database is listed.
1. Open up a new query window in the context of the new database. Execute the following query:

    ```tsql
    SELECT * FROM dontdropme;
    GO
    ```
    
    You can see the table has been recovered. Now that your table is recovered if you want to keep this version of the database you could drop the existing database and rename this one. Or you could use other methods to copy this table into the existing database. One is to use external tables. Learn more at https://learn.microsoft.com/sql/t-sql/statements/create-external-table-transact-sql?view=azuresqldb-current