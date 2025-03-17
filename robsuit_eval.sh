#!/usr/bin/env bash

python3 finetune.py exp_name=test_1 agent=diffusion task=robomimic_toolhang agent/features=resnet_gn agent.features.restore_path=$PWD/visual_features/resnet18/IN_1M_resnet18.pth  trainer=bc_cos_sched ac_chunk=10 eval_freq=15000 batch_size=350