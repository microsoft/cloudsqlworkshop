# Exercise for Verifying SQL Server on Azure Virtual Machine

This is a pre-production version of the exercise to verify the deployment of SQL Server on Azure Virtual Machine.

## Scenario

You have a requirement to verify the deployment of SQL Server on Azure Virtual Machine you did in Module 3 of this workshop. You need to ensure all the requirements as described in Module 3 are met including:

- SQL Server instance settings are configured correctly
- I/O performance meets the requirements.

You will use a stress test workload to verify the I/O performance of the storage system. This workload is based on a TPC-H benchmark SQL query and executed using the ostress program to simulate multiple concurrent users running the query repeatedly.

## Setup

- Download the ostress program for the workload from https://aka.ms/ostress. Run the install program from the GUI.
- Create a folder called **cloudsqlworkshop** on the c: drive.
- Copy the **workload.cmd** and **tpch_query3.sql** files from the GitHub clone or download to the cloudsqlworkshop folder.

## Steps for the exercise

Complete the following steps to verify the deployment. Connect with RDP into the virtual machine. You will need to use the credentials you specified during deployment.

### SQL Server instance settings

1. Use SQL system procedures and/or catalog views to verify MAXDOP, Instant File Initialization, and Locked Pages in Memory are set correctly.
2. Use SSMS or catalog views to verify tempdb is configured correctly per the requirements.

Use any web searches, documentation, or other resources to help you complete this step.

### Check I/O performance

You will use a combination of Windows perfmon and a workload script and query to verify the I/O performance requirements for database files. As a reminder the requirement is

- 200MB/s throughput
- 3000 - 4000 IOPS

**Note:** This is a stress test. The workload constantly runs queries against the database pulling in pages from disk for reads. This will cause the disk to be constantly busy. This is not a typical workload but is used to stress test the storage system to verify it meets the requirements.

1. Open Windows perfmon and add the following counters:
    - **Logical Disk F: Disk Bytes/Sec**: This is your measure for I/O throughput.
    - **Logical Disk F: Disk Transfer/Sec**: This is your measure for IOPS.

2. Run **workload.cmd** from a Powershell prompt from the cloudsqlworkshop folder to run the workload which will take about a minute.
3. During the workload run observe the values for the perfmon counters. Verify this meets the requirements for storage performance.

### Answers for the exercise

In case you get stuck or need to verify your work here are some tips and answers:

To **verify SQL Server instance settings** you can:

- The system procedure sp_configure can be used to verify the MAXDOP setting.
- One way to see if instant file initialization is enabled is to query the sys.dm_server_services DMV for the instant_file_initialization_enabled column.
- One way to see if locked pages is enabled is to query the sys.dm_os_sys_info DMV to see if the sql_memory_model_desc = LOCK_PAGES

To **verify tempdb is configured correctly** you can use SSMS to look at the file properties for tempdb to ensure the right number of files and autogrow settings are configured.

When you run the workload test to **verify I/O performance**, you should see Disk Bytes/Sec range between 3000 to 4000 and throughput should easily exceed 200Mb/sec.

## Bonus Exercise

Using the following documentation https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types#premium-ssd-v2-performance determine how you could use a Premium SSD v2 disk for storage for database files to save cost and minimize the needed size of the managed disks.