# Exercises to Deploy an Azure SQL Managed Instance

These are exercises to deploy an Azure SQL Managed Instance. These exercises are designed to be completed in a workshop environment with an instructor; however, you can also complete them on your own if you have the necessary Azure subscription and resources. Exercises in this module are completely independent of previous modules and can be completed on their own.

In these exercises you will deploy an Azure SQL Managed Instance based on a set of requirements. You will learn new skills unique to Azure combined with using your existing SQL Server knowledge.

In these exercises you will:

- Learn how to deploy an Azure SQL Managed Instance using the Azure Portal.
- Learn how to connect to an Azure SQL Managed Instance using SQL Server Management Studio.
- Learn how to view the deployment duration of an Azure SQL Managed Instance.

## Prerequisites

**Important Note:** Some instructor led labs may already have deployed an Azure SQL Managed Instance for you to use which meets all the requirements in this Exercise. In addition, some instructor led labs will use the Azure VM from Exercise 3.1 as the *jumpbox* virtual machine as listed in these prerequisites. If this is the case, read through Exercise 5.1 but you can skip 5.2 and go right to Exercise 5.3. 

- You must have an Azure subscription with the ability to create an Azure SQL Managed Instance. You must have the ability to create Azure Virtual Machines in the Azure region of your choice. For instructor led workshops, check with you instructor as the Azure SQL Managed Instance might be pre-deployed.
- The Azure SQL Managed Instance will use the Business Critical service tier Standard-series Hardware generation with 4 vCores and 256GB of storage.
- You will need to have access to a virtual machine that can connect to the Azure SQL Managed Instance without a public endpoint. The most common method is to create a *jumpbox* virtual machine in the same virtual network (but different subnet) as the Azure SQL Managed Instance. You can learn more at https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/connect-vm-instance-configure.

    - The virtual machine must have SQL Server 2022 Developer Edition installed.
    - The virtual machine must have SQL Server Management Studio installed (https://aka.ms/ssms). Use version 19.X or later.
    - The virtual machine should have 4 vCores. A VM size such as **D4ds_v5** is recommended.<br><br>
**Tip:** Use an Azure Virtual Machine from the marketplace with SQL Server 2022 Developer Edition and Windows Server 2022. Use the Networking blade to deploy the VM in the same vnet as the MI and the new subnet you have already created. All other settings include SQL Server settings can use the defaults.

## Exercise 5.1 - Study the scenario and requirements

You have a requirement to deploy a new Azure SQL Managed Instance with the following requirements:

### Basic options

- Create a new resource group of the name of your choosing or use an existing resource group.
- Use the name of your choice.
- You can deploy in the region of your choice. For instructor led workshops, check with you instructor as the Azure SQL Managed Instance might be pre-deployed or may require a specific region.
- Use the following Compute+Storage options:
    - Use the Business Critical Service tier.
    - Use the Standard-Series Hardware generation.
    - Use 4 vCores and 256GB of storage
    - Use the Pay-as-you-go pricing model
    - Use the Geo-zone-redundant backup storage option. This will allow you to choose the Zone Redundancy option for the Azure SQL Managed Instance.
- Use the Use SQL authentication method and supply your own admin account and password. Keep this secure as you will need this in the next module.

### Networking options

Use the following Networking options for the deployment.

- Create a new virtual network as part of your deployment.
- Use the Proxy connection type and disable the public endpoint.
- Use TLS 1.2 for encryption.

### Security options

Leave the default options as listed in the Azure portal for security option.

### Additional Settings options

Use the following Additional settings options for the deployment

- Use the default collation of SQL_Latin1_CP1_CI_AS.
- Use the default time zone of UTC.
- Use the defaults for Geo-replication
- Use the defaults for System Maintenance Window.

You do not need to use any Tags.

## Exercise 5.2 - Deploy the Azure SQL Managed Instance

1. Use the Azure Portal (https://portal.azure.com) to deploy a new Azure SQL Managed Instance that meets the requirements of the scenario. Consult the quick start guide for a walkthrough at https://learn.microsoft.com/azure/azure-sql/managed-instance/instance-create-quickstart.
1. After the deployment completes take note in the Azure Portal of the Managed Instance **hostname**. Be sure to save your admin and password you used.

## Exercise 5.3 - Post deployment steps

Perform the following steps after the deployment completes to perform a basic validation of the deployment by connecting to the Azure SQL Managed Instance. You will also examine in the Deployments for the resource group the duration of the Managed Instance deployment.

### Connect to the Azure SQL Managed Instance

Connect to the Azure SQL Managed instance using a client and SQL tools.

1. Use Remote Desktop to connect into the *jumpbox* Virtual Machine. If you already have an RDP file downloaded for the virtual machine you can use that. Otherwise use the following steps:
    1. In the Azure Portal for your virtual machine select **Connect** from the left-hand menu.
    1. Under Native RDP click on **Select**.
    1. Scroll down to Download and open the RDP file and click on Download RDP file.
    1. Select the RDP file to open it and click on **Connect**.
1. Verify you can connect to the Azure SQL Managed Instance deployment. Open SQL Server Management Studio (SSMS) and connect to the Azure SQL Managed Instance using the hostname, admin account, and password you created during the deployment. **Tip:**  In the top right hand search edit box in SSMS, type in **PresentOn** to increase fonts and make it easier to see.

### View the deployment duration

1. First let's look at the deployment from the perspective of the resource group. If you are looking at your virtual machine in the Azure Portal you can click on your resource group or it may be listed in Resources on your home page. You can also search for your resource group in the search box at the top of the Azure Portal by typing in your resource group name and selecting it.
1. On the left-hand menu select **Deployments**.
1. The deployment name should start with "Microsoft.SQLManagedInstance....". If you scroll to the right you can see the Duration of the deployment. This is the time it took to deploy the Azure SQL Managed Instance.

## Next Steps

In Module 6, you will learn how to explore the capabilities of Azure SQL Managed Instance and to learn how to manage and optimize your deployment using your skills and knowledge of SQL Server while learning new skills with Azure SQL Managed Instance.