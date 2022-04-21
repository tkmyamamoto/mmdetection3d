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
python ./tools/change_location.py singapore

# echo ratio_${IDX_FROM}
# TEST_SCRIPT
# seq $IDX_FROM $IDX_TO | xargs -P 5 -i sh -c 'RATIO=30; sleep {}; port=`expr {} + 25000`; export MASTER_PORT=${port}; DIR_NAME=boston_to_singapore${RATIO}_{}; PKL_NAME=results_bos2sing${RATIO}train_{}_singtest.pkl; GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py cp_nus_3d/pillar/${DIR_NAME}/latest.pth --out ../run/pkl/cp_nus_3d/pillar/${PKL_NAME} --eval mAP'

# with_empty_gt
seq $IDX_FROM $IDX_TO | xargs -P 5 -i sh -c 'RATIO=20; sleep {}; port=`expr {} + 25000`; export MASTER_PORT=${port}; DIR_NAME=boston_to_singapore${RATIO}_{}_with_emptygt; PKL_NAME=results_bos2sing${RATIO}withemptygttrain_{}_singtest.pkl; GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py cp_nus_3d/pillar/${DIR_NAME}/latest.pth --out ../run/pkl/cp_nus_3d/pillar/${PKL_NAME} --eval mAP'
