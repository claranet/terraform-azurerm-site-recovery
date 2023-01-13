<<<<<<< HEAD
# site-recovery

Azure Site Recovery

## Getting started

To make it easy for you to get started with GitLab, here's a list of recommended next steps.

Already a pro? Just edit this README.md and make it your own. Want to make it easy? [Use the template at the bottom](#editing-this-readme)!

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://git.fr.clara.net/claranet/projects/cloud/azure/terraform/modules/site-recovery.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](https://git.fr.clara.net/claranet/projects/cloud/azure/terraform/modules/site-recovery/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Automatically merge when pipeline succeeds](https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing(SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

# Editing this README

When you're ready to make this README your own, just edit this file and use the handy template below (or feel free to structure it however you want - this is just a starting point!). Thank you to [makeareadme.com](https://www.makeareadme.com/) for this template.

## Suggestions for a good README
Every project is different, so consider which of these sections apply to yours. The sections used in the template are suggestions for most open source projects. Also keep in mind that while a README can be too long and detailed, too long is better than too short. If you think your README is too long, consider utilizing another form of documentation rather than cutting out information.

## Name
Choose a self-explaining name for your project.

## Description
Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.

## Badges
On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.

## Visuals
Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.

## Installation
Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
For open source projects, say how it is licensed.

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.
<<<<<<< HEAD
=======
=======
# Azure Resource Group
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/azure-site-recovery/azurerm/)

Common Azure terraform module to create an Azure Site Recovery configuration.

## Naming

Resource naming is based on the [Microsoft CAF naming convention best practices](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming). Legacy naming is available by setting the parameter `use_caf_naming` to false.
We rely on [the official Terraform Azure CAF naming provider](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name) to generate resource names.
>>>>>>> 3c24476 (AZ-935: Init module)

<!-- BEGIN_TF_DOCS -->
## Providers

<<<<<<< HEAD
No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.
=======
| Name | Version |
|------|---------|
| azurecaf | ~> 1.1 |
| azurerm | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| cache-storage-account | claranet/storage-account/azurerm | 7.3.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_recovery_services_vault.asr_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [azurerm_site_recovery_fabric.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_fabric) | resource |
| [azurerm_site_recovery_fabric.secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_fabric) | resource |
| [azurerm_site_recovery_network_mapping.network-mapping](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_network_mapping) | resource |
| [azurerm_site_recovery_protection_container.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container) | resource |
| [azurerm_site_recovery_protection_container.secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container) | resource |
| [azurerm_site_recovery_protection_container_mapping.container-mapping](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container_mapping) | resource |
| [azurerm_site_recovery_replicated_vm.vm-replication](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_replicated_vm) | resource |
| [azurerm_site_recovery_replication_policy.policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_replication_policy) | resource |
| [azurecaf_name.primary_srf](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.primary_srpc](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.rsv](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.secondary_srf](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.secondary_srpc](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cache\_storage\_advanced\_threat\_protection\_enabled | Boolean flag which controls if advanced threat protection is enabled, see [documentation](https://docs.microsoft.com/en-us/azure/storage/common/storage-advanced-threat-protection?tabs=azure-portal) for more information. | `bool` | `true` | no |
| cache\_storage\_allowed\_cidrs | List of public IPs allowed to access to the cache storage account. | `list(string)` | `[]` | no |
| cache\_storage\_allowed\_subnet\_ids | List of subnet ids allowed to access to the cache storage. All subnets of replicated VMs must be part of this list. | `list(string)` | `null` | no |
| cache\_storage\_custom\_name | Custom name for cache Storage Account. | `string` | `null` | no |
| cache\_storage\_resource\_group\_name | Resource Group name in which to deploy the cache Storage Account. | `string` | n/a | yes |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Additional tags to associate with your Azure Storage Account. | `map(string)` | `{}` | no |
| location | Azure region to use. | `string` | n/a | yes |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| network\_mapping | Map of VNET mapping. Source = Destination. | `map(string)` | `{}` | no |
| primary\_location | Location of source resources to be replicated. | `string` | n/a | yes |
| primary\_location\_short | Short name of the source location. | `any` | n/a | yes |
| primary\_site\_recovery\_fabric\_custom\_name | Custom name for Primary Azure Site Recovery Fabric. | `string` | `""` | no |
| primary\_site\_recovery\_protection\_container | Custom name for Primary Azure Site Recovery Protection Container. | `string` | `""` | no |
| recovery\_vault\_custom\_name | Custom name for Azure Recovery Vault. | `string` | `""` | no |
| replicated\_vms | Map of VMs to replicate with Azure Site Recovery. | <pre>map(<br>    object({<br>      vm_id                      = string<br>      target_resource_group_id   = string<br>      target_availability_set_id = optional(string, null)<br>      target_zone                = optional(number, null)<br>      target_network_id          = string<br><br>      managed_disks = list(object({<br>        disk_id   = string<br>        disk_type = string<br>      }))<br><br>      network_interfaces = list(object({<br>        network_interface_id          = string<br>        target_subnet_name            = string<br>        target_static_ip              = optional(string, null)<br>        recovery_public_ip_address_id = optional(string, null)<br>      }))<br>  }))</pre> | n/a | yes |
| replication\_policy | Site recovery replication policy. | <pre>object({<br>    name                                                 = string<br>    recovery_point_retention_in_minutes                  = optional(number, 1440) # 24h<br>    application_consistent_snapshot_frequency_in_minutes = optional(number, 240)  # 4h<br>  })</pre> | n/a | yes |
| resource\_group\_name | Resource group name | `string` | n/a | yes |
| secondary\_site\_recovery\_fabric\_custom\_name | Custom name for Secondary Azure Site Recovery Fabric. | `string` | `""` | no |
| secondary\_site\_recovery\_protection\_container | Custom name for Secondary Azure Site Recovery Protection Container. | `string` | `""` | no |
| stack | Project stack name. | `string` | n/a | yes |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `custom_rg_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |
>>>>>>> 3c24476 (AZ-935: Init module)

## Outputs

No outputs.
<!-- END_TF_DOCS -->
<<<<<<< HEAD
=======
## Related documentation

Azure Site Recovery documentation: [learn.microsoft.com/en-us/azure/site-recovery/site-recovery-overview](https://learn.microsoft.com/en-us/azure/site-recovery/site-recovery-overview)
>>>>>>> a8213ec (AZ-935: Init module)
>>>>>>> 3c24476 (AZ-935: Init module)
