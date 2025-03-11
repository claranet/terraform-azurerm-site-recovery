## 8.0.0 (2025-03-11)

### ⚠ BREAKING CHANGES

* **AZ-1088:** AzureRM Provider v4+ and OpenTofu 1.8+
* **AZ-1088:** module v8 structure and updates

### Features

* **AZ-1088:** module v8 structure and updates cf178aa
* **AZ-1088:** module v8 structure and updates 6793ca8

### Bug Fixes

* **AZ-1088:** fix example af07941
* update example, locals, README be37654

### Miscellaneous Chores

* **deps:** update dependency claranet/diagnostic-settings/azurerm to v8 be7c111
* **deps:** update dependency claranet/storage-account/azurerm to ~> 7.14.0 a2c3185
* **deps:** update dependency claranet/storage-account/azurerm to v8 d6da31e
* **deps:** update dependency opentofu to v1.8.3 29f78e6
* **deps:** update dependency opentofu to v1.8.4 de51df9
* **deps:** update dependency opentofu to v1.8.6 f27c477
* **deps:** update dependency opentofu to v1.8.8 4eb6964
* **deps:** update dependency opentofu to v1.9.0 7542504
* **deps:** update dependency pre-commit to v4 249fc2c
* **deps:** update dependency pre-commit to v4.0.1 a8b7e0a
* **deps:** update dependency pre-commit to v4.1.0 c08f607
* **deps:** update dependency tflint to v0.54.0 43554c7
* **deps:** update dependency tflint to v0.55.0 88799e0
* **deps:** update dependency trivy to v0.56.1 b68a94d
* **deps:** update dependency trivy to v0.56.2 b5881cc
* **deps:** update dependency trivy to v0.57.1 b7a0f24
* **deps:** update dependency trivy to v0.58.1 750392c
* **deps:** update dependency trivy to v0.58.2 59acf48
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.19.0 6df4903
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.20.0 0136eda
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v5 75824ae
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.1.0 4cb98bd
* **deps:** update terraform azapi to v2 e4c72c2
* **deps:** update terraform claranet/diagnostic-settings/azurerm to v7 eb388c7
* **deps:** update tools 96624e4
* **deps:** update tools 50dc830
* prepare for new examples structure 6bfe4b6
* update examples structure 1e739c5
* update Github templates a03e765
* update tflint config for v0.55.0 4920f5c

## 7.1.0 (2024-10-03)

### Features

* use Claranet "azurecaf" provider 539f2d3

### Documentation

* update README badge to use OpenTofu registry 2419d64
* update README with `terraform-docs` v0.19.0 395ccb7

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.8.2 b188e95
* **deps:** update dependency terraform-docs to v0.19.0 b2ce030
* **deps:** update dependency trivy to v0.55.0 c6215e7
* **deps:** update dependency trivy to v0.55.1 f39d60f
* **deps:** update dependency trivy to v0.55.2 d330d4f
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 d9c1dc5
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 9ad30d6
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.2 2844dc1
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 b8008af
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 866a9ff
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 ba27a95
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.1 45218e0

## 7.0.3 (2024-08-30)

### Bug Fixes

* bump `storage-account` to latest version 1c10507

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.7.3 faf8eca
* **deps:** update dependency opentofu to v1.8.1 6baf055
* **deps:** update dependency pre-commit to v3.8.0 4e0cb64
* **deps:** update dependency tflint to v0.51.2 deb577b
* **deps:** update dependency tflint to v0.52.0 8b2b058
* **deps:** update dependency tflint to v0.53.0 df4d9ae
* **deps:** update dependency trivy to v0.53.0 9c18afd
* **deps:** update dependency trivy to v0.54.1 8a8facf
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 fdf2cbe
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 82b7b3f
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.1 0d884c0
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.2 18aee13
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 add7948
* **deps:** update tools b5d2b4b

## 7.0.2 (2024-06-14)


### ⚠ BREAKING CHANGES

* bump minimum AzureRM provider version

### Code Refactoring

* module storage requires provider `v3.102+` fe7c8d6


### Miscellaneous Chores

* **deps:** update dependency claranet/storage-account/azurerm to ~> 7.13.0 592fe96
* **deps:** update dependency opentofu to v1.7.0 c831a24
* **deps:** update dependency opentofu to v1.7.1 edf1deb
* **deps:** update dependency opentofu to v1.7.2 627107a
* **deps:** update dependency pre-commit to v3.7.1 b5e2c91
* **deps:** update dependency terraform-docs to v0.18.0 7495746
* **deps:** update dependency tflint to v0.51.0 e54b454
* **deps:** update dependency tflint to v0.51.1 409c12e
* **deps:** update dependency trivy to v0.51.0 392bfd0
* **deps:** update dependency trivy to v0.51.1 feef5f3
* **deps:** update dependency trivy to v0.51.2 a9a0dfa
* **deps:** update dependency trivy to v0.51.4 a3fceb7
* **deps:** update dependency trivy to v0.52.0 7da53fb
* **deps:** update dependency trivy to v0.52.1 cedfc10
* **deps:** update dependency trivy to v0.52.2 caf77cd
* **deps:** update terraform claranet/storage-account/azurerm to ~> 7.12.0 5b21681

## 7.0.1 (2024-04-26)


### Bug Fixes

* **AzAPI:** provider pinned `< v1.13` to avoid breaking changes 0cd7114


### Continuous Integration

* **AZ-1391:** enable semantic-release [skip ci] 426edfb
* **AZ-1391:** update semantic-release config [skip ci] 790739a


### Miscellaneous Chores

* **deps:** add renovate.json 30144ac
* **deps:** enable automerge on renovate a3f8083
* **deps:** update dependency claranet/storage-account/azurerm to ~> 7.11.0 2b040ec
* **deps:** update dependency trivy to v0.50.2 a424176
* **deps:** update dependency trivy to v0.50.4 a1b3f0c
* **deps:** update renovate.json 43709cf
* **deps:** update terraform claranet/diagnostic-settings/azurerm to ~> 6.5.0 b8fe11b
* **deps:** update terraform claranet/storage-account/azurerm to ~> 7.10.0 a043c44
* **pre-commit:** update commitlint hook 0776305
* **release:** remove legacy `VERSION` file 3582b65

# v7.0.0 - 2023-03-10

Added
  * AZ-935: First version
