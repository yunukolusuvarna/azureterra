# azureterra
Exercise 1: Examine the Terraform file (IaC) in your Source code
In this lab, you will use PartsUnlimited which is an example eCommerce website developed using .Net Core. You will examine the terraform file which helps you to provision the Azure Resources required to deploy PartsUnlimited website.
1.Navigate to the project you created above using Azure DevOps Demo Generator
![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/099bfee9-72da-49aa-aa25-1f87530e59d0)
![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/00d70a30-bcf3-4812-9e53-255a3826a101)
![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/98e5feeb-7437-48c3-a807-69bbb404a8ea)

2.Select Repos. Switch to terraform branch.
Make sure that you are now on the terraform branch and Terraform folder is there in the repo.
![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/bb8ab34d-5a03-4b06-8aa0-89fec56bc182)

Select the webapp.tf file under the Terraform folder. Go through the code.
![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/205883e2-bdb7-4a6d-ab5f-f37c30ea6820)

Exercise 2: Build your application using Azure CI Pipeline
1.Navigate to Pipelines –> Pipelines. Select Terraform-CI and click Edit.
![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/73ea7737-69a8-4f45-80b9-58ec86e32d7a)
![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/1dd8ec65-c9f1-4253-97a7-a478d799bb92)
![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/5fd2a62b-4139-406c-8dd3-80d1a23cd0f6)

 Note: We also have a YAML build pipeline if that’s something you’re interested in. To proceed through the YAML pipeline, choose Terraform-CI-YAML and click Edit to view the YAML pipeline. If you utilize the YAML pipeline, make sure to update the Terraform-CD release definition’s artifact link.
Your build pipeline will look like as below. This CI pipeline has tasks to compile .Net Core project. The dotnet tasks in the pipeline will restore dependencies, build, test and publish the build output into a zip file (package) which can be deployed to a web application.
![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/2d058906-7dac-48b0-8a5f-0852fe7e3b85)

In addition to the application build, we need to publish terraform files to build artifacts so that it will be available in CD pipeline. So we have added Copy files task to copy Terraform file to Artifacts directory.

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/32777aba-b685-4876-85a2-ee58deac5b15)

Now click Queue to trigger the build. Once the build succeeds, verify that the artifacts have Terraform folder and PartsUnlimitedwebsite.zip file in the drop.

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/72e3cf05-d392-4faa-abcb-d6dece0e7c92)

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/e5c8b438-b1a5-4c8b-bd93-de3f2d481a9b)

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/5f406725-b78e-48ad-a635-7ebe89be0ddd)

Exercise 3: Deploy resources using Terraform (IaC) in Azure CD pipeline

In this exercise, you will create azure resources using Terraform as part of your deployment(CD) pipeline and deploy the PartsUnlimited application to the App service provisioned by Terraform.

Navigate to Pipelines –> Releases. Select Terraform-CD and click Edit.

Select Dev stage and click View stage tasks to view the pipeline tasks.

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/040398dd-eef9-4259-bdd2-911e6e80b207)

You will see the tasks as below. Select the Azure CLI task. Select the Azure subscription from the drop-down list and click Authorize to configure Azure service connection.

We have to create container on microsoft azure

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/a945c619-b6e6-4135-92da-d7be75119a12)

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/a5044b87-8413-4f2b-9e7b-63e9bc539d45)

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/ec174133-c08b-4771-9775-a9c81aa466bd)

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/3f3d382d-f72c-4a43-8a5c-c0aba402eb9c)

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/f1177af6-9bbd-46ee-a35d-55387195f28f)

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/4269a651-7cc1-461f-b465-2b0916bceb82)

We have add the container details in CD Variables 

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/4c32f492-6609-4655-910e-ee7bef7ee857)

We have select the path of the azure app service

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/c0b3ac49-bfac-4e28-839a-dd68a6bab909)

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/adc98961-6621-4ffd-b7f1-7f3dcb817ef0)

