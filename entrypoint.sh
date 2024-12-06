#!/bin/bash

# Update package list and install dependencies
apt-get update
apt-get install -y snmpd gettext-base hostname

# Use the hostname as the service name
hostname=$(hostname)
export SERVICE_NAME="pfsense-${hostname::8}"

# Generate the final SNMPD configuration from the template
envsubst < /etc/snmp/snmpd.conf.template > /etc/snmp/snmpd.conf

# Start SNMPD in the foreground
exec snmpd -f -c /etc/snmp/snmpd.conf
