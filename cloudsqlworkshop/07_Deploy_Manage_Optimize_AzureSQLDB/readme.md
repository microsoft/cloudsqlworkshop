# Exercises to Deploy, Manage, and Optimize Azure SQL Database

This is a set of exercises to deploy, manage, and optimize an Azure SQL Database. The exercises are designed to be completed in order as each exercise builds on the previous exercise. The exercises are designed to be completed in a workshop environment with an instructor; however, you can also complete them on your own if you have the necessary Azure subscription and resources. This Module is completely independent of previous modules and can be completed on its own.

## Prerequisites

- You must have an Azure subscription with the ability to create an Azure SQL Database using the General Purpose Service Tier. You must have the ability to create an Azure SQL Database in the Azure region of your choice.

- You need a client computer to connect and run workloads against Azure SQL Database. You can use your own computer or use an Azure Virtual Machine. If you use an Azure Virtual Machine you will be automatically enabled to connect to Azure SQL Database. If you use your own client computer you will need to enable a firewall setting. This will be described in more detail in the exercise to deploy the Azure SQL Database. 

**Note:** For instructor led workshops you may use the same virtual machine you deployed in Module 3 of this workshop.

## Scenario

You are deploying a new Azure SQL Database for a proof of concept. 

### Logical Server requirements

You have a requirement to deploy a new Azure SQL Database Logical Server with the following requirements:

- Use the logical server name of your choice
- You can deploy in the region of your choice. For instructor led workshops, check with you instructor as the Azure SQL Database may require a specific region.
- Use both SQL and Microsoft Entry authentication methods and supply your own admin account and password. Keep this secure as you will need this in the next module.

### Database requirements

You have a requirement to deploy a new Azure SQL Database with the following requirements:

#### Basic options

- Create a new resource group of the name of your choosing or use an existing resource group. For instructor led workshops yo
- Create a new logical server and use a database name of your choice.
- You will not be using elastic pools.
- Use the following Compute+Storage options:
    - Use the General Purpose service tier and Provisioned Compute Tier.
    - Use the Standard-series (Gen5) hardware
    - Use Azure Hybrid Benefit to Save Money.
    - Use 2 vCores and 32GB Data Max size.
    - You do not have to make the database zone redundant.
- Use Geo-redundant backup storage.

#### Networking options

You will use the following Networking options for the deployment. You will not choose these during deployment but post-deployment.

- You will enable Public endpoint access to the Azure SQL Database and enable Allow Azure services and resources to access this server.
- If you are connecting from a client computer not in Azure you will enable a firewall rule for your client computer.
- Use the Default connection policy.
- Use TLS 1.2 for encryption.

#### Security options

Leave the default options as listed in the Azure portal for security option.

#### Additional Settings options

Use the following Additional settings options for the deployment:

- Since you are deploying a database for a proof of concept use the Sample option for existing data.
- Use the default collation of SQL_Latin1_CP1_CI_AS.
- Use the defaults for Maintenance Window.

You do not need to use any Tags.

## Exercise 7.1: Deploy an Azure SQL Database

### Deployment Steps

1. Use the Azure Portal to deploy a new Azure SQL Managed Instance that meets the requirements of the scenario.
1. After the deployment completes take note in the Azure Portal of the Managed Instance hostname.

### Post deployment steps

Perform the following steps after the deployment completes to perform a basic validation of the deployment by connecting to the Azure SQL Managed Instance. You will also examine in the Deployments for the resource group the duration of the Managed Instance deployment.

### Connect to the Azure SQL Database

1. Deploy a *jumpbox* virtual machine in the same virtual network as the Azure SQL Managed Instance. A recommended method is to use this QuickStart guide at https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/connect-vm-instance-configure.
1. Use Remote Desktop to connect into the Virtual Machine.
1. Verify you can connect to the Azure SQL Managed Instance deployment. Open SQL Server Management Studio (SSMS) and connect to the Azure SQL Managed Instance using the hostname, admin account, and password you created during the deployment. Tip: In the top right hand search edit box type in **PresentOn** to increase fonts and make it easier to see.

### View the deployment duration

1. First let's look at the deployment from the perspective of the resource group. If you are looking at your virtual machine in the Azure Portal you can click on your resource group or it may be listed in Resources on your home page. You can also search for your resource group in the search box at the top of the Azure Portal by typing in your resource group name and selecting it.
1. On the left-hand menu select **Deployments**.
1. The deployment name should start with "Microsoft.SQLManagedInstance....". If you scroll to the right you can see the Duration of the deployment. This is the time it took to deploy the Azure SQL Managed Instance.

## Exercise 7.2 - Configure and explore Azure SQL Database


## Exercise 7.3 - Scale Azure SQL Database


## Exercise 7.4 - Explore built-in HADR capabilities