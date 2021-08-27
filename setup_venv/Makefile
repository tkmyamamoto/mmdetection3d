PYTHON_VERSION:= 3.7
CUDA_VERSION:= 11.0
PYTORCH_VERSION:= 1.7.1
TORCH_VISION_VERSION:= 0.8.2
DOT:= .
# NOTE(kan-bayashi): Make the cuda ops compatible with GPUs of various compute capabilities
TORCH_CUDA_ARCH_LIST:= 5.2 6.0 6.1 7.0+PTX 8.0+PTX

.PHONY: all clean show_variables

all: show_variables miniconda.done pytorch.done mmcv.done mmdet.done mmsegmentation.done mmdet3d.done

show_variables:
	@echo PYTHON_VERSION=$(PYTHON_VERSION)
	@echo CUDA_VERSION=$(CUDA_VERSION)
	@echo PYTORCH_VERSION=$(PYTORCH_VERSION)
	@echo TORCH_VISION_VERSION=$(TORCH_VISION_VERSION)

miniconda.done: show_variables
	test -d venv || bash setup_anaconda.sh venv mmdet3d $(PYTHON_VERSION)
	touch miniconda.done

pytorch.done: miniconda.done
	# Numpy version is better to fix for the compatibility
	. ./activate_python.sh && conda install -y numpy=1.19
	# NOTE(kan-bayashi): TOO SLOW PYTORCH CONDA CHANNEL
	# . ./activate_python.sh && conda install -y -c pytorch \
	# 	pytorch==$(PYTORCH_VERSION) torchvision==$(TORCH_VISION_VERSION) cudatoolkit=$(CUDA_VERSION)
	# NOTE(kan-bayashi): Workaround, using mirror
	# 	https://blog.karatos.in/a?ID=01650-76d48624-a90d-48b8-887c-760430186d9d
	. ./activate_python.sh && conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
	. ./activate_python.sh && conda config --set show_channel_urls yes
	. ./activate_python.sh && conda install -y \
		pytorch==$(PYTORCH_VERSION) torchvision==$(TORCH_VISION_VERSION) cudatoolkit=$(CUDA_VERSION)
	touch pytorch.done

mmcv.done: pytorch.done
	. ./activate_python.sh && TORCH_CUDA_ARCH_LIST="$(TORCH_CUDA_ARCH_LIST)" pip install --no-cache-dir mmcv-full \
		-f https://download.openmmlab.com/mmcv/dist/cu$(subst $(DOT),,$(CUDA_VERSION))/torch$(PYTORCH_VERSION)/index.html
	touch mmcv.done

mmdet.done: mmcv.done
	# NOTE(kan-bayashi): Update version?
	. ./activate_python.sh && pip install --no-cache-dir mmdet==2.14.0
	touch mmdet.done

mmsegmentation.done: mmdet.done
	# NOTE(kan-bayashi): Update version?
	. ./activate_python.sh && pip install --no-cache-dir mmsegmentation==0.14.1
	touch mmsegmentation.done

mmdet3d.done: mmsegmentation.done
	. ./activate_python.sh && cd ../ && TORCH_CUDA_ARCH_LIST="$(TORCH_CUDA_ARCH_LIST)" pip install -e .
	# NOTE(kan-bayashi): Workaround for https://github.com/open-mmlab/mmdetection3d/issues/650
	. ./activate_python.sh && pip install mmpycocotools pycocotools==2.0.1
	touch mmdet3d.done

open3d.done: mmdet3d.done
	# NOTE(tkmyamamoto): The latest open3d does not work
	# 	See https://github.com/open-mmlab/mmdetection3d/issues/344
	. ./activate_python.sh && pip install open3d==0.11
	touch open3d.done

clean:
	rm -fr venv *.done activate_python.sh miniconda.sh
	find -iname "*.pyc" -delete
