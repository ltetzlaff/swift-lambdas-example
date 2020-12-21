# https://github.com/swift-server/swift-aws-lambda-runtime/blob/main/Examples/LambdaFunctions/scripts/config.sh
DIR="$(cd "$(dirname "$0")" && pwd)"
executables=( $(swift package dump-package | sed -e 's|: null|: ""|g' | jq '.products[] | (select(.type.executable)) | .name' | sed -e 's|"||g') )

if [[ ${#executables[@]} = 0 ]]; then
    echo "no executables found"
    exit 1
elif [[ ${#executables[@]} = 1 ]]; then
    executable=${executables[0]}
elif [[ ${#executables[@]} > 1 ]]; then
    echo "multiple executables found:"
    for executable in ${executables[@]}; do
      echo "  * $executable"
    done
    echo ""
    read -p "select which executables to deploy: " executable
fi
