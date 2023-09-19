# DRAFT: Exercise for Verifying SQL Server on Azure Virtual Machine

This is a rough draft for the exercise to verify the deployment of SQL Server on Azure Virtual Machine.

## Scenario

You have a requirement to verify the deployment of SQL Server on Azure Virtual Machine you did in Module 3 of this workshop.

## Setup

- Download the ostress program for the workload from https:/aka.ms/ostress. Run the install program from the GUI
- Create a folder called **cloudsqlworkshop** into the c: drive.
- Copy the **workload.cmd** and **tpch_query3.sql** files from the GitHub clone or download to the cloudsqlworkshop folder.

## Steps for the exercise

Complete the following steps to verify the deployment:

Note: This is a stress test. The workload constantly runs queries against the database pulling in pages from disk for reads. This will cause the disk to be constantly busy. This is not a typical workload but is used to stress test the storage system to verify it meets the requirements.

- Connect with RDP into the Virtual Machine.
- Verify the storage was configured as done during deployment using File Explorer and Disk Management in Server Manager to see the storage pools created for the 2 data disks.
- Verify the SQL Server instance settings are set correctly including MAXDOP, Instant File Initialization, and Locked Pages in Memory.
- Setup perfmon with the following counters:
    - Logical Disk F: Disk Bytes/Sec
    - Logical Disk F: Disk Transfer/Sec
- Run **workload.cmd** from a Powershell prompt from the cloudsqlworkshop folder to run the workload which will take about a minute.
- During the workload run observe the maximum and average values for the perfmon counters. Verify this meets or exceeds the requirements for the storage configuration.

## Advanced Exercise

Using the following documentation https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types#premium-ssd-v2-performance determine how you could use a Premium SSD v2 disk for storage for database files to save cost and minimize the needed size of the managed disk.