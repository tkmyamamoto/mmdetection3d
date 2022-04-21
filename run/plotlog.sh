#!/bin/bash
source /home/t_yamamoto/workspace4/mmdetection3d/setup_venv/activate_python.sh
cd /home/t_yamamoto/workspace4/mmdetection3d
# 作成したPythonスクリプトを実行

# python tools/analysis_tools/my_analyze_logs.py plot_curve pp_nus_3d/boston_to_singapore10_x5-1iter_step/20211023_154203.log.json --keys loss --legend loss --val --epoch 120 --out ../run/loss/pp_nus_3d/boston_to_singapore10_x5-1iter_step.pdf

python tools/analysis_tools/my_analyze_logs.py plot_curve cp_nus_3d/pillar/boston_failed/20211018_123420.log.json --keys loss --legend loss --val --epoch 20 --ylim 4 15 --out ../run/loss/cp_nus_3d/pillar/failed_boston.pdf
