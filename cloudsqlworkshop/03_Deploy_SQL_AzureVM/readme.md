# DRAFT: Exercise for Deploying SQL Server on Azure Virtual Machine

This is a rough draft for the exercise to deploy SQL Server on Azure Virtual Machine

## Scenario

You have a requirement to deploy a new SQL Server on Azure Virtual Machine to migrate a SQL Server database. To deploy this virtual machine you need to meet the following requirements:

- The Azure VM must be running Windows Server 2022 Datacenter.
- The Azure VM must support at minimum 4vCores and 32Gb of RAM and use the E-series.
- The application that uses this SQL Server requires SQL Server 2022 Standard Edition.
- The application has the following storage requirements:
    - The database files must be stored on a separate disk from the operating system.
    - Tempdb must be stored on the local SSD drive for Azure VM.
    - The database files require a minimum of 1TB to account for growth.
    - The database files must be stored on a disk that supports at minimum 20K IOPS and X throughput. The storage for the database files should not use caching but require Premium Storage.
    - The transaction log requires X storage and requires X IOPS and X throughput. It should be on Premium storage and should not use caching.
- You must choose a VM size and storage configuration for the least cost possible while meeting all the other requirements.
- The SQL Server instance requires the following configuration:
    - MAXDOP = 4
    - Instant File Initialization enabled.
    - Locked Pages in Memory enabled.
    - All other options should be left to the defaults.

- The SQL Server instance port 1433 should NOT be exposed to the public internet.

## Steps for the exercise

1. Use the Azure Portal to deploy a new Azure Virtual Machine that meets the requirements above.
    1. Take note of your admin account and password.
1. Monitor the deployment until it is successful.
1. Use Remote Desktop to connect into the Virtual Machine.
1. Perform a basic verification
    1. The SQL Server instance settings are set correctly.
    1. The storage is setup correctly for size and file layout.
    1. The SQL Server version is correct (there is no requirement for a specific cumulative update.)
1. Copy the files from the GitHub repo release that contains the backup of the database to the "data" drive folder.
1. Use the supplied **restore_tpch.sql** script to restore the database. Should only take about 10-15 seconds to restore.

The exercise in Module 4 will have you verify your deployment meets the requirements for storage performance.