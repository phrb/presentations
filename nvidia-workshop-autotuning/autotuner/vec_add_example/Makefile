all:
	-@nvcc -w --Wno-deprecated-gpu-targets -I/opt/cuda/include $(shell echo $(NVCC_FLAGS)) vec_add.cu -o vec_add
