# Exercises to Manage and Optimize SQL Server on Azure Virtual Machine

This is a set of exercises to verify your SQL Server deployment based on requirements provided in Module 3, therefore you must complete exercises in Module 3 first. In addition there is an exercise to explore the capabilities of the SQL Server IaaS Agent Extension. There is also an advanced exercise to explore using Premium SSD v2 disks for database files to save cost and minimize the needed size of the managed disks.

In these exercises you will:

- Verify the deployment of SQL Server on Azure Virtual Machine you did in Module 3 of this workshop including ensuring I/O performance requirements are met and SQL Server instance settings are configured correctly.
- Explore the capabilities of the SQL Server IaaS Agent Extension.
- Explore using Premium SSD v2 disks for database files to save cost and minimize the needed size of the managed disks.

## Prerequisites

- You must have completed exercises in Module 3 to deploy a SQL Server on Azure Virtual Machine.
- You will need a client computer that can use the Remote Desktop Protocol(RDP)
- You will need access to the files and scripts associated to the workshop which you can download into your deployed VM from https://aka.ms/cloudsqlworkshopfiles. No further action is needed if you downloaded these in Module 3.

## Exercise 4.1 - Verify the SQL Server on Azure Virtual Machine deployment.

In this exercise you will verify the deployment of SQL Server on Azure Virtual Machine you did in Module 3 of this workshop. The exercises are designed to be completed in a workshop environment with an instructor; however, you can also complete them on your own if you have the necessary Azure subscription and resources.

### Scenario

You have a requirement to verify the deployment of SQL Server on Azure Virtual Machine you did in Module 3 of this workshop. You need to ensure all the requirements as described in Module 3 are met including:

- SQL Server instance settings are configured correctly
- I/O performance meets the requirements.

You will use a stress test workload to verify the I/O performance of the storage system. This workload is based on a TPC-H benchmark SQL query and executed using the ostress program to simulate multiple concurrent users running the query repeatedly.

### Setup

- Download the ostress program for the workload from https://aka.ms/ostress. Run the install program using all the defaults.

### Verify SQL Server instance settings

1. Use SQL system procedures and/or catalog views to verify MAXDOP, Instant File Initialization, and Locked Pages in Memory are set correctly.
2. Use SSMS or catalog views to verify tempdb is configured correctly per the requirements.

Use any web searches, documentation, or other resources to help you complete this step.

### Check I/O performance

You will use a combination of Windows perfmon and a workload script and query to verify the I/O performance requirements for database files. As a reminder the requirement is

- 3000 - 4000 IOPS
- 200MB/sec throughput

**Note:** This is a stress test. The workload constantly runs queries against the database pulling in pages from disk for reads. This will cause the disk to be constantly busy. This is not a typical workload but is used to stress test the storage system to verify it meets the requirements.

1. Open Windows perfmon and add the following counters:
    - **Logical Disk F: Disk Bytes/Sec**: This is your measure for I/O throughput.
    - **Logical Disk F: Disk Transfer/Sec**: This is your measure for IOPS.

2. From a Powershell command prompt change context to the **`<user>`\Downloads\cloudsqlworkshop-1.0-release\cloudsqlworkshop-1.0-release\cloudsqlworkshop\04_Manage_and_Optimize_SQL_AzureVM** folder
1. Run **workload.cmd** from a Powershell prompt to run the workload which will take about a minute.
1. During the workload run observe the values for the perfmon counters. Verify this meets the requirements for storage performance.

### Answers for the exercise

In case you get stuck or need to verify your work here are some tips and answers:

To **verify SQL Server instance settings** you can:

- The system procedure **sp_configure** can be used to verify the MAXDOP setting ('max degree of parallelism').
- One way to see if instant file initialization is enabled is to query the **sys.dm_server_services** DMV for the instant_file_initialization_enabled column.
- One way to see if locked pages is enabled is to query the **sys.dm_os_sys_info** DMV to see if the sql_memory_model_desc = LOCK_PAGES

To **verify tempdb is configured correctly** you can use SSMS to look at the file properties for tempdb to ensure the right number of files and autogrow settings are configured.

When you run the workload test to **verify I/O performance**, you should see Disk Bytes/Sec range between 3000 to 4000 (with some dips) and throughput should easily exceed 200Mb/sec.

## Exercise 4.2 - Explore the SQL IaaS Agent Extension

Use the Azure Portal to review the capabilities of the SQL Server IaaS Agent Extension. You can find the documentation at https://docs.microsoft.com/azure/azure-sql/virtual-machines/windows/sql-vm-resource-provider-overview.

