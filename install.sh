#!/bin/bash

venv=~/.venvs/venvdrfpipeline
env_name=dev

if [[ ! -e ${venv} ]]; then
    mkdir -p -m 755 ~/.venvs >> /dev/null 2>&1
    virtualenv -p python3 ${venv}
fi

if [[ ! -e ${venv}/bin/activate ]]; then
    echo ""
    echo "Failed to create virtualenv: virtualenv -p python3 ${venv}"
    echo ""
    exit 1
fi

if [[ "${USE_ENV}" != "" ]]; then
    env_name="${USE_ENV}"
fi

if [[ ! -e ./envs/${env_name}.env ]]; then
    echo ""
    echo "Failed to find env file: envs/${env_name}.env"
    echo ""
    exit 1
fi

echo "Activating and installing pips"
source ${venv}/bin/activate && pip install --upgrade -r ./requirements.txt
echo ""

./run-migrations.sh

echo ""
echo "Run ./start.sh to run"
echo ""
