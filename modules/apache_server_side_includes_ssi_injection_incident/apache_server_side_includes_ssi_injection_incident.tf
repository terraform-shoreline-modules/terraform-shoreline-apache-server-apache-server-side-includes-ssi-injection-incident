resource "shoreline_notebook" "apache_server_side_includes_ssi_injection_incident" {
  name       = "apache_server_side_includes_ssi_injection_incident"
  data       = file("${path.module}/data/apache_server_side_includes_ssi_injection_incident.json")
  depends_on = [shoreline_action.invoke_apache_status_and_port,shoreline_action.invoke_update_apache_conf]
}

resource "shoreline_file" "apache_status_and_port" {
  name             = "apache_status_and_port"
  input_file       = "${path.module}/data/apache_status_and_port.sh"
  md5              = filemd5("${path.module}/data/apache_status_and_port.sh")
  description      = "Check if the Apache server is running and listening on the expected port"
  destination_path = "/agent/scripts/apache_status_and_port.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "update_apache_conf" {
  name             = "update_apache_conf"
  input_file       = "${path.module}/data/update_apache_conf.sh"
  md5              = filemd5("${path.module}/data/update_apache_conf.sh")
  description      = "Update the Apache configuration file to disable the use of Server Side Includes (SSI) and only allow the use of certain safe directives."
  destination_path = "/agent/scripts/update_apache_conf.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_apache_status_and_port" {
  name        = "invoke_apache_status_and_port"
  description = "Check if the Apache server is running and listening on the expected port"
  command     = "`chmod +x /agent/scripts/apache_status_and_port.sh && /agent/scripts/apache_status_and_port.sh`"
  params      = ["APACHE_PORT"]
  file_deps   = ["apache_status_and_port"]
  enabled     = true
  depends_on  = [shoreline_file.apache_status_and_port]
}

resource "shoreline_action" "invoke_update_apache_conf" {
  name        = "invoke_update_apache_conf"
  description = "Update the Apache configuration file to disable the use of Server Side Includes (SSI) and only allow the use of certain safe directives."
  command     = "`chmod +x /agent/scripts/update_apache_conf.sh && /agent/scripts/update_apache_conf.sh`"
  params      = ["PATH_TO_APACHE_CONF_FILE"]
  file_deps   = ["update_apache_conf"]
  enabled     = true
  depends_on  = [shoreline_file.update_apache_conf]
}