1. Find your virtual machine in the Azure Portal (https://portal.azure.com) as a SQL Server Virtual Machine by searching in the top of the Azure Portal for "SQL Virtual Machines". Select SQL Virtual Machines from the list of Services.
2. Select your virtual machine from the list of SQL Server Virtual Machines.
3. Look at the properties in the main pane including SQL Server version, and edition.
4. On the left hand menu, select **Configure**

    Notice your different license types and the ability to change the license type. The default is Pay As You Go since we used the Marketplace but you could also select Azure Hybrid Benefit to use an existing SQL Server license. In addition, if this VM was used for DR purposes from an on-premises SQL Server you could select Disaster Recovery and not pay any SQL license costs. You an learn more at https://learn.microsoft.com/azure/azure-sql/virtual-machines/windows/licensing-model-azure-hybrid-benefit-ahb-change.

5. On the left hand menu select **Storage Configuration**. 
 
    There is where you can expand storage for data or transaction log disks. You can also change the storage configuration of tempdb. You can also add additional disks for data or log files. You can learn more at https://learn.microsoft.com/azure/azure-sql/virtual-machines/windows/storage-configuration?view=azuresql&tabs=windows2016#existing-vms.

6. On the left hand menu select **Updates**.

    This is the Microsoft update experience for Azure virtual machines. You can use this option to enable Microsoft updates inside your VM including cumulative updates for SQL Server. You can check for updates, perform updates, and schedule updates. You can learn more at https://learn.microsoft.com/azure/azure-sql/virtual-machines/azure-update-manager-sql-vm?view=azuresql&tabs=windows.

7. On the left hand menu select **Backups**.

    This is an option for you to schedule automatic backups to Azure Storage. You can learn more at https://learn.microsoft.com/azure/azure-sql/virtual-machines/windows/automated-backup?view=azuresql.

8. On the left hand menu select **Best Practices Assessment**.

    This is an option for you to run best practice assessments to get advice on how to configure your virtual machine and SQL Server for optimal performance and execution. You can get advice specifically based on your configuration on topics like SQL Server and database configurations, Index management, Deprecated features, Enabled or missing trace flags, Statistics, and more You can learn more at https://learn.microsoft.com/azure/azure-sql/virtual-machines/windows/best-practices-assessment?view=azuresql.

9. On the left hand menu select **Security Configuration**.

    You have two options you can use to increase security for SQL Server on Azure Virtual Machine.

    **Azure Key Vault**

    Enabling this option allows you to store and manage keys for features like transparent data encryption (TDE), column level encryption (CLE), and backup encryption in Azure Key Vault. You can learn more at https://learn.microsoft.com/azure/azure-sql/virtual-machines/windows/azure-key-vault-integration-configure.

    **Microsoft Entry Authentication**

    This option allows you to enable Microsoft Entry Authentication (formerly known as Azure Active Directory) for SQL Server running in the virtual machine (only supported for SQL Server 2022 and later) This provides a method for you to use more secure authentication methods than SQL Authentication but does not require a Windows domain. It also provides new secure login methods such as Multi-Factor Authentication (MFA). Learn more at https://learn.microsoft.com/azure/azure-sql/virtual-machines/windows/configure-azure-ad-authentication-for-sql-vm

10. On the left hand menu select **Microsoft Defender for the Cloud**

    Microsoft Defender for the Cloud provides vulnerability assessments of your SQL Server security configuration based on industry standards and can alert you to advanced security attacks such as SQL injection.

    Microsoft Defender for the Cloud can be enabled on Azure subscription by default so may provide immediate results for you to review.

    Learn more at https://learn.microsoft.com/azure/defender-for-cloud/defender-for-sql-usage

## Exercise 4.3 - Bonus Exercise with Premium SSD v2 disks

Using the following documentation https://learn.microsoft.com/azure/virtual-machines/disks-types#premium-ssd-v2-performance determine how you could use a Premium SSD v2 disk for storage for database files to save cost and minimize the needed size of the managed disks. You will also need the pricing chart at https://azure.microsoft.com/pricing/details/managed-disks/.

### Advanced Exercise Answers

Premium SSD v2 disks come with a baseline of 3000 IOPS and 125MB/second throughput. Since our requirements is 3000-4000 and 200MB for the data disk we will need more. But you get 500 IOPS for every 1Gb in size added. And you get 0.25 MB throughput for each additional IOP.

So we only need to add 2Gb more to our disk to get 4000 IOPS and that also gives us an additional 250Mb per second. So now we only need a 514GB drive to achieve what originally needed for Premium v1 which was 1TB.

The cost of a 1TB P30 disk is $135.17 per month. The cost of a 514GB Premium SSD v2 disk is $68.06 per month. So we save $67.11 per month or $805.32 per year.

**Note**: If you look at the documentation for the Ebdsv5 series, the VM size for Premium SSD v2 disks for I/O performance is capped at 14740 IOPS and 350MB throughput so the VM size would cap the overall possible performance for the disks but it still meets requirements of our workload.