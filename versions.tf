terraform {
  required_providers {
    oci = {
      source = "hashicorp/oci"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = ">= 0.13"
}
