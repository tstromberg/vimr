#!/bin/bash
set -Eeuo pipefail

main () {
  pushd "$(dirname "${BASH_SOURCE[0]}")/.." > /dev/null
    local x86_64_deployment_target
    x86_64_deployment_target=$(cat ./resources/x86_64_deployment_target.txt)
    readonly x86_64_deployment_target

    local arm64_deployment_target
    arm64_deployment_target=$(cat ./resources/arm64_deployment_target.txt)
    readonly arm64_deployment_target

    local -r pcre_version="8.45"
    local -r xz_version="5.3.2alpha"
    local -r ag_version="2.2.0"

    pushd ./bin >/dev/null
      python third_party/build.py \
          --arm64-deployment-target="${arm64_deployment_target}" \
          --x86_64-deployment-target="${x86_64_deployment_target}" \
          --xz-version "${xz_version}" \
          --pcre-version "${pcre_version}" \
          --ag-version "${ag_version}"
    popd >/dev/null
  popd >/dev/null
}

main
