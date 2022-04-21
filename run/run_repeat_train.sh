#!/bin/bash
source /home/t_yamamoto/workspace4/mmdetection3d/setup_venv/activate_python.sh
cd /home/t_yamamoto/workspace4/mmdetection3d
export OMP_NUM_THREADS=5
export MASTER_PORT=29501

# --
# meti divo用
export NCCL_SOCKET_IFNAME=eth0
export NCCL_IB_DISABLE=1
export NCCL_P2P_DISABLE=1
export NCCL_DEBUG=INFO
export NCCL_SOCKET_IFNAME="^lo,docker,virbr,vmnet,vboxnet"
# --

# xargs内のRATIOを変更すること
RATIO=20
IDX_FROM=1
IDX_TO=5

LOCATION="singapore_random_${RATIO}"
python ./tools/change_location.py ${LOCATION}

# echo ratio_${IDX_FROM}
# TRAIN_SCRIPT
# seq $IDX_FROM $IDX_TO | xargs -P 5 -i sh -c 'RATIO=40; sleep {}; port=`expr {} + 25000`; export MASTER_PORT=${port}; DIR_NAME=boston_to_singapore${RATIO}_{}; GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_train.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py ./cp_nus_3d/pillar/${DIR_NAME} --cfg-options "load_from=/home/t_yamamoto/workspace4/mmdetection3d/cp_nus_3d/pillar/boston/latest.pth"'
seq $IDX_FROM $IDX_TO | xargs -P 5 -i sh -c 'RATIO=20; sleep {}; port=`expr {} + 25010`; export MASTER_PORT=${port}; DIR_NAME=boston_to_singapore${RATIO}_{}_with_emptygt; GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_train.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py ./cp_nus_3d/pillar/${DIR_NAME} --cfg-options "load_from=/home/t_yamamoto/workspace4/mmdetection3d/cp_nus_3d/pillar/boston/latest.pth"'
