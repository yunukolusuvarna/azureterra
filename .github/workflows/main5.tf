trigger:
- main

pool:
  vmimage: 'windows-2019'

variables:
   BuildConfiguration: 'release'
   buildPlatform: 'any cpu'
    
steps:
- powershell: 'choco install dotnetcore-sdk --version=2.0.0'
  displayName: 'Install .net core 2.0.0'
- task: DotNetCoreCLI@2
  displayName: Restore  
  inputs:
    command: 'restore'
    projects: '**/*.csproj'

- task: DotNetCoreCLI@2
  displayName: Build
  inputs:
    command: 'build'
    projects: '**/*.csproj'
    arguments: '--configuration $(BuildConfiguration)'

- task: DotNetCoreCLI@2
  displayName: Test
  inputs:
    command: test
    projects: '**/*[Tt]ests/*.csproj'
    arguments: '--configuration $(BuildConfiguration)'

- task: DotNetCoreCLI@2
  displayName: Publish
  inputs:
    command: 'publish'
    publishWebProjects: true
    arguments: '--configuration $(BuildConfiguration) --output $(build.artifactstagingdirectory)'
    
- task: CopyFiles@2
  displayName: 'Copy Terraform files to artifacts'
  inputs:
    SourceFolder: Terraform
    TargetFolder: '$(build.artifactstagingdirectory)/Terraform'

- task: PublishBuildArtifacts@1
  displayName: 'Publish Artifact'
  inputs:
    PathtoPublish: '$(build.artifactstagingdirectory)'
