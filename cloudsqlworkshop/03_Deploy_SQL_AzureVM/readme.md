# DRAFT: Exercise for Deploying SQL Server on Azure Virtual Machine

This is a rough draft for the exercise to deploy SQL Server on Azure Virtual Machine.

## Scenario

You have a requirement to deploy a new SQL Server on Azure Virtual Machine to migrate a SQL Server database. To deploy this virtual machine you need to meet the following requirements:

- You need to do your testing on Windows Server 2022 and SQL Server 2022 Developer Edition.
- The Azure VM must support at minimum 4 vCores and 32Gb of RAM and use the E5-series.
- The application has the following storage requirements:
    - The database files must be stored on a separate disk from the operating system.
    - Tempdb must be stored on the local SSD drive for Azure VM.
    - The database files require at minimum 512Gb storage to account for growth (Note: the database uses to verify the scenario is only 1Gb in size but is only used a test).
    - The database files must be stored on a disk that supports a max of 7K IOPS, and a max of 400Mb throughput.
    - The transaction log requires 128Gb max storage and requires 500 max IOPS and 100Mb max throughput.
- You must choose a VM size and storage configuration for the least cost possible while meeting all the other requirements.
    - Note: As you use the SQL storage config assistant you wil need do the following:
    - Provide enough storage to meet your IOPS and throughput requirements even though you need only 1TB. Use 2 disks at 1TB to get the storage IOPS and throughput you need.
    - You will see a warning that the VM size doesn't support the max IOPS and throughput required. So you need to cancel out of this and go back and choose a different VM size. Note: If you stayed with this choice you would be capped on IOPS and throughput that is less than what is required. 
    - Our app only needs 4 cores so we don't want to have to overpay for cores to get the I/O performance we need. Our choices now become:
        - E8-4ds_v5 - A constrained core that gives us the IOPS we need and more. The IOPS and throughput for this size is based on E8ds_v5. This doc page shows IOPS and throughput will work: https://learn.microsoft.com/en-us/azure/virtual-machines/edv5-edsv5-series. The portal shows this as ~689.12 per month. Since we are using Developer Edition we are not saving money on the SQL License but if we used Std or EE we would because we are only paying for 4 vCores but get the I/O performance of 8 vCores.
        - E4bds_v5 - This size is less expensive and meets our requirements for IOPS but NOT throughput: https://learn.microsoft.com/en-us/azure/virtual-machines/edv5-edsv5-series so this isn't an option unless we re-evaluate the workload to see if the throughput is really needed.
- The SQL Server instance requires the following configuration:
    - MAXDOP = # of cores from the VM
    - Instant File Initialization enabled.
    - Locked Pages in Memory enabled.
    - All other options should be left to the defaults.

- The SQL Server instance port 1433 should NOT be exposed to the public internet.

## Steps for the exercise

1. Use the Azure Portal to deploy a new Azure Virtual Machine that meets the requirements above. Start with the E4ds_v5 size.
    1. Create a new resource group for this exercise.
    1. Use any VM name you want.
    1. Use the region of you choice provided it supports the VM size you choose.
    1. Take note of your admin account and password.
    1. Leave the RDP port open to the public internet.
    1. Choose all defaults in the Disks, Networking, Management, Advanced, and Tags sections.
1. Monitor the deployment until it is successful.
1. Use Remote Desktop to connect into the Virtual Machine.
1. Copy the **tpch.bak** SQL Server backup file from the GitHub repo release (https://github.com/microsoft/cloudsqlworkshop/releases/tag/v1.0-alpha) that contains the backup of the database to the "f:\data" drive folder.
1. Copy the **restore_tpch.sql** script into the f:\data folder.
1. Load the **restore_tpch.sql** script into SSMS to restore the database. Should only take about 10-15 seconds to restore.

The exercise in Module 4 will have you verify your deployment meets the requirements for storage performance.