# Terraform AWS Configuration

![terraform](https://github.com/user-attachments/assets/25f7ffe6-2f75-46b7-a1ec-8a5ba2ca0016)

This Terraform configuration sets up an AWS environment with a security group and EC2 instances.

## Table of Contents

- [Terraform AWS Configuration](#terraform-aws-configuration)
  - [Table of Contents](#table-of-contents)
  - [Key Components](#key-components)
  - [VPC Configuration](#vpc-configuration)
    - [Create a new VPC](#create-a-new-vpc)
  - [RDS Setup](#rds-setup)
    - [DB Subnet Group](#db-subnet-group)
  - [Alert](#alert)
  - [Configure Alerting for CPU Utilization](#configure-alerting-for-cpu-utilization)
    - [Example Configuration](#example-configuration)


## Key Components

- **AWS Security Group**: Allows SSH (port 22) and HTTP (port 3306) inbound traffic from anywhere.
- **EC2 Instances**: Launches 2 `t3.micro` instances with Ubuntu 24.04 LTS.

```bash
cd terraform
terraform init
terraform plan
terraform apply
```
![2](https://github.com/user-attachments/assets/e232e994-1da2-4e27-8b96-7d82ca95c4ba)

## VPC Configuration

The VPC (Virtual Private Cloud) is defined in the [vpc.tf](vpc.tf) file. Below are the details of the VPC configuration:

- **Resource Name:** `aws_vpc.my_vpc`
- **CIDR Block:** The CIDR block for the VPC is specified by the variable `var.cider_range["cider1"]`.
- **DNS Support:** DNS support is enabled (`enable_dns_support = true`).
- **DNS Hostnames:** DNS hostnames are enabled (`enable_dns_hostnames = true`).
- **Tags:** The VPC is tagged with a name specified by the variable `var.vpc_name`.

### Create a new VPC

![5](https://github.com/user-attachments/assets/e736d3b7-9570-4181-8e49-cc5ffb76a435)

## RDS Setup

The `RDS.tf` file contains the configuration for setting up an RDS instance and its associated subnet group.

### DB Subnet Group

The `aws_db_subnet_group` resource defines a subnet group for the RDS instance:

```terraform
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = aws_subnet.my_subnet[*].id

  tags = {
    Name = "MyDBSubnetGroup"
  }
}
```

![6](https://github.com/user-attachments/assets/2a6451fa-709a-4003-829d-a3771f1b540c)


## Alert
## Configure Alerting for CPU Utilization

To configure alerting on the machines for CPU utilization, follow these steps:

1. **Create a CloudWatch Alarm**: Define a CloudWatch alarm to monitor the CPU utilization of your EC2 instances.

2. **Set Up SNS Topic**: Create an SNS (Simple Notification Service) topic to send notifications.

3. **Subscribe to the SNS Topic**: Subscribe your email to the SNS topic to receive alerts.

![1](https://github.com/user-attachments/assets/a0211a6a-346e-4322-9d9e-d6ec1c32864c)


### Example Configuration

Add the following resources to your Terraform configuration:

```hcl
# Create SNS Topic
resource "aws_sns_topic" "cpu_alerts" {
  name = "cpu_alerts"
}

# Subscribe to SNS Topic
resource "aws_sns_topic_subscription" "cpu_alerts_subscription" {
  topic_arn = aws_sns_topic.cpu_alerts.arn
  protocol  = "email"
  endpoint  = "ahmedmamdouh51099@gmail.com"
}

# Create CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high_cpu_utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "50"
  alarm_description   = "This alarm monitors EC2 CPU utilization"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.cpu_alerts.arn]
}
```
![4](https://github.com/user-attachments/assets/de9a125f-5218-4120-86ee-604012b83e13)

After finishing from AWS machines
```bash
terraform destory
```
