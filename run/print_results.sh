#!/bin/bash
source /home/t_yamamoto/workspace4/mmdetection3d/setup_venv/activate_python.sh
# cd /home/t_yamamoto/workspace4/mmdetection3d

# train
# python print_results.py training ./trainout/cp_nus_3d/pillar

# test
# python print_results.py testing ./testout/pp_nus_3d
python print_results.py testing ./testout/cp_nus_3d/pillar