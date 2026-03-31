resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                   = "SSH"
    priority               = 1001
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "22"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "HTTPS"
    priority               = 1002
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "443"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "RDP"
    priority               = 1003
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "3389"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "DNS"
    priority               = 1004
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Udp"
    source_port_range      = "*"
    destination_port_range = "53"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "NTP"
    priority               = 1005
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Udp"
    source_port_range      = "*"
    destination_port_range = "123"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "LDAP"
    priority               = 1006
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "389"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "LDAPS"
    priority               = 1007
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "636"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "RDP-Proxy"
    priority               = 1008
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "3389"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "HTTP-Proxy"
    priority               = 1009
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "80"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "HTTPS-Proxy"
    priority               = 1010
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "443"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "SQL-Proxy"
    priority               = 1011
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "1433"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "MySQL-Proxy"
    priority               = 1012
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "3306"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "PostgreSQL-Proxy"
    priority               = 1013
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5432"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Oracle-Proxy"
    priority               = 1014
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "1521"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "MongoDB-Proxy"
    priority               = 1015
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "27017"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Redis-Proxy"
    priority               = 1016
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "6379"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Memcached-Proxy"
    priority               = 1017
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "11211"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Riak-Proxy"
    priority               = 1018
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "8087-8094"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Couchbase-Proxy"
    priority               = 1019
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "8091-8096"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Elasticsearch-Proxy"
    priority               = 1020
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "9200-9300"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Kibana-Proxy"
    priority               = 1021
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5601"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1022
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Filebeat-Proxy"
    priority               = 1023
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Metricbeat-Proxy"
    priority               = 1024
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Packetbeat-Proxy"
    priority               = 1025
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Winlogbeat-Proxy"
    priority               = 1026
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Functionbeat-Proxy"
    priority               = 1027
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Auditbeat-Proxy"
    priority               = 1028
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Heartbeat-Proxy"
    priority               = 1029
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Journalbeat-Proxy"
    priority               = 1030
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Fluentd-Proxy"
    priority               = 1031
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Grok-Proxy"
    priority               = 1032
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Splunk-Proxy"
    priority               = 1033
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1034
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1035
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1036
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1037
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1038
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1039
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1040
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1041
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1042
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1043
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1044
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1045
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1046
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1047
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1048
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1049
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1050
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1051
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1052
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1053
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1054
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1055
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1056
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1057
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1058
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1059
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1060
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1061
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1062
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1063
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1064
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1065
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1066
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1067
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1068
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1069
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1070
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1071
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1072
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1073
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1074
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1075
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1076
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1077
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1078
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1079
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1080
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1081
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1082
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1083
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1084
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1085
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1086
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1087
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1088
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1089
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1090
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1091
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1092
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1093
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1094
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1095
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1096
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1097
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1098
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1099
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1100
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1101
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1102
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1103
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1104
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1105
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1106
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1107
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1108
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1109
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1110
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1111
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1112
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1113
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1114
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1115
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1116
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1117
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1118
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1119
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1120
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1121
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1122
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1123
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1124
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1125
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1126
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1127
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1128
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1129
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1130
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1131
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1132
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1133
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1134
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1135
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1136
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1137
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1138
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1139
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1140
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1141
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1142
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1143
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1144
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1145
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1146
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1147
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1148
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1149
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1150
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1151
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1152
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1153
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1154
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1155
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1156
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1157
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1158
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1159
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1160
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1161
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1162
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1163
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1164
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1165
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1166
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1167
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1168
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1169
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1170
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1171
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1172
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1173
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1174
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1175
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1176
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1177
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1178
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1179
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1180
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1181
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1182
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1183
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1184
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1185
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1186
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1187
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1188
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1189
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1190
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
    source_address_prefix = "Internet"
  }

  security_rule {
    name                   = "Logstash-Proxy"
    priority               = 1191
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "5044"
