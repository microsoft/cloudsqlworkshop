# Exercises to Deploy, Manage, and Optimize Azure SQL Database

This is a set of exercises to deploy, manage, and optimize an Azure SQL Database. The exercises are designed to be completed in order as each exercise builds on the previous exercise. The exercises are designed to be completed in a workshop environment with an instructor; however, you can also complete them on your own if you have the necessary Azure subscription and resources. This Module is completely independent of previous modules and can be completed on its own.

## Prerequisites

- You must have an Azure subscription with the ability to create an Azure SQL Database using the General Purpose Service Tier. You must have the ability to create an Azure SQL Database in the Azure region of your choice.
- You need a client computer to connect and run workloads against Azure SQL Database. You can use your own computer or use an Azure Virtual Machine. If you use an Azure Virtual Machine you will be automatically enabled to connect to Azure SQL Database. If you use your own client computer you will need to enable a firewall setting. This will be described in more detail in the exercise to deploy the Azure SQL Database.
- You will need access to files from the workshop at https://aka.ms/cloudsqlworkshop.

**Note:** For instructor led workshops you may use the same virtual machine you deployed in Module 3 of this workshop.

## Scenario

You are deploying a new Azure SQL Database for a proof of concept. 

### Logical Server requirements

You have a requirement to deploy a new Azure SQL Database Logical Server with the following requirements:

- Use the logical server name of your choice
- Use the resource group of your choice. You can use an existing resource group from previous modules. Your instructor may also indicate a specific resource group to use.
- You can deploy in the region of your choice. For instructor led workshops, check with you instructor as the Azure SQL Database may require a specific region.
- For your initial deployment for Authentication method use the option called Use SQL Authentication and provide and admin and password. If you have access to a Microsoft Entry directory you will change this option later in the module.

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

You will use the following Networking options for the deployment. You will not choose these during deployment but during a later exercise on configuration.

- You will enable Public endpoint access to the Azure SQL Database and enable Allow Azure services and resources to access this server.
- If you are connecting from a client computer not in Azure you will enable a firewall rule for your client computer later in this module.
- Use the Default connection policy.
- Use TLS 1.2 for encryption.

#### Security options

Leave the default options as listed in the Azure portal security options.

#### Additional Settings options

Use the following Additional settings options for the deployment:

- Since you are deploying a database for a proof of concept use the **Sample** option for existing data.
- Use the default collation of SQL_Latin1_CP1_CI_AS.

You do not need to use any Tags.

## Exercise 7.1: Deploy an Azure SQL Database

In this exercise you will deploy an Azure SQL Logical Server and Database per the scenario requirements listed above in this module. You will then perform a basic validation of the deployment by examining the Deployments for the resource group the duration of the Database deployment.

### Deployment Steps

1. Use the Azure Portal to deploy a new Azure SQL Logical Server and Database that meets the requirements of the scenario listed above in this module.
1. To help you get started in the Azure Portal type in Azure SQL in the search box and choose **Azure SQL** and then choose **Azure SQL** from the Marketplace section.
3. You should see three choices for Azure SQL. Use the choice called **SQL databases,** leave the default Single database, and click Create.
1. Now go through Basics through Additional Settings based on the scenario requirements listed above in this module. Here are a few tips as you use the portal to deploy the database.
    1. For Server, select Create new and use the options listed in the scenario requirements above in this module.
    1. For Networking, select Public Endpoint, Check Allow Azure services and resources to access this server and all other options should be left as default.
    1. When you are done with your choices, click Review + Create. A brief validation will occur and then you can click Create to start the deployment. Your screen will change to say Deployment in progress. You can leave this screen up or change context as this is an async operation. If you stay on this screen click on **Go to Resource**.
1. After the deployment completes take note in the Azure Portal of the Server Name and the database name.

### Post deployment steps

Perform the following steps after the deployment completes to perform a basic validation of the deployment by examining the Deployment for the resource group the duration of the Logical Server and Database deployment.

1. First let's look at the deployment from the perspective of the resource group. If you are looking at your SQL database in the Azure Portal you can click on your resource group or it may be listed in Resources on your home page. You can also search for your resource group in the search box at the top of the Azure Portal by typing in your resource group name and selecting it.
1. On the left-hand menu select **Deployments**.
1. The deployment name should start with "Microsoft.SQLDatabase.newDatabaseNewServer...". If you scroll to the right you can see the Duration of the deployment. This is the time it took to deploy the Azure SQL Logical Server and Database. You can click on the deployment name to see more details about the deployment.

## Exercise 7.2 - Configure and explore Azure SQL Database


## Exercise 7.3 - Scale Azure SQL Database

### Setup

You might have already performed some of these steps if you completed Module 04 of this workshop.

- Download the ostress program for the workload from https://aka.ms/ostress. Run the install program from the GUI.
- Create a folder called **cloudsqlworkshop** on the c: drive. Inside this folder create another one called **scaleazuresqldb**
- Copy the **workload.cmd** and **xXXXXXX** files from the GitHub clone or download to the cloudsqlworkshop\scaleazuresqldb folder.


## Exercise 7.4 - Explore built-in HADR capabilities