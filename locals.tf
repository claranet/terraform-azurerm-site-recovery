locals {
  vms_nics = toset(flatten([
    for vm in keys(var.replicated_vms) : [
      for nic in var.replicated_vms[vm].network_interfaces : nic.network_interface_id
    ]
  ]))
  src_subnets = flatten([
    for nic in keys(data.azapi_resource.nic_interfaces) : [
      for ipconfig in data.azapi_resource.nic_interfaces[nic].output.properties.ipConfigurations : ipconfig.properties.subnet.id
    ]
  ])
}
