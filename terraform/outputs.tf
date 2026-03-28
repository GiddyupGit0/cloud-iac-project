output "webapp_url" {
  value = "https://${azurerm_app_service.webapp.default_site_hostname}"
}