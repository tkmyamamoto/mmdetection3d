PYTHON_VERSION:= 3.7
CUDA_VERSION:= 11.0
PYTORCH_VERSION:= 1.7.1
TORCH_VISION_VERSION:= 0.8.2
DOT:= .
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
	. ./activate_python.sh && conda install -y pytorch==$(PYTORCH_VERSION) \
		torchvision==$(TORCH_VISION_VERSION) cudatoolkit=$(CUDA_VERSION) -c pytorch
	touch pytorch.done

mmcv.done: pytorch.done
	. ./activate_python.sh && pip install mmcv-full \
		-f https://download.openmmlab.com/mmcv/dist/cu$(subst $(DOT),,$(CUDA_VERSION))/torch$(PYTORCH_VERSION)/index.html
	touch mmcv.done

mmdet.done: mmcv.done
	# NOTE(kan-bayashi): Update version?
	. ./activate_python.sh && pip install mmdet==2.14.0
	touch mmdet.done

mmsegmentation.done: mmdet.done
	# NOTE(kan-bayashi): Update version?
	. ./activate_python.sh && pip install mmsegmentation==0.14.1
	touch mmsegmentation.done

mmdet3d.done: mmsegmentation.done
	. ./activate_python.sh && cd ../ && pip install -e .
	touch mmdet3.done

clean:
	rm -fr venv *.done
	find -iname "*.pyc" -delete
