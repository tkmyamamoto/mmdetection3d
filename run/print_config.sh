#!/bin/bash
source /home/t_yamamoto/workspace4/mmdetection3d/setup_venv/activate_python.sh
cd /home/t_yamamoto/workspace4/mmdetection3d
# 作成したPythonスクリプトを実行
# Learn about Configs
python tools/misc/print_config.py /PATH/TO/CONFIG
