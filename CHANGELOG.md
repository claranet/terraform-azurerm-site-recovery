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
