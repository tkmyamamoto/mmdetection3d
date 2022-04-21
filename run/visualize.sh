#!/bin/bash
source /home/t_yamamoto/workspace4/mmdetection3d/setup_venv/activate_python.sh
cd /home/t_yamamoto/workspace4/mmdetection3d
# 作成したPythonスクリプトを実行
# datasetを見る
# python tools/misc/browse_dataset.py configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py --task det --output-dir ./work_dirs2

# resultを見る（VNCで使うこと）
python tools/misc/visualize_results.py configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py --result work_dirs2/results.pkl --show-dir work_dirs2/visualize_results
