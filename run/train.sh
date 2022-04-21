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

# sleep処理
#echo sleep11h
#DATETIME=`date +%Y%m%d_%H%M%S`
#echo $DATETIME
#sleep 11h
#echo 11hpassed
#DATETIME=`date +%Y%m%d_%H%M%S`
#echo $DATETIME

# 作成したPythonスクリプトを実行
# 失敗
# python tools/train.py configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py --work-dir ./work_dirs2
# ./tools/dist_train.sh configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py 1 --work-dir ./work_dirs3
# ./tools/dist_train.sh configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py 8 --resume-from ./work_dirs/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d/epoch_3.pth

# change location
# python ./tools/change_location.py singapore
python ./tools/change_location.py singapore_random_10
# python ./tools/change_location.py singapore_activelearning_20

# all使う時 configs/_base_/datasets/nus-3d.py line17,18のdataset_typeを変えること
# python ./tools/change_location.py all


# resume-from : 途中から再開
# load_from   : fine tuning


# 成功
# PointPillars
# ./tools/dist_train.sh configs/pointpillars/hv_pointpillars_secfpn_6x8_160e_kitti-3d-3class.py 8
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_train.sh "ubuntu -x nsx,huracan" pp_nus_3d configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py ./work_dirs_samplepergpu2
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_train.sh "ubuntu -x nsx,huracan" pp_nus_3d configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py ./singapore20_x5-2iter
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_train.sh "meti -x tesla" pp_nus_3d configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py ./singapore --resume-from ./singapore/epoch_9.pth

# CenterPoint (pillar)
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_train.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py ./cp_nus_3d/pillar/singapore

# CenterPoint (voxel)
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_train.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_01voxel_second_secfpn_circlenms_4x8_cyclic_20e_nus.py ./cp_nus_3d/voxel/singapore


# transfer
# PointPillars
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_train.sh "ubuntu -x nsx,huracan" pp_nus_3d configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py ./boston_to_singapore10_x5-1iter --resume-from ./boston_to_singapore10_x5-1iter/epoch_72.pth --cfg-options "load_from=/home/t_yamamoto/workspace4/mmdetection3d/boston/latest.pth"
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_train.sh "meti -x tesla" pp_nus_3d configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py ./pp_nus_3d/boston_to_singapore20_2 --cfg-options "load_from=/home/t_yamamoto/workspace4/mmdetection3d/pp_nus_3d/boston/latest.pth"

# CenterPoint (pillar)
GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_train.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py ./cp_nus_3d/pillar/boston_to_singapore10_with_emptygt --cfg-options "load_from=/home/t_yamamoto/workspace4/mmdetection3d/cp_nus_3d/pillar/boston/latest.pth"

# CenterPoint (voxel)


# transfer (active learning)
# PointPillars
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_train.sh "meti -x tesla" pp_nus_3d configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py ./pp_nus_3d/al_test --cfg-options "load_from=/home/t_yamamoto/workspace4/mmdetection3d/pp_nus_3d/boston/latest.pth"

# CenterPoint (pillar)
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_train.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py ./cp_nus_3d/pillar/boston_to_singapore20_3 --cfg-options "load_from=/home/t_yamamoto/workspace4/mmdetection3d/cp_nus_3d/pillar/boston/latest.pth"

# CenterPoint (voxel)


# reverse
# python ./tools/change_location.py singapore


# epochの変更は以下の箇所を変えること
# configs/__base__/datasets/nus-3d.py line156
# configs/__base__/schedules/schedule_2x.py line15
