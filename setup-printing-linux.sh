#!/bin/bash
set -euo pipefail

# Prequisities:
#  - running bonjour/zeroconf daemon (e.g. avahi)
#  - cups

lpadmin -p ory-office-muc-front -v ipp://Brother%20MFC-L6900DW%20series._ipp._tcp.local/ -E -m driverless:ipp://Brother%20MFC-L6900DW%20series._ipp._tcp.local/
