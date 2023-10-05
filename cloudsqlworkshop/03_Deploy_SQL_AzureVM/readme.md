# Exercise for Deploying SQL Server on Azure Virtual Machines

This is a pre-production version for the exercise to deploy SQL Server on Azure Virtual Machine.

## Scenario

You have a requirement to deploy a new SQL Server on Azure Virtual Machine to migrate a SQL Server database to perform a proof of concept (PoC) test. You are trying to save costs so you want to use deployment options that meet the requirements of your PoC with the *minimal costs possible*. You also need to try and minimize the amount of time it takes to deploy the solution so try to configure as many requirements during deployment.

You must meet the following requirements:

### Software and Virtual Machine requirements

- Deploy SQL Server 2022 with Windows Server 2022. You may use any edition of SQL Server.
- The Azure Virtual machine must support at minimum 4 vCores and 32Gb of RAM and use the **E5-series**. You must deploy the virtual machine using the Azure Portal. For the purposes of this exercise, use VM sizes with Intel processors.
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
    - MAXDOP for the server = # of cores from the VM
    - Instant File Initialization enabled.
    - Locked Pages in Memory enabled.
    - All other instance configuration choices can be left to their defaults.
    
### Storage requirements

The database, system databases, transaction log, and tempdb must meet the following requirements:

**Requirements for database files**

- Database files must be stored on a disk other than the OS disk, can use the default drive letter and path from the Azure Portal, and require Premium SSD.
- The database files require **512Gb** storage to account for growth. (Note: the database used to verify the scenario is only 1Gb in size but is only used a test).
- I/O performance requirements for database files is a max of **3000 to 4000 IOPS**, and a max of **200Mb throughput**.
- System databases (other than tempdb) should be configured to be on the same disk as database files.

**Requirements for the transaction log**

- Must be stored on a separate disk from database files, can use the default drive letter and path from the Azure Portal, and require Premium SSD.
- The transaction log requires **128Gb** max storage and requires **500** max IOPS and **100Mb** max throughput.

**Requirements for tempdb**

- Tempdb must be stored on the local SSD drive for Azure VM so you must choose and Azure VM size that supports local SSD storage. Tempdb *could grow to 128Gb* in size so the VM size you choose must support that.
- Configure the number of tempdb files to match vCores for your chosen VM size. 
- Use other best practices to make tempdb data and transaction log files an initial size of 8Mb with autogrow set to 64Mb.

## Steps for the exercise

1. Use the Azure Portal to deploy a new Azure Virtual Machine that meets the requirements above.

2. To help you get started in the Azure Portal type in Azure SQL in the search box and choose **Azure SQL** and then choose **Azure SQL** from the Marketplace section.

3. You should see three choices for Azure SQL. Select the Image dropdown for SQL Virtual Machines. Based on the requirements choose the least expensive option that meets the requirements and click Create.

1. You are now in a user experience to **Create a virtual machine** with several tabs starting with **Basics**.

1. On the **Basics** tab, fill in all the information that meet the requirements from this exercise. To help you get started, use the **E4ds_v5** Azure VM size.

1. Per the requirements use the defaults on the Disks, Networking, Management, Monitoring, and Advanced tabs.

2. Use the **SQL Server settings** blade to configure SQL Server instance settings and storage requirements per the requirements. Use the defaults for Security and Networking section.

1. Use the *Change configuration* link to use the Storage configuration assistant. Make choices based on the requirements for the scenario. Take your time and carefully review all options.

    **Tips:** You may need to provision more storage than you need to meet the IOPS and throughput requirements. You may also need to choose a different VM size to meet the IOPS and throughput requirements. Look for any warnings on the Configure Storage screen. Go directly back to the Basics tab to change the VM size if necessary.

    The portal alone may not show you all the information you need so you may need to consult this documentation page: https://learn.microsoft.com/azure/virtual-machines/ebdsv5-ebsv5-series, https://learn.microsoft.com/en-us/azure/virtual-machines/edv5-edsv5-series. Use the Max uncached Premium SSD disk throughput: IOPS/MBps column to help you choose the right VM size. You may also need to consult this documentation page: https://docs.microsoft.com/en-us/azure/virtual-machines/disks-types#premium-ssd.

1. Click on the *Change SQL instance settings* to change SQL Server instance settings per the requirements.

1. Leave all other settings to their defaults.

1. When you are ready, click on **Review + Create** to start the deployment. Monitor the deployment until it is successful. It should finish in around 8-10 minutes (mileage can vary).

## Answers for the exercise

The requirements and steps should give you enough information to complete the exercise but choosing the right storage and VM size to meet the requirements can be tricky. Here are some answers to help you should you get stuck or want to verify your work.

### Savings costs

- Choose SQL Server Developer Edition to save on licensing costs.
- On the Basics tab choose to use an existing Windows license.

### Storage configuration

Storage is usually what will be most difficult to configure. Consider the following answers to help you if you get stuck or want to verify your work.

- If you first start with a 512Gb disk you will see that the IOPS and throughput are not enough. You will need to choose a larger disk size. But when you go to 1TB you will see the IOPS and throughput are enough but you will see warnings about the VM size capping IOPS and throughput.
- Change the transaction log to 128Gb. The IOPS and throughput are enough for that disk.
- The warning still exists for the VM size but not for IOPS anymore but for throughput. We need a VM size that supports our throughput requirements for both disks.
- So you need to cancel out of this and go back and choose a different VM size. **Note:**If you stayed with this choice you would be capped on IOPS and throughput that is less than what is required.
- Our app only needs 4 vCores so we don't want to have to overpay for cores to get the I/O performance we need. Our choices now become. So the **E4bds_v5** becomes a new choice that meets all of our requirements but is still cost effective. Change to this VM size then go back to the storage configuration assistant. You will see that there are no more warnings. You now have the storage performance you need for the workload

## Post deployment steps

1. Use Remote Desktop to connect into the Virtual Machine.
1. Copy the **tpch.bak** SQL Server backup file from the GitHub repo release (https://github.com/microsoft/cloudsqlworkshop/releases/tag/v1.0-alpha) that contains the backup of the database to the "f:\data" drive folder.
1. Copy the **restore_tpch.sql** script frpm this folder into the f:\data folder.
1. Load the **restore_tpch.sql** script into SSMS to restore the database. Should only take about 10-15 seconds to restore.

## Next Steps

In Module 4, you will perform various steps to verify the deployment meets the requirements of the scenario as defined in this module.