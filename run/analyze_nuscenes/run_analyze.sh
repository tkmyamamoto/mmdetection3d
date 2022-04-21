#!/bin/bash
source /home/t_yamamoto/workspace4/mmdetection3d/setup_venv/activate_python.sh
# cd /home/t_yamamoto/workspace4/mmdetection3d
cd /home/t_yamamoto/workspace4/run/analyze_nuscenes

python ./analyze.py
# sbatch --mail-type=END --mail-user=yamamoto.takumi@g.sp.m.is.nagoya-u.ac.jp ./run_analyze.sh
