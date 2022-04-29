#!/bin/bash
echo "$(tput setaf 1)] RSCRIPT: Started Manager$(tput setaf 7)"
echo "$(tput setaf 1)] rscript: select an option:$(tput setaf 7)"

select yn in "Yes" "No"; do
    case $yn in
        Yes ) bash testapp.sh; break;;
        Cancel ) bash testcn.sh; break;;
    esac
done
