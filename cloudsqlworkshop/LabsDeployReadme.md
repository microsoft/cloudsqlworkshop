
# Workshop: The Cloud Workshop for the SQL Professional

| Exercise Link                                                                                   | Description                                                                                                         |
|-------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| [Exercise 3 - Deploy SQL Azure VM](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/03_Deploy_SQL_AzureVM)          | Exercise 3 on SQL IaaS, Part 1: Deploying SQL Server on Azure Virtual Machines.                                      |
| [Exercise 4 - Manage and Optimiza SQL Azure VM](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/04_Manage_and_Optimize_SQL_AzureVM) | Exercise 4 on SQL IaaS, Part 2: Managing and Optimizing SQL Server on Azure Virtual Machines.                        |
| [Exercise 5 - Deploy Azure SQL MI](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/05_Deploy_AzureSQLMI)             | Exercise 5 on SQL MI, Part 1: Deploying Azure SQL Managed Instance.                                                    |
| [Exercise 6 - Manage and Optimiza  Azure SQL MI](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/06_Manage_and_Optimize_AzureSQLMI) | Exercise 6 on SQL MI, Part 2: Managing and Optimizing Azure SQL Managed Instance.                                      |
| [Exercise 7 - Deploy, Manage and Optimize Azure SQL DB](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/07_Deploy_Manage_Optimize_AzureSQLDB) | Exercise 7 on SQL DB: Deploying, Managing, and Optimizing Azure SQL Databases.                                        |

**Note:** Modules 1 and 2 are fundamentals about Azure and Azure SQL but have no hands-on exercises. You can review the materials in the supplied presentation. It is highly recommend to review these module slides before working on the hands-on exercises for the rest of the modules. Modules 3 and 4 are about SQL Server on Azure Virtual Machines and designed to be completed together. Modules 5 and 6 are about Azure SQL Managed Instance and designed to be taken together. Module 7 is about Azure SQL Database and can be taken independently from other modules.

NOTE: Lab 03, and Lab 04 shares the same setup. If you have completed Lab 03, you don't need to setup resources for Lab 04 and viceversa. 
NOTE: Lab 05, and Lab 06 shares the same setup. If you have completed Lab 05, you don't need to setup resources for Lab 06 and viceversa. 

