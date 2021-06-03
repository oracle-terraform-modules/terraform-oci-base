variable "logdefinition" {
  type        = map(any)
  description = "(optional) describe your variable"
}

variable "log_is_enabled" {
  type        = string
  description = "(optional) describe your variable"
}

variable "log_retention_duration" {
  type        = string
  description = "(optional) describe your variable"
}

variable "compartment_ocid" {
  type        = string
  description = "(optional) describe your variable"
}


variable "loggroup" {
  description = "Log group"

}
