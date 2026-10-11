resource "google_beyondcorp_security_gateway" "beyondcorp_security_gateways" {
  for_each = var.beyondcorp_security_gateways

  security_gateway_id = each.value.security_gateway_id
  deletion_policy     = each.value.deletion_policy
  display_name        = each.value.display_name
  location            = each.value.location
  project             = each.value.project

  dynamic "hubs" {
    for_each = each.value.hubs != null ? each.value.hubs : []
    content {
      dynamic "internet_gateway" {
        for_each = hubs.value.internet_gateway != null ? [hubs.value.internet_gateway] : []
        content {
        }
      }
      region = hubs.value.region
    }
  }

  dynamic "logging" {
    for_each = each.value.logging != null ? [each.value.logging] : []
    content {
    }
  }

  dynamic "proxy_protocol_config" {
    for_each = each.value.proxy_protocol_config != null ? [each.value.proxy_protocol_config] : []
    content {
      allowed_client_headers = proxy_protocol_config.value.allowed_client_headers
      client_ip              = proxy_protocol_config.value.client_ip
      dynamic "contextual_headers" {
        for_each = proxy_protocol_config.value.contextual_headers != null ? [proxy_protocol_config.value.contextual_headers] : []
        content {
          dynamic "device_info" {
            for_each = contextual_headers.value.device_info != null ? [contextual_headers.value.device_info] : []
            content {
              output_type = device_info.value.output_type
            }
          }
          dynamic "group_info" {
            for_each = contextual_headers.value.group_info != null ? [contextual_headers.value.group_info] : []
            content {
              output_type = group_info.value.output_type
            }
          }
          output_type = contextual_headers.value.output_type
          dynamic "user_info" {
            for_each = contextual_headers.value.user_info != null ? [contextual_headers.value.user_info] : []
            content {
              output_type = user_info.value.output_type
            }
          }
        }
      }
      gateway_identity = proxy_protocol_config.value.gateway_identity
      metadata_headers = proxy_protocol_config.value.metadata_headers
    }
  }

  dynamic "service_discovery" {
    for_each = each.value.service_discovery != null ? [each.value.service_discovery] : []
    content {
      dynamic "api_gateway" {
        for_each = service_discovery.value.api_gateway != null ? [service_discovery.value.api_gateway] : []
        content {
          dynamic "resource_override" {
            for_each = api_gateway.value.resource_override != null ? [api_gateway.value.resource_override] : []
            content {
              path = resource_override.value.path
            }
          }
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

