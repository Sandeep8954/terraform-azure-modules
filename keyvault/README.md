# Azure Resource Group Terraform Module

## Description

Reusable Terraform module for creating Azure Resource Groups.

## Usage

<example>

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| name | string | - | Resource Group name |
| location | string | - | Azure region |
| tags | map(string) | {} | Resource tags |

## Outputs

| Name | Description |
|---|---|
| id | Resource Group ID |
| name | Resource Group name |
| location | Resource Group location |