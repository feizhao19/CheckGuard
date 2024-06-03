#!/bin/bash
# Use first parameter as GPU IDs, default to "0,1,2,3" if not provided
GPU_IDS=${1:-0,1,2,3}


CUDA_VISIBLE_DEVICES=0,1,2,3 deepspeed --include localhost:"$GPU_IDS" --master_port 29604\
    llava/train/train_mem.py \
    --lora_enable True --lora_r 128 --lora_alpha 256 --mm_projector_lr 2e-5 \
    --deepspeed ./scripts/zero3.json \
    --model_name_or_path liuhaotian/llava-v1.6-mistral-7b \
    --version mistral_instruct \
    --data_path /home/larry5/project/LLaVA-1.6-ft/data/peft/check_no/check_no_dataset.json \
    --image_folder /home/larry5/project/LLaVA-1.6-ft/data/data/ \
    --vision_tower openai/clip-vit-large-patch14-336 \
    --mm_projector_type mlp2x_gelu \
    --mm_vision_select_layer -2 \
    --mm_use_im_start_end False \
    --mm_use_im_patch_token False \
    --mm_patch_merge_type spatial_unpad \
    --image_aspect_ratio anyres \
    --group_by_modality_length False \
    --bf16 False \
    --fp16 True \
    --output_dir /home/larry5/project/LLaVA-1.6-ft/scripts_peft/mistral/lora/llava-lora-mistral-r128a256/wholeimage/check_no/llava-lora-mistral-r128a256-10BS-model \
    --num_train_epochs 1 \
    --per_device_train_batch_size 10 \
    --per_device_eval_batch_size 1 \
    --gradient_accumulation_steps 1 \
    --evaluation_strategy "no" \
    --save_strategy "steps" \
    --save_steps 500 \
    --save_total_limit 5 \
    --learning_rate 2e-5 \
    --weight_decay 0. \
    --warmup_ratio 0.05 \
    --lr_scheduler_type "cosine" \
    --logging_steps 1 \
    --tf32 True \
    --model_max_length 4096 \
    --gradient_checkpointing True \
    --dataloader_num_workers 4 \
    --lazy_preprocess True \
    --report_to wandb \