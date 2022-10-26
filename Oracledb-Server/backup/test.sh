#!/bin/bash -e
# check running asm_pmon
#check running ora_pmon
# sleep for 30 seconds
# check again
# if exists break
while true; do
    case "$1" in
        -v|--verbose)
            echo "[] DEBUG = ON"
            VERBOSE=true;
            shift
            ;;
        -n|--noop)
            echo "[] NOOP = ON"
            NOOP=true;
            shift
            ;;
        --params_file)
            echo "[] PARAMS_FILE = $2"
            PARAMS_FILE="$2";
            shift 2
            ;;
        --primary)
            echo "[] HOST_TYPE = PRIMARY"
            HOST_TYPE='PRIMARY';
            shift
            ;;
        --standby)
            echo "[] HOST_TYPE = STANDBY"
            HOST_TYPE='STANDBY';
            shift
            ;;
        --)
            break
            ;;
        *)
            break
            ;;
    esac
done

#while true; do

count=0
#MAXSTEP=${local.MAXSTEP}
MAXSTEP=2
while [ $count -lt $MAXSTEP ] do
if [[ $(ps -ef | grep pmon | grep -v grep | wc -l) != 0 ]]; then
        echo "PMON Process Found!"
else
        echo "PMON Process Not Found!"
fi
sleep 10
count=$[$count+1]
done

