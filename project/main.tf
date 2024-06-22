resource "selectel_vpc_project_v2" "project" {
  name = var.project_name

  quotas {
    resource_name = "compute_cores"
    resource_quotas {
      region = var.region
      zone   = var.zone
      value  = 8
    }
  }
  quotas {
    resource_name = "compute_ram"
    resource_quotas {
      region = var.region
      zone   = var.zone
      value  = 8096
    }
  }
  quotas {
    resource_name = "volume_gigabytes_universal"
    resource_quotas {
      region = var.region
      zone   = var.zone
      value  = 24
    }
  }
  quotas {
    resource_name = "volume_gigabytes_fast"
    resource_quotas {
      region = var.region
      zone   = var.zone
      value  = 8
    }
  }
}
