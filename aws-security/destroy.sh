#!/usr/bin/env bash

#
# this will destroy the atlantis infrastructure created by setup.sh
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
cd $DIR/$TF_SECURITYHUB_DIR
terraform init 
terraform plan -lock=false -destroy -out tf-plan-securityhub.tmp 
echo -n "Are you SURE you want to proceed with deleting Security Hub? (yes/no) "
read -r destroy
if [ "$destroy" = "yes" ]; then
    echo "Proceeding with destroy operation"
    terraform apply tf-plan-securityhub.tmp
else
    echo 'Exiting: unless you answer exactly "yes" this will not destroy anything.'
    exit 1
fi

cd $DIR/$TF_GUARDDUTY_DIR
terraform init 
terraform plan -lock=false -destroy -out tf-plan-guardduty.tmp 
echo -n "Are you SURE you want to proceed with deleting GuardDuty? (yes/no) "
read -r destroy
if [ "$destroy" = "yes" ]; then
    echo "Proceeding with destroy operation"
    terraform apply tf-plan-guardduty.tmp
else
    echo 'Exiting: unless you answer exactly "yes" this will not destroy anything.'
    exit 1
fi

cd $DIR/$TF_INSPECTOR_DIR
terraform init 
terraform plan -lock=false -destroy -out tf-plan-inspector.tmp 
echo -n "Are you SURE you want to proceed with deleting Inspector? (yes/no) "
read -r destroy
if [ "$destroy" = "yes" ]; then
    echo "Proceeding with destroy operation"
    terraform apply tf-plan-inspector.tmp
else
    echo 'Exiting: unless you answer exactly "yes" this will not destroy anything.'
    exit 1
fi

cd $DIR/$TF_MACIEASSOCIATION_DIR
terraform init 
terraform plan -lock=false -destroy -out tf-plan-macie.tmp 
echo -n "Are you SURE you want to proceed with deleting Macie Association? (yes/no) "
read -r destroy
if [ "$destroy" = "yes" ]; then
    echo "Proceeding with destroy operation"
    terraform apply tf-plan-macie.tmp
else
    echo 'Exiting: unless you answer exactly "yes" this will not destroy anything.'
    exit 1
fi
