#!/bin/bash
# source /home/t_yamamoto/workspace4/mmdetection3d/setup_venv/activate_python.sh

# This script is for TEST result.
cd /home/t_yamamoto/workspace4/run/testout/cp_nus_3d/pillar

ls *20220417_17*.out | sed -e s/\.out// | awk '{print $1 ".out " $1 "_bos2sing30withemptygttrain_singtest.out"}' | xargs -n 2 mv
# echo "Renamed `ls -1 *20220417_17*.out　| wc -l` files!"