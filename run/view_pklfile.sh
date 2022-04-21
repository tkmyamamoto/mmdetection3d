#!/bin/bash
source /home/t_yamamoto/workspace4/mmdetection3d/setup_venv/activate_python.sh
# cd /home/t_yamamoto/workspace4/run/pkl/cp_nus_3d/pillar
# python -m pickle results_bos2sing10train_singtest.pkl > pkl_contents.out

cd /home/t_yamamoto/workspace4/run
python plot_segment.py ./pkl/cp_nus_3d/pillar/results_bos2sing10train_singtest.pkl