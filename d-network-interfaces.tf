data "azapi_resource" "nic_interfaces" {
  for_each  = local.vms_nics
  name      = reverse(split("/", each.value))[0]
  parent_id = join("/", slice(split("/", each.value), 0, 5))
  type      = "Microsoft.Network/networkInterfaces@2022-07-01"

  response_export_values = ["properties.ipConfigurations"]
}
