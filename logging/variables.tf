variable "compartment_ocid" {
  type        = string
  description = "compartment OCID"
}


variable "log_group_freeform_tags" {
  description = "Freeform Tags"
  default = {
    "Environment" = "Dev"
  }
}

variable "servicelogdefinition" {
  type        = map(any)
  description = "Service Log Definition"
  default     = {}
  validation {
    condition = (
      try(lookup(element(values(var.servicelogdefinition), 0), "resource", null), {}) != null &&
      try(lookup(element(values(var.servicelogdefinition), 0), "loggroup", null), {}) != null &&
    try(lookup(element(values(var.servicelogdefinition), 0), "service", null), {}) != null)
    error_message = "All the keys like loggroup,service and resource are needed.Refer terraform.tfvars.example for reference."
  }


}

variable "log_is_enabled" {
  type        = bool
  description = "log enabled"
  default     = false
}

variable "log_retention_duration" {
  type        = number
  default     = 30
  description = "Log retention duration"
}

variable "tenancy_ocid" {
  type        = string
  description = "Tenancy OCID"
}

