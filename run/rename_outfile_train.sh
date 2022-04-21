#!/bin/bash
# source /home/t_yamamoto/workspace4/mmdetection3d/setup_venv/activate_python.sh

# This script is for TRAIN result.
cd /home/t_yamamoto/workspace4/run/trainout/cp_nus_3d/pillar

ls *20220416_13*.out | sed -e s/\.out// | awk '{print $1 ".out " $1 "_bos2sing30_with_emptygt.out"}' | xargs -n 2 mv