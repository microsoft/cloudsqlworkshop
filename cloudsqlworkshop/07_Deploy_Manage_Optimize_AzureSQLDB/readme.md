# Exercises to Deploy, Manage, and Optimize Azure SQL Database

This is a set of exercises to deploy, manage, and optimize Azure SQL Database. The exercises are designed to be completed in order as each exercise builds on the previous exercise.

## Prerequisites

- You must have an Azure subscription with the ability to create an Azure SQL Database using the Hyperscale Service Tier. You must have the ability to create an Azure SQL Database in the Azure region of your choice.

- You need a client computer to connect and run workloads against Azure SQL Database. You can use your own computer or use an Azure Virtual Machine. If you use an Azure Virtual Machine you will be automatically enabled to connect to Azure SQL Database. If you use your own client computer you will need to enable a firewall setting. This will be described in more detail in the exercise to deploy the Azure SQL Database.

    - SQL Server Management Studio (SSMS) version 18.9 or later. You can download the latest version of SSMS from https://aka.ms/ssms. You can also use Azure Data Studio (ADS) version 1.32 or later. You can download the latest version of ADS from https://aka.ms/azuredatastudio.

    - SQL Server Data Tools (SSDT) version 18.9 or later. You can download the latest version of SSDT from https://docs.microsoft.com/en-us/sql/ssdt/download-sql-server-data-tools-ssdt?view=sql-server-ver15.

    - SQL Server Command Line Utilities version 15.0 or later. You can download the latest version of the SQL Server Command Line Utilities from https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility?view=sql-server-ver15.

    - Azure CLI version 2.26 or later. You can download the latest version of the Azure CLI from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest.

    - Azure PowerShell version 5.7 or later. You can download the latest version of Azure PowerShell from https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-6.4.0.

- You will need to have access to a virtual machine that can connect to the Azure SQL Managed Instance without a public endpoint. The most common method is to create a *jumpbox* virtual machine in the same virtual network (but different subnet) as the Azure SQL Managed Instance. You can learn more at https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/connect-vm-instance-configure.
    - The virtual machine must have SQL Server 2022 Developer Edition installed.
    - The virtual machine must have SQL Server Management Studio installed (https://aka.ms/ssms). Use version 19.X or later.
    - The virtual machine should have 4 vCores. A VM size such as **D4ds_v5** is recommended.<br><br>
**Tip:** Use an Azure Virtual Machine from the marketplace with SQL Server 2022 Developer Edition and Windows Server 2022. Use the Networking blade to deploy the VM in the same vnet as the MI and the new subnet you have already created. All other settings include SQL Server settings can use the defaults.

## Scenario

You have a requirement to deploy a new Azure SQL Managed Instance with the following requirements:

### Basic options

- Create a new resource group of the name of your choosing or use an existing resource group.
- Use the name of your choice.
- You can deploy in the region of your choice. For instructor led workshops, check with you instructor as the Azure SQL Managed Instance might be pre-deployed or may require a specific region.
- Use the following Compute+Storage options:
    - Use the Business Critical Service tier.
    - Use the Premium-series - Intel Ice Lake
    - Use 8 vCores and 256GB of storage
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

## Steps for the exercise

1. Use the Azure Portal to deploy a new Azure SQL Managed Instance that meets the requirements of the scenario.
1. After the deployment completes take note in the Azure Portal of the Managed Instance hostname.

## Post deployment steps

Perform the following steps after the deployment completes to perform a basic validation of the deployment by connecting to the Azure SQL Managed Instance. You will also examine in the Deployments for the resource group the duration of the Managed Instance deployment.

### Connect to the Azure SQL Managed Instance

1. Deploy a *jumpbox* virtual machine in the same virtual network as the Azure SQL Managed Instance. A recommended method is to use this QuickStart guide at https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/connect-vm-instance-configure.
1. Use Remote Desktop to connect into the Virtual Machine.
1. Verify you can connect to the Azure SQL Managed Instance deployment. Open SQL Server Management Studio (SSMS) and connect to the Azure SQL Managed Instance using the hostname, admin account, and password you created during the deployment. Tip: In the top right hand search edit box type in **PresentOn** to increase fonts and make it easier to see.

### View the deployment duration

1. First let's look at the deployment from the perspective of the resource group. If you are looking at your virtual machine in the Azure Portal you can click on your resource group or it may be listed in Resources on your home page. You can also search for your resource group in the search box at the top of the Azure Portal by typing in your resource group name and selecting it.
1. On the left-hand menu select **Deployments**.
1. The deployment name should start with "Microsoft.SQLManagedInstance....". If you scroll to the right you can see the Duration of the deployment. This is the time it took to deploy the Azure SQL Managed Instance.

## Next Steps

In Module 6, you will learn how to explore the capabilities of Azure SQL Managed Instance and to learn how to manage and optimize your deployment using your skills and knowledge of SQL Server.