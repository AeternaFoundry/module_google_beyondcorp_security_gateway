variable "beyondcorp_security_gateways" {
  description = <<EOT
Map of beyondcorp_security_gateways, attributes below
Required:
    - security_gateway_id
Optional:
    - deletion_policy
    - display_name
    - location
    - project
    - hubs (block):
        - internet_gateway (optional, block):
        - region (required)
    - logging (block):
    - proxy_protocol_config (block):
        - allowed_client_headers (optional)
        - client_ip (optional)
        - contextual_headers (optional, block):
            - device_info (optional, block):
                - output_type (optional)
            - group_info (optional, block):
                - output_type (optional)
            - output_type (optional)
            - user_info (optional, block):
                - output_type (optional)
        - gateway_identity (optional)
        - metadata_headers (optional)
    - service_discovery (block):
        - api_gateway (optional, block):
            - resource_override (optional, block):
                - path (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    security_gateway_id = string
    deletion_policy     = optional(string)
    display_name        = optional(string)
    location            = optional(string)
    project             = optional(string)
    hubs = optional(list(object({
      internet_gateway = optional(object({
      }))
      region = string
    })))
    logging = optional(object({
    }))
    proxy_protocol_config = optional(object({
      allowed_client_headers = optional(list(string))
      client_ip              = optional(bool)
      contextual_headers = optional(object({
        device_info = optional(object({
          output_type = optional(string)
        }))
        group_info = optional(object({
          output_type = optional(string)
        }))
        output_type = optional(string)
        user_info = optional(object({
          output_type = optional(string)
        }))
      }))
      gateway_identity = optional(string)
      metadata_headers = optional(map(string))
    }))
    service_discovery = optional(object({
      api_gateway = optional(object({
        resource_override = optional(object({
          path = optional(string)
        }))
      }))
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  # Note: 6 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

