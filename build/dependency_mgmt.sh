#!/bin/bash
#
#  build dependencies for registry apps
#  helm and registry apps don't integrate very well
#  so some jiggery pokery is required


set -o errexit
set -o nounset
set -o pipefail

[[ -z "$CHART_NAME"   ]] && \
  {
    echo >&2 "Var '\$CHART_NAME' is empty. Cannot continue."
    exit 1
  }

[[ ! -d "${CHART_NAME}" ]] && \
  {
    echo >&2 "Directory for chart '\$CHART_NAME' does not exist."
    exit 1
  }

#  helm registry only works on the current directory, go there
cd "$(pwd)/${CHART_NAME}"

#  overwrite requirements.yaml, this is the fudge
helm registry dep --overwrite

#  local helm init/serve
helm init --client-only
helm serve &
helm repo update

#  update the deps
helm dep build

#  stop the helm server
kill -9 $!
