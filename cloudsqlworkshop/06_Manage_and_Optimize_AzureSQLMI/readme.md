# Exercises for Managing and Optimizing Azure SQL Managed Instance

This is a pre-production version of exercises to manage and optimize Azure SQL Managed Instance.

## Prerequisites

- You must have completed Exercise 5.1 to deploy an Azure SQL Managed Instance.
- You will need a client computer that can use the Remote Desktop Protocol(RDP) and web browser to use the Azure Portal.
- You will use RDP to connect into the *jumpbox* virtual machine in Azure you deployed in Exercise 5.1.
- You will need access to files from the workshop at https://aka.ms/cloudsqlworkshop.

## Exercise 6.1 - Explore and optimize the Azure SQL Managed Instance deployment

In this exercise, you will use the Azure Portal and Azure Cloud Shell to explore various aspects of the Azure SQL Managed Instance deployment.

### Explore your deployment in the Azure Portal

1. Find your Azure SQL Managed Instance in the Azure Portal. You can use the search bar at the top of the Azure Portal to search for the name of your Azure SQL Managed Instance or you can find it in the resource group you deployed it to.
1. Select **November 2022 Feature Wave** from the left-hand menu and review the new innovations that are in the feature wave.
1. Select **Compute + Storage** from the left-hand menu. Review the various choices you have for service-tiers, Zone Redundancy, Hardware generation, vCores, and storage.
    1. Scroll down to the **Compute + Storage** section and select **View pricing details** and take note of the cost. Scroll back up to SQL Server License and select **Azure Hybrid Benefit (AHB)** and check the "I confirm..." option. Scroll down and see the Cost Savings.
    1. Scroll back up and Review the Backup Storage Redundancy options.
    1. Click on Apply to apply the AHB option. This will take a few minutes to apply.
1. Select **Maintenance** from the left-hand menu. Select the Maintenance drop-down and **review only** the options for Maintenance schedule and Maintenance window. The option for SQL Service health alerts are to setup notifications for maintenance events.
1. Scroll down and select **Private endpoint connections**. This is where you would create a private endpoint should it be needed for the security of your deployment.
1. Scroll down and select **Resource Health**. This is where you can view a history of the health of your deployment including any failover events that have occurred.

### Bonus Exercise: Use Azure CLI to explore your deployment

For instructor led workshops if time allows, you can use Azure CLI to explore your deployment. You can use the Azure Cloud Shell in the Azure Portal

1. Open the Azure Cloud Shell in the Azure Portal. You can use the search bar at the top of the Azure Portal to search for "Cloud Shell" or you can find it in the top right-hand corner of the Azure Portal.
1. The default is the Bash shell which works just fine for us to use Azure CLI.
1. Run the following command to see what is possible for az CLI for Managed Instances:

```azurecli-interactive
az sql mi --help
```
1. To see details of your Managed Instance run the following command:

```azurecli-interactive
az sql mi show --name <your managed instance name> --resource-group <your resource group name>
```

## Exercise 6.2 - Test perf

Notes:

- This would be about showing new tlog rates for BC tiers so we would create a table and show how initial ingestion with a SELECT INTO which runs in parallel is not hampered by tlog throttling.

## Exercise 6.3 - Look at SQL Server compatibility

Notes:

- Look at what SSMS looks like for MI noting differences and similarities for SQL Server.
- Look at common DMVs and catalog views
- Look at sp_configure
- Look at Query Store
- Create a SQL Agent job that executes CHECKDB on the database you created in 6.2

## Exercise 6.4 - Built-in HADR

Notes:

- Explore the backups that were auto crated when you created the dtb and see how you could easily do a PITR
- Explore any metadata that shows your replica was auto-created. Any catalog view or DMV. 
- Do a read-only replica query with SSMS
- Do a manual failover and see how easy it is to connect back to your db. Show the SQL Agent job is part of the failover.

## Bonus Exercise 6.5 - Backup and restore to SQL Server 2022

Notes:

- Using the jumpstart VM execute a COPY_ONLY backup to Azure Storage
- Restore the database to SQL Server 2022 on the jumpstart VM