Save the job and release the job 

You will see the tasks as below.

Select the Azure CLI task. Select the Azure subscription from the drop-down list and click Authorize to configure Azure service connection.


![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/829fc591-bc24-4c21-a305-70b126093337)


By default, Terraform stores state locally in a file named terraform.tfstate. When working with Terraform in a team, use of a local file makes Terraform usage complicated. With remote state, Terraform writes the state data to a remote data store. Here we are using Azure CLI task to create Azure storage account and storage container to store Terraform state. For more information on Terraform remote state click here

Select the Azure PowerShell task. Select Azure service connection from the drop-down.


![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/861364f5-181f-4071-bff3-b4e3ab90f299)

To configure the Terraform backend we need Storage account access key. Here we are using Azure PowerShell task to get the Access key of the storage account provisioned in the previous step.

Select the Replace tokens task.


![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/e213e950-4500-42a5-8acc-543ce6b6dd10)



If you observe the webapp.tf file in Exercise 1, Step 3 you will see there are few values are suffixed and prefixed with __. For example __terraformstorageaccount__. Using Replace tokens task we will replace those values with the variable values defined in the release pipeline.


![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/e626c3d1-4b4c-41aa-89cd-5d387f699e18)


Terraform tool installer task is used to install a specified version of Terraform from the Internet or the tools cache and prepends it to the PATH of the Azure Pipelines Agent (hosted or private).


![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/fbab4a97-5b00-4d1d-9a88-868a508e20d1)


When running Terraform in automation, the focus is usually on the core plan/apply cycle.

The main Terraform workflow is shown below:



i. Initialize the Terraform working directory.

ii. Produce a plan for changing resources to match the current configuration.

iii. Apply the changes described by the plan.

The next Terraform tasks in your release pipeline help you to implement this workflow.

Select the Terraform init task. Select Azure service connection from the drop-down. And make sure to enter the container name as terraform. For the other task parameters information see here


![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/260069cf-9880-45be-8555-92074cba11ab)




This task runs terraform init command. The terraform init command looks through all of the *.tf files in the current working directory and automatically downloads any of the providers required for them. In this example, it will download Azure provider as we are going to deploy Azure resources. For more information about terraform init command click here

Select the Terraform plan task. Select Azure service connection from the drop-down.


![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/35089dc8-0b86-4bf9-b1d3-112fc04da68f)


The terraform plan command is used to create an execution plan. Terraform determines what actions are necessary to achieve the desired state specified in the configuration files. This is a dry run and shows which actions will be made. For more information about terraform plan command click here

Select the Terraform Apply task. Select Azure service connection from the drop-down.


![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/ad08a198-10d0-4efd-8fec-12c22dec932d)


This task will run the terraform apply command to deploy the resources. By default, it will also prompt for confirmation that you want to apply those changes. Since we are automating the deployment we are adding auto-approve argument to not prompt for confirmation.

Select Azure App Service Deploy task. Select Azure service connection from the drop-down.


![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/8b741ce3-df74-4dc5-8e1e-efe3a80b7782)


This task will deploy the PartsUnlimited package to Azure app service which is provisioned by Terraform tasks in previous steps.

Once you are done Save the changes and Create a release.

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/f0f8bec8-16f4-489d-9477-5260076b8d7a)


![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/2c463162-303a-41af-bdc0-92cb23c4ef31)


![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/0e880294-3c75-4c3b-8863-cc35fae1996a)

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/5fb263c6-caa2-4e89-b05b-5041ec967915)

Once the release is success navigate to your Azure portal. Search for pulterraformweb in App services. Select pulterraformweb-xxxx and browse to view the application deployed.

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/b1dd28d5-8f3f-41e3-9858-e9f3815ffab3)

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/80ec7245-550e-4299-86f4-c37bed12e9bb)

![image](https://github.com/yunukolusuvarna/azureterra/assets/134670646/6253f019-8a63-4a11-bf06-3fc702127864)
