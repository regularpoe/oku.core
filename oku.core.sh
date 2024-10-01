#!/bin/bash

check_jq_installed() {
  if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Attempting to install jq..."

    if command -v apt &> /dev/null; then
      sudo apt update && sudo apt install -y jq
    elif command -v yum &> /dev/null; then
      sudo yum install -y jq
    elif command -v dnf &> /dev/null; then
      sudo dnf install -y jq
    elif command -v pacman &> /dev/null; then
      sudo pacman -S --noconfirm jq
    else
      echo "Could not detect package manager. Please install jq manually."
      exit 1
    fi

    if ! command -v jq &> /dev/null; then
      echo "jq installation failed. Please install it manually."
      exit 1
    fi
  fi
}

check_jq_installed

line_number=$1
template_file=$2
snippet_name=$3
file_path=$4

template_path="$(dirname $0)/$template_file.json"
if [[ ! -f $template_path ]]; then
    echo "Template $template_file.json not found"
    exit 1
fi

snippet=$(jq -r ".\"$snippet_name\"" "$template_path")

if [[ $snippet == "null" ]]; then
  echo "Snippet $snippet_name not found in $template_file.json!"
  exit 1
fi

sed -i "${line_number}i $snippet" "$file_path"

echo "Snippet inserted!"

