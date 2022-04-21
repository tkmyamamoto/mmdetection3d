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

# 作成したPythonスクリプトを実行
# 失敗
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "ubuntu -x nsx,huracan" pp_nus_3d configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py work_dirs2/latest.pth --eval mAP --eval-options 'show=True' 'out_dir=../run/show_results'
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "ubuntu -x nsx,huracan" pp_nus_3d configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py work_dirs2/latest.pth --show --show-dir ../run/show_results
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "ubuntu -w huracan" pp_nus_3d configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py work_dirs2/latest.pth --show-dir ../run/show_results
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "ubuntu -w nsx" pp_nus_3d configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py work_dirs2/latest.pth --eval mAP --eval-options 'show=True' 'out_dir=../run/show_results2'

#echo sleep3h
#DATETIME=`date +%Y%m%d_%H%M%S`
#echo $DATETIME
#sleep 3h
#echo 3hpassed
#DATETIME=`date +%Y%m%d_%H%M%S`
#echo $DATETIME

python ./tools/change_location.py singapore
# python ./tools/change_location.py all

# 成功
# PointPillars
# all使う時 configs/_base_/datasets/nus-3d.py line17,18のdataset_typeを変えること

# ./tools/dist_test.sh configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py work_dirs2/latest.pth 4 --out work_dirs2/results.pkl --eval mAP
# ./tools/dist_test.sh configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py work_dirs2/latest.pth 1 --eval mAP

# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "ubuntu -x nsx,huracan" pp_nus_3d configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py work_dirs2/latest.pth --out ../run/pkl/results_mixtrain_bostontest.pkl --eval mAP
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" pp_nus_3d configs/pointpillars/hv_pointpillars_secfpn_sbn-all_4x8_2x_nus-3d.py pp_nus_3d/boston_to_singapore10_freeze_encoder/latest.pth --out ../run/pkl/results_bos2sing10train_freezeencoder_singtest.pkl --eval mAP

# CenterPoint (pillar)
# all使う時 configs/_base_/datasets/nus-3d.py line17,18と
# centerpoint_02pillar_second_secfpn_4x8_cyclic_20e_nus.py line34のdataset_typeを変えること
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py cp_nus_3d/pillar/boston/latest.pth --out ../run/pkl/cp_nus_3d/pillar/results_active.pkl --eval mAP

# active learning
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py cp_nus_3d/pillar/boston_to_singapore50_active/latest.pth --out ../run/pkl/cp_nus_3d/pillar/results_bos2sing50train_active_singtest.pkl --eval mAP
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py cp_nus_3d/pillar/boston_to_singapore30_active/latest.pth --out ../run/pkl/cp_nus_3d/pillar/results_bos2sing30train_active_singtest.pkl --eval mAP
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py cp_nus_3d/pillar/boston_to_singapore20_active/latest.pth --out ../run/pkl/cp_nus_3d/pillar/results_bos2sing20train_active_singtest.pkl --eval mAP
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py cp_nus_3d/pillar/boston_to_singapore50_2/latest.pth --out ../run/pkl/cp_nus_3d/pillar/results_bos2sing50train_2_singtest.pkl --eval mAP
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py cp_nus_3d/pillar/boston_to_singapore30_2/latest.pth --out ../run/pkl/cp_nus_3d/pillar/results_bos2sing30train_2_singtest.pkl --eval mAP
# GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py cp_nus_3d/pillar/boston_to_singapore20_2/latest.pth --out ../run/pkl/cp_nus_3d/pillar/results_bos2sing20train_2_singtest.pkl --eval mAP
GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py cp_nus_3d/pillar/boston_to_singapore10_with_emptygt/latest.pth --out ../run/pkl/cp_nus_3d/pillar/results_bos2sing10withemptygttrain_singtest.pkl --eval mAP
GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py cp_nus_3d/pillar/boston_to_singapore5_2_with_emptygt/latest.pth --out ../run/pkl/cp_nus_3d/pillar/results_bos2sing10withemptygttrain_2_singtest.pkl --eval mAP
GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py cp_nus_3d/pillar/boston_to_singapore5_3_with_emptygt/latest.pth --out ../run/pkl/cp_nus_3d/pillar/results_bos2sing10withemptygttrain_3_singtest.pkl --eval mAP
GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py cp_nus_3d/pillar/boston_to_singapore5_4_with_emptygt/latest.pth --out ../run/pkl/cp_nus_3d/pillar/results_bos2sing10withemptygttrain_4_singtest.pkl --eval mAP
GPUS=1 GPUS_PER_NODE=1 ./tools/slurm_test.sh "meti -x tesla" cp_nus_3d configs/centerpoint/centerpoint_02pillar_second_secfpn_circlenms_4x8_cyclic_20e_nus.py cp_nus_3d/pillar/boston_to_singapore5_5_with_emptygt/latest.pth --out ../run/pkl/cp_nus_3d/pillar/results_bos2sing10withemptygttrain_5_singtest.pkl --eval mAP

# CenterPoint (voxel)
