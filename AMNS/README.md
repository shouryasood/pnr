# AMNS GCP Source Repository for IAC

This Repository is created to store and maintain terraform tamplates[IAC] for AMNS including PD and DR region. This repository organises templates as per Region, Project and Environment using different directories. Parent folder contains 3 sub folders as below.

- [DC](DC) -  Stores IAC templates related to PD Region which further contains subfolders for core and IAAS.
    - [core](DC/core) - This folders stores configuration related to core services. e.g. folders, projects, TF storage Buckets, Org Policies
    - [iaas](DC/iaas) -  This folder contains templates for iaas services e.g. VPCs, Routers, Firewall rules, router rules, service accounts, VMs, Disks . This directory further contains sub directories for different GCP folders e.g - HST, INF, SAP. 
        - [HST](DC/iaas/HST) - This directory holds configuration templates for resources in  Host projects
        - [INF](DC/iaas/INF) - This directory holds configuration templates for resources in  Infra projects
        - [SAP](DC/iaas/SAP) - This directory contains sub directories for SAP PROD , NPROD and Sandbox projects.
            - [PRD](DC/iaas/SAP/PRD) - Contains tf files for SAP Production Project.
            - [NPRD](DC/iaas/SAP/NPRD) - Contains tf files for SAP Non Production Project.
            - [SB](DC/iaas/SAP/SB) - Contains tf files for SAP Sandbox Project.
- [DR](DR) -  Stores IAC templates related to DR Region. Directory structure is similar to DC region. Structure is provided below.
- [modules](modules) - Stores custom modules used in PD and DR templates for ease of reusability and deployment.


## Parent Folder Structure

Folder structure for holding environment/project specific templates is as follows:

```hcl
.
|-- DC
|   |-- core
|   `-- iaas
|       |-- HST
|       |-- INF
|       `-- SAP
|           |-- NPRD
|           |-- PRD
|           `-- SB
|-- DR
|   |-- core
|   `-- iaas
|       `-- HST
`-- modules
    |-- cloud-router
    |-- policies
    |-- routes
    |-- service_accounts
    |-- subnets
    |-- vpc
    `-- vpc-peering

```

## Usage

In order to create any resource using terraform we need to first identify respective folder and then add templates. e.g. for creating VM in PD SAP production env, Path will be c19c7c1pdpsr-01/DC/iaas/SAP/PRD.

README.md documets has been created in respective folders for details on resources and execution of terraform.