  
#!/usr/bin/env bash

#
# this script is used for creating bootstraping the project security hub
#

# Set bash unofficial strict mode http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

# Set DEBUG to true for enhanced debugging: run prefixed with "DEBUG=true"
${DEBUG:-false} && set -vx
# Credit to https://stackoverflow.com/a/17805088
# and http://wiki.bash-hackers.org/scripting/debuggingtips
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
# Credit to http://stackoverflow.com/a/246128/424301
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TF_SECURITYHUB_DIR="cards-security/securityhub"
TF_GUARDDUTY_DIR="cards-security/guardduty"
TF_INSPECTOR_DIR="cards-security/inspector"
TF_MACIEASSOCIATION_DIR="cards-security/macieassociation"

rm -rf "$DIR/.terraform"

echo "Proceeding with Securityhub creation"
cd $DIR/$TF_SECURITYHUB_DIR
terraform init
terraform plan  
terraform apply -auto-approve

echo "Proceeding with GuardDuty creation"
cd $DIR/$TF_GUARDDUTY_DIR
terraform init
terraform plan  
terraform apply -auto-approve

echo "Proceeding with Inspector creation"
cd $DIR/$TF_INSPECTOR_DIR
terraform init
terraform plan  
terraform apply -auto-approve

echo "Proceeding with MacieAssociation creation"
cd $DIR/$TF_MACIEASSOCIATION_DIR
terraform init
terraform plan  
terraform apply -auto-approve