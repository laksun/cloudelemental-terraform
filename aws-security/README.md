# Cards CyberSecurity

Terraform for AWS SecurityHub, GuardDuty, Macie and Inspector

Project description - Security Infrastructure for the Accounts

- [Getting Started](#getting-started)
- [How it Works](#how-it-works)
- [Developing](#developing)
  - [Prerequisites](#prerequisites)
  - [Testing](#testing)
  - [Contributing](#contributing)
- [Digital Engineering](#digital-engineering)
- [Licensing](#licensing)

cards security

## Getting Started

### AWS SecurityHub

Securityhub:

**Inputs**

List of:

- account_id = string
- email = string

Flags

- CIS Standard

- PCI standard

- AWS foundational standard

```terraform

resource "aws_securityhub_account" "main" {}
resource "aws_securityhub_member"  "members"  {}
resource "aws_securityhub_standards_subscription"  "cis"  {}
resource  "aws_securityhub_standards_subscription"   "aws_foundational"  {}
resource "aws_securityhub_standards_subscription"  "pci_dss"  {}

```

### AWS GuardDuty:

Member accounts should be defined for the code

**Inputs:**

- master_account_id

- member_accounts:

* account_id

* email

```terraform
resource "aws_guardduty_member" "members" {}
resource "aws_guardduty_invite_accepter" "master" {}

```

### AWS Inspector Terraform resources

```terraform
resource "aws_inspector_assessment_target" "assessment" {}

resource "aws_inspector_assessment_template" "assessment" {}

variable   "ruleset_cis" {}
variable   "ruleset_cve"  {}
variable   "ruleset_network_reachability" {}
variable   "ruleset_security_best_practices"  {}
```

AWS Macie:

Prerequisite:

Macie needs to be enabled manually before terraform is applied
Terraform resources:

```terraform
resource "aws_macie_member_account_association" "association" {}
resource "aws_macie_s3_bucket_association" "example" {}
```

## How it works

{Describe how it works. Include images if possible.}

## Developing

{Show how engineers can set up a development environment and contribute.}

### Prerequisites

{Explain the prerequisites}

### Testing

{Notes on testing}

### Contributing

{How can the community contribute}

## Digital Engineering

{List generic details of the team who maintains the repository }

## Licensing

OneMain Internal Only - [full license](./LICENSE)

## .gitconfig

This contains pre-approved patterns that won't be blocked by .gitsecrets during commits, pushes and pull requests.

To sync these changes locally with your machine run:

```bash
git config --local include.path ../.gitconfig
```

## .ignore files

Remove any ignore files you don't need for your project and rename the one you do to .gitignore.
After this, remove this section of the readme.
