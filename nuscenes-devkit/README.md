<<<<<<< HEAD
# nuScenes devkit
Welcome to the devkit of the [nuScenes](https://www.nuscenes.org/nuscenes) and [nuImages](https://www.nuscenes.org/nuimages) datasets.
![](https://www.nuscenes.org/public/images/road.jpg)

## Overview
- [Changelog](#changelog)
- [Devkit setup](#devkit-setup)
- [nuImages](#nuimages)
  - [nuImages setup](#nuimages-setup) 
  - [Getting started with nuImages](#getting-started-with-nuimages)
- [nuScenes](#nuscenes)
  - [nuScenes setup](#nuscenes-setup)
  - [Panoptic nuScenes](#panoptic-nuscenes)
  - [nuScenes-lidarseg](#nuscenes-lidarseg)
  - [Prediction challenge](#prediction-challenge)
  - [CAN bus expansion](#can-bus-expansion)
  - [Map expansion](#map-expansion)
  - [Map versions](#map-versions)
  - [Getting started with nuScenes](#getting-started-with-nuscenes)
- [Known issues](#known-issues)
- [Citation](#citation)

## Changelog
- Sep. 20, 2021: Devkit v1.1.9: Refactor tracking eval code for custom datasets with different classes.
- Sep. 17, 2021: Devkit v1.1.8: Add PAT metric to Panoptic nuScenes.
- Aug. 23, 2021: Devkit v1.1.7: Add more panoptic tracking metrics to Panoptic nuScenes code.
- Jul. 29, 2021: Devkit v1.1.6: Panoptic nuScenes v1.0 code, NeurIPS challenge announcement.
- Apr. 5, 2021: Devkit v1.1.3: Bug fixes and pip requirements.
- Nov. 23, 2020: Devkit v1.1.2: Release map-expansion v1.3 with lidar basemap.
- Nov. 9, 2020: Devkit v1.1.1: Lidarseg evaluation code, NeurIPS challenge announcement.
- Aug. 31, 2020: Devkit v1.1.0: nuImages v1.0 and nuScenes-lidarseg v1.0 code release.
- Jul. 7, 2020: Devkit v1.0.9: Misc updates on map and prediction code.
- Apr. 30, 2020: nuImages v0.1 code release.
- Apr. 1, 2020: Devkit v1.0.8: Relax pip requirements and reorganize prediction code.
- Mar. 24, 2020: Devkit v1.0.7: nuScenes prediction challenge code released.
- Feb. 12, 2020: Devkit v1.0.6: CAN bus expansion released.
- Dec. 11, 2019: Devkit v1.0.5: Remove weight factor from AMOTA tracking metrics.
- Nov. 1, 2019: Tracking eval code released and detection eval code reorganized.
- Jul. 1, 2019: Map expansion released.
- Apr. 30, 2019: Devkit v1.0.1: loosen PIP requirements, refine detection challenge, export 2d annotation script. 
- Mar. 26, 2019: Full dataset, paper, & devkit v1.0.0 released. Support dropped for teaser data.
- Dec. 20, 2018: Initial evaluation code released. Devkit folders restructured, which breaks backward compatibility.
- Nov. 21, 2018: RADAR filtering and multi sweep aggregation.
- Oct. 4, 2018: Code to parse RADAR data released.
- Sep. 12, 2018: Devkit for teaser dataset released.

## Devkit setup
We use a common devkit for nuScenes and nuImages.
The devkit is tested for Python 3.6 and Python 3.7.
To install Python, please check [here](https://github.com/nutonomy/nuscenes-devkit/blob/master/docs/installation.md#install-python).

Our devkit is available and can be installed via [pip](https://pip.pypa.io/en/stable/installing/) :
```
pip install nuscenes-devkit
```
For an advanced installation, see [installation](https://github.com/nutonomy/nuscenes-devkit/blob/master/docs/installation.md) for detailed instructions.

## nuImages
nuImages is a stand-alone large-scale image dataset.
It uses the same sensor setup as the 3d nuScenes dataset.
The structure is similar to nuScenes and both use the same devkit, which make the installation process simple.

### nuImages setup
To download nuImages you need to go to the [Download page](https://www.nuscenes.org/download), 
create an account and agree to the nuScenes [Terms of Use](https://www.nuscenes.org/terms-of-use).
For the devkit to work you will need to download *at least the metadata and samples*, the *sweeps* are optional.
Please unpack the archives to the `/data/sets/nuimages` folder \*without\* overwriting folders that occur in multiple archives.
Eventually you should have the following folder structure:
```
/data/sets/nuimages
    samples	-	Sensor data for keyframes (annotated images).
    sweeps  -   Sensor data for intermediate frames (unannotated images).
    v1.0-*	-	JSON tables that include all the meta data and annotations. Each split (train, val, test, mini) is provided in a separate folder.
```
If you want to use another folder, specify the `dataroot` parameter of the NuImages class (see tutorial).

### Getting started with nuImages

Please follow these steps to make yourself familiar with the nuImages dataset:
- Get the [nuscenes-devkit code](https://github.com/nutonomy/nuscenes-devkit).
- Run the tutorial using:
```
jupyter notebook $HOME/nuscenes-devkit/python-sdk/tutorials/nuimages_tutorial.ipynb
```
- See the [database schema](https://github.com/nutonomy/nuscenes-devkit/blob/master/docs/schema_nuimages.md) and [annotator instructions](https://github.com/nutonomy/nuscenes-devkit/blob/master/docs/instructions_nuimages.md).

## nuScenes

### nuScenes setup
To download nuScenes you need to go to the [Download page](https://www.nuscenes.org/download), 
create an account and agree to the nuScenes [Terms of Use](https://www.nuscenes.org/terms-of-use).
After logging in you will see multiple archives. 
For the devkit to work you will need to download *all* archives.
Please unpack the archives to the `/data/sets/nuscenes` folder \*without\* overwriting folders that occur in multiple archives.
Eventually you should have the following folder structure:
```
/data/sets/nuscenes
    samples	-	Sensor data for keyframes.
    sweeps	-	Sensor data for intermediate frames.
    maps	-	Folder for all map files: rasterized .png images and vectorized .json files.
    v1.0-*	-	JSON tables that include all the meta data and annotations. Each split (trainval, test, mini) is provided in a separate folder.
```
If you want to use another folder, specify the `dataroot` parameter of the NuScenes class (see tutorial).

### Panoptic nuScenes
In August 2021 we published [Panoptic nuScenes](https://www.nuscenes.org/panoptic) which contains the panoptic labels
of the point clouds for the approximately 40,000 keyframes in nuScenes.
To install Panoptic nuScenes, please follow these steps:
- Download the dataset from the [Download page](https://www.nuscenes.org/download),
- Extract the `panoptic` and `v1.0-*` folders to your nuScenes root directory (e.g. `/data/sets/nuscenes/panoptic`, `/data/sets/nuscenes/v1.0-*`).
- Get the latest version of the nuscenes-devkit.
- Get started with the [tutorial](https://github.com/nutonomy/nuscenes-devkit/blob/master/python-sdk/tutorials/nuscenes_lidarseg_panoptic_tutorial.ipynb).

### nuScenes-lidarseg
In August 2020 we published [nuScenes-lidarseg](https://www.nuscenes.org/nuscenes#lidarseg) which contains the semantic labels of the point clouds for the approximately 40,000 keyframes in nuScenes.
To install nuScenes-lidarseg, please follow these steps:
- Download the dataset from the [Download page](https://www.nuscenes.org/download),
- Extract the `lidarseg` and `v1.0-*` folders to your nuScenes root directory (e.g. `/data/sets/nuscenes/lidarseg`, `/data/sets/nuscenes/v1.0-*`).
- Get the latest version of the nuscenes-devkit.
- If you already have a previous version of the devkit, update the pip requirements (see [details](https://github.com/nutonomy/nuscenes-devkit/blob/master/docs/installation.md)): `pip install -r setup/requirements.txt`
- Get started with the [tutorial](https://github.com/nutonomy/nuscenes-devkit/blob/master/python-sdk/tutorials/nuscenes_lidarseg_panoptic_tutorial.ipynb).

### Prediction challenge
In March 2020 we released code for the nuScenes prediction challenge.
To get started:
- Download the version 1.2 of the map expansion (see below).
- Download the trajectory sets for [CoverNet](https://arxiv.org/abs/1911.10298) from [here](https://www.nuscenes.org/public/nuscenes-prediction-challenge-trajectory-sets.zip).
- Go through the [prediction tutorial](https://github.com/nutonomy/nuscenes-devkit/blob/master/python-sdk/tutorials/prediction_tutorial.ipynb).
- For information on how submissions will be scored, visit the challenge [website](https://www.nuscenes.org/prediction).

### CAN bus expansion
In February 2020 we published the CAN bus expansion.
It contains low-level vehicle data about the vehicle route, IMU, pose, steering angle feedback, battery, brakes, gear position, signals, wheel speeds, throttle, torque, solar sensors, odometry and more.
To install this expansion, please follow these steps:
- Download the expansion from the [Download page](https://www.nuscenes.org/download),
- Extract the can_bus folder to your nuScenes root directory (e.g. `/data/sets/nuscenes/can_bus`).
- Get the latest version of the nuscenes-devkit.
- If you already have a previous version of the devkit, update the pip requirements (see [details](https://github.com/nutonomy/nuscenes-devkit/blob/master/docs/installation.md)): `pip install -r setup/requirements.txt`
- Get started with the [CAN bus readme](https://github.com/nutonomy/nuscenes-devkit/blob/master/python-sdk/nuscenes/can_bus/README.md) or [tutorial](https://github.com/nutonomy/nuscenes-devkit/blob/master/python-sdk/tutorials/can_bus_tutorial.ipynb).

### Map expansion
In July 2019 we published a map expansion with 11 semantic layers (crosswalk, sidewalk, traffic lights, stop lines, lanes, etc.).
To install this expansion, please follow these steps:
- Download the expansion from the [Download page](https://www.nuscenes.org/download),
- Extract the contents (folders `basemap`, `expansion` and `prediction`) to your nuScenes `maps` folder.
- Get the latest version of the nuscenes-devkit.
- If you already have a previous version of the devkit, update the pip requirements (see [details](https://github.com/nutonomy/nuscenes-devkit/blob/master/docs/installation.md)): `pip install -r setup/requirements.txt`
- Get started with the [map expansion tutorial](https://github.com/nutonomy/nuscenes-devkit/blob/master/python-sdk/tutorials/map_expansion_tutorial.ipynb).
For more information, see the [map versions](#map-versions) below.

### Map versions
Here we give a brief overview of the different map versions:
- **v1.3**: Add BitMap class that supports new lidar basemap and legacy semantic prior map. Remove [one broken lane](https://github.com/nutonomy/nuscenes-devkit/issues/493).
- **v1.2**: Expand devkit and maps to include arcline paths and lane connectivity for the prediction challenge.
- **v1.1**: Resolved issues with ego poses being off the drivable surface.
- **v1.0**: Initial map expansion release from July 2019. Supports 11 semantic layers.
- **nuScenes v1.0**: Came with a bitmap for the semantic prior. All code is contained in nuscenes.py.

### Getting started with nuScenes
Please follow these steps to make yourself familiar with the nuScenes dataset:
- Read the [dataset description](https://www.nuscenes.org/nuscenes#overview).
- [Explore](https://www.nuscenes.org/nuscenes#explore) the lidar viewer and videos.
- [Download](https://www.nuscenes.org/download) the dataset. 
- Get the [nuscenes-devkit code](https://github.com/nutonomy/nuscenes-devkit).
- Read the [online tutorial](https://www.nuscenes.org/nuscenes#tutorials) or run it yourself using:
```
jupyter notebook $HOME/nuscenes-devkit/python-sdk/tutorials/nuscenes_tutorial.ipynb
```
- Read the [nuScenes paper](https://www.nuscenes.org/publications) for a detailed analysis of the dataset.
- Run the [map expansion tutorial](https://github.com/nutonomy/nuscenes-devkit/blob/master/python-sdk/tutorials/map_expansion_tutorial.ipynb).
- Take a look at the [experimental scripts](https://github.com/nutonomy/nuscenes-devkit/tree/master/python-sdk/nuscenes/scripts).
- For instructions related to the object detection task (results format, classes and evaluation metrics), please refer to [this readme](https://github.com/nutonomy/nuscenes-devkit/blob/master/python-sdk/nuscenes/eval/detection/README.md).
- See the [database schema](https://github.com/nutonomy/nuscenes-devkit/blob/master/docs/schema_nuscenes.md) and [annotator instructions](https://github.com/nutonomy/nuscenes-devkit/blob/master/docs/instructions_nuscenes.md).
- See the [FAQs](https://github.com/nutonomy/nuscenes-devkit/blob/master/docs/faqs.md).

## Known issues
Great care has been taken to collate the nuScenes dataset and many users have praised the quality of the data and annotations.
However, some minor issues remain:

**Maps**:
- For *singapore-hollandvillage* and *singapore-queenstown* the traffic light 3d poses are all 0 (except for tz).
- For *boston-seaport*, the ego poses of 3 scenes (499, 515, 517) are slightly incorrect and 2 scenes (501, 502) are outside the annotated area. 
- For *singapore-onenorth*, the ego poses of about 10 scenes were off the drivable surface. This has been **resolved in map v1.1**.
- Some lanes are disconnected from the rest of the lanes. We chose to keep these as they still provide valuable information. 

**Annotations**:
- A small number of 3d bounding boxes is annotated despite the object being temporarily occluded. For this reason we make sure to **filter objects without lidar or radar points** in the nuScenes benchmarks. See [issue 366](https://github.com/nutonomy/nuscenes-devkit/issues/366).

## Citation
Please use the following citation when referencing [nuScenes or nuImages](https://arxiv.org/abs/1903.11027):
```
@article{nuscenes2019,
  title={nuScenes: A multimodal dataset for autonomous driving},
  author={Holger Caesar and Varun Bankiti and Alex H. Lang and Sourabh Vora and 
          Venice Erin Liong and Qiang Xu and Anush Krishnan and Yu Pan and 
          Giancarlo Baldan and Oscar Beijbom},
  journal={arXiv preprint arXiv:1903.11027},
  year={2019}
}
```

Please use the following citation when referencing
[Panoptic nuScenes or nuScenes-lidarseg](https://arxiv.org/abs/2109.03805):
```
@article{fong2021panoptic,
  title={Panoptic nuScenes: A Large-Scale Benchmark for LiDAR Panoptic Segmentation and Tracking},
  author={Fong, Whye Kit and Mohan, Rohit and Hurtado, Juana Valeria and Zhou, Lubing and Caesar, Holger and
          Beijbom, Oscar and Valada, Abhinav},
  journal={arXiv preprint arXiv:2109.03805},
  year={2021}
}
```

![](https://www.nuscenes.org/public/images/nuscenes-example.png)
=======
<div align="center">
  <img src="resources/mmdet3d-logo.png" width="600"/>
</div>

[![docs](https://img.shields.io/badge/docs-latest-blue)](https://mmdetection3d.readthedocs.io/en/latest/)
[![badge](https://github.com/open-mmlab/mmdetection3d/workflows/build/badge.svg)](https://github.com/open-mmlab/mmdetection3d/actions)
[![codecov](https://codecov.io/gh/open-mmlab/mmdetection3d/branch/master/graph/badge.svg)](https://codecov.io/gh/open-mmlab/mmdetection3d)
[![license](https://img.shields.io/github/license/open-mmlab/mmdetection3d.svg)](https://github.com/open-mmlab/mmdetection3d/blob/master/LICENSE)


**News**: We released the codebase v0.16.0.

In the recent [nuScenes 3D detection challenge](https://www.nuscenes.org/object-detection?externalData=all&mapData=all&modalities=Any) of the 5th AI Driving Olympics in NeurIPS 2020, we obtained the best PKL award and the second runner-up by multi-modality entry, and the best vision-only results.

Code and models for the best vision-only method, [FCOS3D](https://arxiv.org/abs/2104.10956), have been released. Please stay tuned for [MoCa](https://arxiv.org/abs/2012.12741).

Documentation: https://mmdetection3d.readthedocs.io/

## Introduction

English | [简体中文](README_zh-CN.md)

The master branch works with **PyTorch 1.3+**.

MMDetection3D is an open source object detection toolbox based on PyTorch, towards the next-generation platform for general 3D detection. It is
a part of the OpenMMLab project developed by [MMLab](http://mmlab.ie.cuhk.edu.hk/).

![demo image](resources/mmdet3d_outdoor_demo.gif)

### Major features

- **Support multi-modality/single-modality detectors out of box**

  It directly supports multi-modality/single-modality detectors including MVXNet, VoteNet, PointPillars, etc.

- **Support indoor/outdoor 3D detection out of box**

  It directly supports popular indoor and outdoor 3D detection datasets, including ScanNet, SUNRGB-D, Waymo, nuScenes, Lyft, and KITTI.
  For nuScenes dataset, we also support [nuImages dataset](https://github.com/open-mmlab/mmdetection3d/tree/master/configs/nuimages).

- **Natural integration with 2D detection**

  All the about **300+ models, methods of 40+ papers**, and modules supported in [MMDetection](https://github.com/open-mmlab/mmdetection/blob/master/docs/model_zoo.md) can be trained or used in this codebase.

- **High efficiency**

  It trains faster than other codebases. The main results are as below. Details can be found in [benchmark.md](./docs/benchmarks.md). We compare the number of samples trained per second (the higher, the better). The models that are not supported by other codebases are marked by `×`.

  | Methods | MMDetection3D | [OpenPCDet](https://github.com/open-mmlab/OpenPCDet) |[votenet](https://github.com/facebookresearch/votenet)| [Det3D](https://github.com/poodarchu/Det3D) |
  |:-------:|:-------------:|:---------:|:-----:|:-----:|
  | VoteNet | 358           | ×         |   77  | ×     |
  | PointPillars-car| 141           | ×         |   ×  | 140     |
  | PointPillars-3class| 107           |44     |   ×      | ×    |
  | SECOND| 40           |30     |   ×      | ×    |
  | Part-A2| 17           |14     |   ×      | ×    |

Like [MMDetection](https://github.com/open-mmlab/mmdetection) and [MMCV](https://github.com/open-mmlab/mmcv), MMDetection3D can also be used as a library to support different projects on top of it.

## License

This project is released under the [Apache 2.0 license](LICENSE).

## Changelog

v0.16.0 was released in 1/8/2021.
Please refer to [changelog.md](docs/changelog.md) for details and release history.

## Benchmark and model zoo

Supported methods and backbones are shown in the below table.
Results and models are available in the [model zoo](docs/model_zoo.md).

Support backbones:

- [x] PointNet (CVPR'2017)
- [x] PointNet++ (NeurIPS'2017)
- [x] RegNet (CVPR'2020)

Support methods

- [x] [SECOND (Sensor'2018)](configs/second/README.md)
- [x] [PointPillars (CVPR'2019)](configs/pointpillars/README.md)
- [x] [FreeAnchor (NeurIPS'2019)](configs/free_anchor/README.md)
- [x] [VoteNet (ICCV'2019)](configs/votenet/README.md)
- [x] [H3DNet (ECCV'2020)](configs/h3dnet/README.md)
- [x] [3DSSD (CVPR'2020)](configs/3dssd/README.md)
- [x] [Part-A2 (TPAMI'2020)](configs/parta2/README.md)
- [x] [MVXNet (ICRA'2019)](configs/mvxnet/README.md)
- [x] [CenterPoint (CVPR'2021)](configs/centerpoint/README.md)
- [x] [SSN (ECCV'2020)](configs/ssn/README.md)
- [x] [ImVoteNet (CVPR'2020)](configs/imvotenet/README.md)
- [x] [FCOS3D (Arxiv'2021)](configs/fcos3d/README.md)
- [x] [PointNet++ (NeurIPS'2017)](configs/pointnet2/README.md)
- [x] [Group-Free-3D (Arxiv'2021)](configs/groupfree3d/README.md)
- [x] [ImVoxelNet (Arxiv'2021)](configs/imvoxelnet/README.md)
- [x] [PAConv (CVPR'2021)](configs/paconv/README.md)

|                    | ResNet   | ResNeXt  | SENet    |PointNet++ | HRNet | RegNetX | Res2Net |
|--------------------|:--------:|:--------:|:--------:|:---------:|:-----:|:--------:|:-----:|
| SECOND             | ☐        | ☐        | ☐        | ✗         | ☐     | ✓        | ☐     |
| PointPillars       | ☐        | ☐        | ☐        | ✗         | ☐     | ✓        | ☐     |
| FreeAnchor         | ☐        | ☐        | ☐        | ✗         | ☐     | ✓        | ☐     |
| VoteNet            | ✗        | ✗        | ✗        | ✓         | ✗     | ✗        | ✗     |
| H3DNet            | ✗        | ✗        | ✗        | ✓         | ✗     | ✗        | ✗     |
| 3DSSD            | ✗        | ✗        | ✗        | ✓         | ✗     | ✗        | ✗     |
| Part-A2            | ☐        | ☐        | ☐        | ✗         | ☐     | ✓        | ☐     |
| MVXNet             | ☐        | ☐        | ☐        | ✗         | ☐     | ✓        | ☐     |
| CenterPoint        | ☐        | ☐        | ☐        | ✗         | ☐     | ✓        | ☐     |
| SSN                | ☐        | ☐        | ☐        | ✗         | ☐     | ✓        | ☐     |
| ImVoteNet            | ✗        | ✗        | ✗        | ✓         | ✗     | ✗        | ✗     |
| FCOS3D               | ✓        | ☐        | ☐        | ✗         | ☐     | ☐        | ☐     |
| PointNet++           | ✗        | ✗        | ✗        | ✓         | ✗     | ✗        | ✗     |
| Group-Free-3D        | ✗        | ✗        | ✗        | ✓         | ✗     | ✗        | ✗     |
| ImVoxelNet           | ✓         | ✗        | ✗        | ✗        | ✗     | ✗        | ✗     |
| PAConv               | ✗        | ✗        | ✗        | ✓         | ✗     | ✗        | ✗     |

Other features
- [x] [Dynamic Voxelization](configs/dynamic_voxelization/README.md)

**Note:** All the about **300+ models, methods of 40+ papers** in 2D detection supported by [MMDetection](https://github.com/open-mmlab/mmdetection/blob/master/docs/model_zoo.md) can be trained or used in this codebase.

## Installation

Please refer to [getting_started.md](docs/getting_started.md) for installation.

## Get Started

Please see [getting_started.md](docs/getting_started.md) for the basic usage of MMDetection3D. We provide guidance for quick run [with existing dataset](docs/1_exist_data_model.md) and [with customized dataset](docs/2_new_data_model.md) for beginners. There are also tutorials for [learning configuration systems](docs/tutorials/config.md), [adding new dataset](docs/tutorials/customize_dataset.md), [designing data pipeline](docs/tutorials/data_pipeline.md), [customizing models](docs/tutorials/customize_models.md), [customizing runtime settings](docs/tutorials/customize_runtime.md) and [Waymo dataset](docs/datasets/waymo_det.md).

Please refer to [FAQ](docs/faq.md) for frequently asked questions. When updating the version of MMDetection3D, please also check the [compatibility doc](docs/compatibility.md) to be aware of the BC-breaking updates introduced in each version.

## Citation

If you find this project useful in your research, please consider cite:

```latex
@misc{mmdet3d2020,
    title={{MMDetection3D: OpenMMLab} next-generation platform for general {3D} object detection},
    author={MMDetection3D Contributors},
    howpublished = {\url{https://github.com/open-mmlab/mmdetection3d}},
    year={2020}
}
```

## Contributing

We appreciate all contributions to improve MMDetection3D. Please refer to [CONTRIBUTING.md](.github/CONTRIBUTING.md) for the contributing guideline.

## Acknowledgement

MMDetection3D is an open source project that is contributed by researchers and engineers from various colleges and companies. We appreciate all the contributors as well as users who give valuable feedbacks.
We wish that the toolbox and benchmark could serve the growing research community by providing a flexible toolkit to reimplement existing methods and develop their own new 3D detectors.

## Projects in OpenMMLab

- [MMCV](https://github.com/open-mmlab/mmcv): OpenMMLab foundational library for computer vision.
- [MIM](https://github.com/open-mmlab/mim): MIM Installs OpenMMLab Packages.
- [MMClassification](https://github.com/open-mmlab/mmclassification): OpenMMLab image classification toolbox and benchmark.
- [MMDetection](https://github.com/open-mmlab/mmdetection): OpenMMLab detection toolbox and benchmark.
- [MMDetection3D](https://github.com/open-mmlab/mmdetection3d): OpenMMLab next-generation platform for general 3D object detection.
- [MMSegmentation](https://github.com/open-mmlab/mmsegmentation): OpenMMLab semantic segmentation toolbox and benchmark.
- [MMAction2](https://github.com/open-mmlab/mmaction2): OpenMMLab's next-generation action understanding toolbox and benchmark.
- [MMTracking](https://github.com/open-mmlab/mmtracking): OpenMMLab video perception toolbox and benchmark.
- [MMPose](https://github.com/open-mmlab/mmpose): OpenMMLab pose estimation toolbox and benchmark.
- [MMEditing](https://github.com/open-mmlab/mmediting): OpenMMLab image and video editing toolbox.
- [MMOCR](https://github.com/open-mmlab/mmocr): OpenMMLab text detection, recognition and understanding toolbox.
- [MMGeneration](https://github.com/open-mmlab/mmgeneration): OpenMMLab image and video generative models toolbox.
>>>>>>> a71bb3f546d3c031f11499ecce2135f4cf6d8a9a
