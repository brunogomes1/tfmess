#!/bin/bash

# Assume a role before running the script
export AWS_PROFILE=your-profile-name

# Commands below assume terraform files are in same directory as the script but you can also pass the full path for the file
# /Users/brunogomes1/Documents/git/file/ops/iac/terraform/envs/cloudfront.tf

terraform_plan () {
    read -p "Choose the .tf file you would like to work on: " file

    if [ -e "${file}" ]; then
        echo "${file} found."
        MODULE=$(sed -n 's/module "\([^"]*\)".*/-target=module.\1 \\/gp' ${file})
        if [[ -z "$MODULE" ]]; then
          echo "Couldn't find terraform module in ${file}"
          exit 1
        fi

        if [[ ! -z "$MODULE" ]]; then

        echo "List of modules that were found in the file: "

        echo $MODULE | tr -d '\'

        read -p "Would you like to run Terraform Plan against all modules that were found? (Y/N) " answer

        case $answer in
            Y|y)
                MODULE2=$(echo ${MODULE} | tr -d '\')
                terraform plan $MODULE2
                ;;
            N|n)
                exit 1
                ;;
            *)
                echo >&2 "Input \""$answer"\" not recognized. Aborting."
                echo "Exiting..."
                exit 1
                ;;
        esac
        fi
    fi
}

terraform_apply () {
    read -p "Choose the .tf file you would like to work on: " file

    if [ -e "${file}" ]; then
        echo "${file} found."
        MODULE=$(sed -n 's/module "\([^"]*\)".*/-target=module.\1 \\/gp' ${file})
        if [[ -z "$MODULE" ]]; then
          echo "Couldn't find terraform module in ${file}"
          exit 1
        fi

        if [[ ! -z "$MODULE" ]]; then

        echo "List of modules that were found in the file: "

        echo $MODULE | tr -d '\'

        read -p "Would you like to run Terraform Apply against all modules that were found? (Y/N) " answer

        case $answer in
            Y|y)
                MODULE2=$(echo ${MODULE} | tr -d '\')
                terraform apply $MODULE2
                ;;
            N|n)
                exit 1
                ;;
            *)
                echo >&2 "Input \""$answer"\" not recognized. Aborting."
                echo "Exiting..."
                exit 1
                ;;
        esac
        fi
    fi
}

# Main execution starts here
if [ $# -eq 1 ]; then

    case ${1} in
        --tfplan)
            terraform_plan
            ;;
        --tfapply)
            terraform_apply
            ;;
        *)
            echo "${0}: Unknown argument \""${1}"\"" >&2
            ;;
    esac
else 
    echo >&2 "Invalid number of arguments passed."
fi