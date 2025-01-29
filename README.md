# Packer Template for Golden Amazon Linux 2 AMI

This repository contains a Packer template to create a custom Amazon Machine Image (AMI) based on Amazon Linux 2, with a Chef provisioning script to configure the instance with necessary software and tools. It also includes a GitHub Actions workflow to automate the build process.

## Requirements

Before using this Packer template, ensure that the following are installed on your local machine:

- [Packer](https://www.packer.io/downloads)
- [AWS CLI](https://aws.amazon.com/cli/)
- [Chef](https://docs.chef.io/workstation/)
- [AWS credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) configured for access.

## Template Overview

This Packer template provisions a new AMI based on the latest Amazon Linux 2 image and applies a Chef-based configuration. The resulting AMI is tagged as `custom-amazon-linux-2-{{timestamp}}` and is configured for use in a production environment.

### Key Features

- **Amazon Linux 2 AMI:** Uses the latest Amazon Linux 2 AMI from AWS.
- **Custom Tags:** Adds tags for `Name` and `Environment`.
- **Chef Provisioning:** Configures the AMI using Chef recipes:
  - `aws_ssm_plugin::default` — Installs and configures the AWS Systems Manager (SSM) plugin.
  - `cloudwatch_agent::default` — Installs and configures the CloudWatch Agent.
  - `postgres_db::default` — Installs and configures PostgreSQL.

## GitHub Actions Workflow

This project includes a GitHub Actions workflow to automate the process of building the AMI using Packer. The workflow is triggered on a push to the `main` branch or via manual dispatch.

### Workflow Steps

1. **Checkout Code:** The action checks out the code from the repository.
2. **Set up Packer:** The `hashicorp/setup-packer` action sets up Packer on the GitHub runner.
3. **Configure AWS Credentials:** The `aws-actions/configure-aws-credentials` action configures AWS credentials for the workflow, using secrets stored in GitHub Actions (e.g., `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`).
4. **Install Chef:** ChefDK is installed to ensure that Chef provisioning can be run.
5. **Packer Initialization:** The workflow runs `packer init` to initialize the Packer template.
6. **Packer Validation:** The workflow validates the Packer template using `packer validate`.
7. **Build Packer Image:** Finally, the workflow runs `packer build` to create the custom AMI "GOLDEN IMAGE name will be appear in this stage".

### Workflow YAML File

Below is the GitHub Actions workflow YAML file (`.github/workflows/packer-ami-build.yml`):