All details here: [Workshop labs](https://github.com/microsoft/cloudsqlworkshop/tree/main?tab=readme-ov-file#------setup).

## Exercises

- [Exercise 3 - Deploy SQL Azure VM](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/03_Deploy_SQL_AzureVM)
- [Exercise 4 - Manage and Optimiza SQL Azure VM](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/04_Manage_and_Optimize_SQL_AzureVM)
- [Exercise 5 - Deploy Azure SQL MI](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/05_Deploy_AzureSQLMI)
- [Exercise 6 - Manage and Optimiza  Azure SQL MI](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/06_Manage_and_Optimize_AzureSQLMI)
- [Exercise 7 - Deploy, Manage and Optimize Azure SQL DB](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/07_Deploy_Manage_Optimize_AzureSQLDB)


## Bicep code for the exercises


- [Exercise 3 - Deploy SQL Azure VM](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/03_Deploy_SQL_AzureVM)
- [Exercise 4 - Manage and Optimiza SQL Azure VM](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/04_Manage_and_Optimize_SQL_AzureVM)
- [Exercise 5 - Deploy Azure SQL MI](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/05_Deploy_AzureSQLMI)
- [Exercise 6 - Manage and Optimiza  Azure SQL MI](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/06_Manage_and_Optimize_AzureSQLMI)
- [Exercise 7 - Deploy, Manage and Optimize Azure SQL DB](https://github.com/microsoft/cloudsqlworkshop/tree/main/cloudsqlworkshop/07_Deploy_Manage_Optimize_AzureSQLDB)


| Module | link |
|-------|-----------|
| Exercise 3 - Deploy SQL Azure VM| [Readme](./03_Deploy_SQL_AzureVM/ReadmeLabsDeploy.md) |
| Exercise 4 - Manage and Optimiza SQL Azure V| [Readme](./04_Manage_and_Optimize_SQL_AzureVM/ReadmeLabsDeploy.md) |
| Exercise 5 - Deploy Azure SQL MI | [Readme](./05_Deploy_AzureSQLMI/ReadmeLabsDeploy.md) |
| Exercise 6 - Manage and Optimiza  Azure SQL MI | [Readme](./06_Manage_and_Optimize_AzureSQLMI/ReadmeLabsDeploy.md) |
| Exercise 7 - Deploy, Manage and Optimize Azure SQL DB | [Readme](./07_Deploy_Manage_Optimize_AzureSQLDB/ReadmeLabsDeploy.md) |


---

## Installing Visual Studio Code (VS Code)

#### Windows and macOS:

1. **Download VS Code**: Visit the [Visual Studio Code website](https://code.visualstudio.com/) and download the installer for your operating system.

2. **Install VS Code**: Run the downloaded installer and follow the on-screen instructions to install Visual Studio Code on your system.

#### Linux (Ubuntu/Debian):

1. **Install via apt**:
   ```bash
   sudo apt update
   sudo apt install code
   ```

#### Running Visual Studio Code:

- **Windows**: Search for "Visual Studio Code" in the Start menu and click on the application.
- **macOS**: Open Finder, navigate to the Applications folder, and double-click on "Visual Studio Code".
- **Linux**: Launch VS Code from the terminal by running `code`.

### Essential Extensions for Azure Development in VS Code

1. **Azure Account**: Provides a single Azure sign-in and subscription management experience.
   - [Azure Account Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account)

2. **Azure Resource Manager (ARM) Tools**: Author, test, and deploy Azure Resource Manager templates.
   - [ARM Tools Extension](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools)

3. **Azure CLI Tools**: Integrate Azure CLI commands into VS Code for seamless Azure management.
   - [Azure CLI Tools Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azurecli)

4. **Azure Bicep**: Write, validate, and deploy Azure Resource Manager templates using Bicep language.
   - [Azure Bicep Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep)

5. **Azure Functions**: Develop, debug, and deploy Azure Functions directly from VS Code.
   - [Azure Functions Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions)

6. **Azure Storage**: Manage Azure Storage resources, including blobs, queues, tables, and file shares.
   - [Azure Storage Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurestorage)

7. **Azure Logic Apps**: Design, build, and deploy Azure Logic Apps workflows.
   - [Azure Logic Apps Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurelogicapps)

### Installation Steps:

1. Open Visual Studio Code.
2. Go to the Extensions view by clicking on the square icon on the sidebar or pressing `Ctrl+Shift+X`.
3. Search for each extension by name in the search bar.
4. Click on the extension you want to install and then click the "Install" button.

These extensions will provide you with the necessary tools to develop and deploy Azure resources efficiently from within Visual Studio Code. Let me know if you need further assistance!

## Executing Bicep from Visual Studio Code

### Prerequisites

1. **Install Bicep extension**: Ensure you have the [Bicep extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep) installed for Visual Studio Code. You can find and install it from the Extensions view (`Ctrl+Shift+X`).

2. **Install Bicep CLI**: Make sure you have the [Bicep CLI](https://github.com/Azure/bicep/blob/main/docs/installing.md) installed on your system. This is required for compiling Bicep files.

### Steps to Execute

1. **Create a Bicep file**: Create a new file with the `.bicep` extension or open an existing one.

2. **Write Bicep code**: Write your Bicep code in the file. Utilize the features such as autocompletion and validation provided by the Bicep extension to assist you during writing.

3. **Compile the Bicep file**: Open the Command Palette in Visual Studio Code (`Ctrl+Shift+P` or `Cmd+Shift+P` on macOS) and select the "Bicep: Build" command.

4. **Execute the generated ARM template**: Once the Bicep file is compiled, an equivalent ARM Template (JSON) file will be generated. You can execute this ARM template in Azure Resource Manager (ARM) to deploy your infrastructure on Azure.

### Further Resources

- [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep)
- [Bicep CLI installation guide](https://github.com/Azure/bicep/blob/main/docs/installing.md)

---

This guide should help you execute Bicep files seamlessly from Visual Studio Code. Let me know if you need further assistance!



# Learning resources

## Azure Fundamentals

| Title of Content                                    | Level       | Source                                      |
|-----------------------------------------------------|-------------|---------------------------------------------|
| [Azure Fundamentals - Learning Path](https://docs.microsoft.com/en-us/learn/paths/azure-fundamentals/) | Beginner | Microsoft Learn                             |
| [Microsoft Azure for Beginners: Create a Virtual Machine](https://www.coursera.org/learn/microsoft-azure-virtual-machine) | Beginner | Coursera                                    |
| [Getting Started with Azure](https://www.linkedin.com/learning/learning-azure-2/getting-started-with-azure) | Beginner | LinkedIn Learning                           |
| [Microsoft Azure: Core Functionalities](https://www.edx.org/course/principles-of-cloud-computing) | Beginner | edX                                         |


## BICEP

| Title of Content                                    | Level       | Source                                      |
|-----------------------------------------------------|-------------|---------------------------------------------|
| [Bicep Documentation - Quickstart](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/quickstart-create-bicep) | Beginner | Microsoft Docs                              |
| [Introduction to Azure Bicep](https://www.youtube.com/watch?v=oxZLhQFJTqs) | Beginner | YouTube                                     |
| [Bicep Workshop](https://github.com/Azure/bicep/blob/main/docs/tutorial/01-simple-template.md) | Beginner | GitHub                                      |
| [Deploy Azure resources with Bicep - MS Learn](https://docs.microsoft.com/en-us/learn/modules/deploy-resources-bicep/) | Beginner | Microsoft Learn                             |


## SQL IaaS

| Title of Content                                             | Level       | Source                                      |
|--------------------------------------------------------------|-------------|---------------------------------------------|
| [Deploy SQL Server using Azure VM](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/sql-server-on-azure-vm-iaas-overview) | Beginner | Microsoft Docs                              |
| [Best Practices for SQL Server on Azure Virtual Machines](https://www.microsoft.com/itshowcase/Article/Content/1074/Best-practices-for-running-SQL-Server-on-Azure-Virtual-Machines) | Intermediate | Microsoft                                  |
| [Migrate SQL Workloads to Azure](https://www.coursera.org/learn/migrate-sql-workloads-to-azure) | Intermediate | Coursera                                    |
| [SQL Server on Azure VMs: A Comprehensive Guide](https://azure.microsoft.com/en-us/resources/videos/azure-friday-sql-server-on-azure-vms/) | Beginner | Microsoft                                   |
| [Manage SQL Server in Azure VMs](https://docs.microsoft.com/en-us/learn/modules/welcome-to-sql-server-on-azure-vm/) | Beginner | Microsoft Learn                             |


## SQL DB

| Title of Content                                             | Level       | Source                                      |
|--------------------------------------------------------------|-------------|---------------------------------------------|
| [Introduction to Azure SQL Database](https://docs.microsoft.com/en-us/azure/azure-sql/database/sql-database-paas-overview) | Beginner | Microsoft Docs                              |
| [Security Features of Azure SQL Database](https://www.coursera.org/learn/security-features-azure-sql-database) | Intermediate | Coursera                                    |
| [Building Applications with Azure SQL Database](https://azure.microsoft.com/en-us/resources/videos/building-applications-using-azure-sql-database/) | Beginner | Microsoft                                   |
| [Azure SQL Fundamentals on Microsoft Learn](https://docs.microsoft.com/en-us/learn/paths/azure-sql-fundamentals/) | Beginner | Microsoft Learn                             |


## SQL MI

| Title of Content                                             | Level       | Source                                      |
|--------------------------------------------------------------|-------------|---------------------------------------------|
| [What is Azure SQL Managed Instance?](https://docs.microsoft.com/en-us/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview) | Beginner | Microsoft Docs                              |
| [Managing Performance in Azure SQL Managed Instance](https://www.coursera.org/learn/managing-performance-azure-sql-managed-instance) | Intermediate | Coursera                                    |
| [Implementing High Availability and Disaster Recovery in Azure SQL Managed Instance](https://azure.microsoft.com/en-us/resources/videos/implementing-high-availability-and-disaster-recovery-in-azure-sql-managed-instance/) | Intermediate | Microsoft                                   |
| [Azure SQL Managed Instance Technical Overview](https://docs.microsoft.com/en-us/learn/modules/welcome-to-sql-managed-instance/) | Beginner | Microsoft Learn                             |
