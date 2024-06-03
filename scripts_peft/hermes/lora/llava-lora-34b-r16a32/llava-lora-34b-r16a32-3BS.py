
#!/bin/bash

deepspeed llava/train/train_mem.py \
        --lora_enable True --lora_r 16 --lora_alpha 32 --mm_projector_lr 2e-5 \
        --deepspeed ./scripts/zero3.json \
        --model_name_or_path liuhaotian/llava-v1.6-34b \
        --version chatml_direct_ft \
        --data_path /home/larry5/project/LLaVA-1.6-ft/data/peft/amount/modified_path_to_train_val_human-gpt.json \
        --image_folder /home/larry5/project/LLaVA-1.6-ft/data/data/ \
        --vision_tower openai/clip-vit-large-patch14-336 \
        --mm_projector_type mlp2x_gelu \
        --mm_vision_select_layer -2 \
        --mm_use_im_start_end False \
        --mm_use_im_patch_token False \
        --mm_patch_merge_type spatial_unpad \
        --image_aspect_ratio anyres \
        --group_by_modality_length False \
        --bf16 True \
        --fp16 False \
        --output_dir /home/larry5/project/LLaVA-1.6-ft/scripts_peft/hermes/lora/llava-lora-34b-r16a32/llava-lora-34b-r16a32-3BS-model \
        --num_train_epochs 1 \
        --per_device_train_batch_size 3 \
        --per_device_eval_batch_size 1 \
        --gradient_accumulation_steps 1 \
        --evaluation_strategy "no" \
        --save_strategy "steps" \
        --save_steps 250 \
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