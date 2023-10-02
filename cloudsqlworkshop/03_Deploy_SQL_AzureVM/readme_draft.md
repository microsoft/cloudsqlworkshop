# DRAFT: Exercise for Deploying SQL Server on Azure Virtual Machine

This is a rough draft for the exercise to deploy SQL Server on Azure Virtual Machine.

## Scenario

You have a requirement to deploy a new SQL Server on Azure Virtual Machine to migrate a SQL Server database to perform a proof of concept (PoC) test. You are trying to save costs so you want to use deployment options that meet the requirements of your PoC with the *minimal costs possible*. You also need to try and minimize the amount of time it takes to deploy the solution so try to configure as many requirements during deployment.

You must meet the following requirements:

### Software and Virtual Machine requirements

- Deploy SQL Server 2022 with Windows Server 2022. You may use any edition of SQL Server.
- The Azure Virtual machine must support at minimum 4 vCores and 32Gb of RAM and use the **E5-series**. You must deploy the virtual machine using the Azure Portal.
- The Virtual Machine has these other requirements:
    - Create a new resource group of the name of your choosing.
    - Choose a VM name of your choosing.
    - Choose any region that is supported for your subscription and RBAC permissions. For instructor led workshops, check with you instructor.
    - The VM has No Infrastructure Redundancy requirements
    - The VM can use the Standard security type
    - The VM cannot run with Azure Spot discounts
    - You are free to choose any admin and password that meet requirements for complexity.
    - The public inbound port 3389 for RDP can be left open to the public internet for this PoC.
    - You do have existing Windows Server licenses that you can use for this PoC.
    - There are no special requirements for the OS disk, Networking, Management, Advanced, or Monitoring sections when deploying the VM.
    - You do not have to specify any tags for the VM.
- The SQL Server instance should be configured as follows:
    - MAXDOP = # of cores from the VM
    - Instant File Initialization enabled.
    - Locked Pages in Memory enabled.
    - All other instance configuration choices can be left to their defaults.
    
### Storage requirements

The database, system databases, transaction log, and tempdb must meet the following requirements:

**Requirements for database files**

- Database files must be stored on a disk other than the OS disk, can use the default drive letter and path from the Azure Portal, and require Premium SSD.
- The database files require at **minimum 512Gb** storage to account for growth. (Note: the database used to verify the scenario is only 1Gb in size but is only used a test).
- I/O performance requirements for database files is a max of **7000 IOPS**, and a max of **400Mb throughput**.
- System databases (other than tempdb) should be configured to be on the same disk as database files.

**Requirements for the transaction log**

- Must be stored on a separate disk from database files, can use the default drive letter and path from the Azure Portal, and require Premium SSD.
- The transaction log requires 128Gb max storage and requires 500 max IOPS and 100Mb max throughput.

**Requirements for tempdb**

- Tempdb must be stored on the local SSD drive for Azure VM so you must choose and Azure VM size that supports local SSD storage. Tempdb *could grow to 256Gb* in size so the VM size you choose must support that.
- Configure the number of tempdb files to match vCores for your chosen VM size. 
- Use other best practices to make tempdb data and transaction log files an intial size of 8Mb with autogrow set to 64Mb.

## Steps for the exercise

1. Use the Azure Portal to deploy a new Azure Virtual Machine that meets the requirements above. On the Basics blade, fill in all the information that meet the requirements from this exercise. To help you get started, use the **E4ds_v5** Azure VM size.

2. Use the SQL Server settings blade to configure SQL Server instance settings.

3. Use the SQL Server settings blade to configure storage for database, transaction log, and tempdb. Use the Change configuration link to use a Storage configuration assistant.

    **Tips:** You may need to provision more storage than you need to meet the IOPS and throughput requirements. You may also need to choose a different VM size to meet the IOPS and throughput requirements. You may also need to choose a different VM size to meet the tempdb requirements. Look for any warnings on the Configure Storage screen.

4. The SQL Server instance port 1433 should NOT be exposed to the public internet. All other SQL Server settings in the Azure Portal can be left to their defaults.

5. When you are ready, click on **Review + Create** to start the deployment. Monitor the deployment until it is successful. It should finish in around 8-10 minutes (mileage can vary).

## Answers for the exercise

The requirements and steps should give you enough information to complete the exercise but choosing the right storage and VM size to meet the requirements can be tricky. Here are some answers to help you get started.

Storage is usually what will be most difficult to configure. Consider the following answers to help you get started.
- Provide enough storage to meet your IOPS and throughput requirements even though you need only 1TB. Use 2 disks at 1TB to get the storage IOPS and throughput you need.
- You will see a warning that the VM size doesn't support the max IOPS and throughput required. So you need to cancel out of this and go back and choose a different VM size. **Note:**If you stayed with this choice you would be capped on IOPS and throughput that is less than what is required. 
- Our app only needs 4 vCores so we don't want to have to overpay for cores to get the I/O performance we need. Our choices now become:
    - **E8-4ds_v5**:  A *constrained* core option that gives us the IOPS we need and more. The IOPS and throughput for this size is based on E8ds_v5. This doc page shows IOPS and throughput will work: https://learn.microsoft.com/en-us/azure/virtual-machines/edv5-edsv5-series. The portal shows this as ~689.12 per month. Since we are using Developer Edition we are not saving money on the SQL License but if we used Std or EE we would because we are only paying for 4 vCores but get the I/O performance of 8 vCores.
    - **E4bds_v5**: This size is less expensive and meets our requirements for IOPS but NOT throughput: https://learn.microsoft.com/en-us/azure/virtual-machines/edv5-edsv5-series so this isn't an option unless we re-evaluate the workload to see if the throughput is really needed.
    
This means that the **E8-4ds_v5** is the best choice for this scenario.
    
## Post deployment steps

1. Use Remote Desktop to connect into the Virtual Machine.
1. Copy the **tpch.bak** SQL Server backup file from the GitHub repo release (https://github.com/microsoft/cloudsqlworkshop/releases/tag/v1.0-alpha) that contains the backup of the database to the "f:\data" drive folder.
1. Copy the **restore_tpch.sql** script into the f:\data folder.
1. Load the **restore_tpch.sql** script into SSMS to restore the database. Should only take about 10-15 seconds to restore.

The exercise in Module 4 will have you verify your deployment meets the requirements for storage performance and perform other verification steps.