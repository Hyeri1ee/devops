#!/bin/bash
if [ $# -eq 1 ]; then
  endpoint="$1"
else
  endpoint="http://${INSTANCE_IP}:3000/contacts"
fi

health_check() {
  local retries=5
  local interval=10
  local timeout=5
  local success=0

  for ((i=1; i<=retries; i++)); do
    if curl -s -o /dev/null --max-time "$timeout" -f "$endpoint"; then
      success=1
      break
    else
      sleep "$interval"
    fi
  done

  if [[ $success -ne 1 ]]; then
    exit 1
  fi
}

health_check

fullnames=()
emails=()
shortnames=()

contacts_response=$(curl -s "$endpoint")

echo "$contacts_response"

if [[ "$contacts_response" == "[]" ]] || [[ -z "$contacts_response" ]]; then
  echo "Database is empty. Adding data..."
else
  echo "Database is not empty. Exiting script."
  exit 0
fi

while IFS='' read -r line || [[ -n "$line" ]]; do
  if [[ "$line" =~ name\{\ *\"([^\"]+)\"\ *\} ]]; then
    fullnames+=("${BASH_REMATCH[1]}")
  elif [[ "$line" =~ email\{\ *\"([^\"]+)\"\ *\} ]]; then
    emails+=("${BASH_REMATCH[1]}")
  elif [[ "$line" =~ code\{\ *\"([^\"]+)\"\ *\} ]]; then
    shortnames+=("${BASH_REMATCH[1]}")
  fi
done < data.txt

# 배열이 비어 있는지 확인
if [ ${#fullnames[@]} -eq 0 ];then
  echo "fullnames array is empty"
else
  echo "fullnames array is not empty N: ${#fullnames[@]}"
fi

if [ ${#emails[@]} -eq 0 ];then
  echo "emails array is empty"
else
  echo "emails array is not empty N: ${#emails[@]}"
fi

if [ ${#shortnames[@]} -eq 0 ];then
  echo "shortnames array is empty"
else
  echo "shortnames array is not empty N: ${#shortnames[@]}"
fi

for i in "${!fullnames[@]}"; do
  data="{\"shortname\":\"${shortnames[$i]}\",\"fullname\":\"${fullnames[$i]}\",\"email\":\"${emails[$i]}\"}"
  echo "Posting data: $data"
  curl -X POST -H "Content-Type: application/json" -d "$data" "$endpoint"
done
