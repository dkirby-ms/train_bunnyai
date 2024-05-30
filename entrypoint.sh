#!/bin/bash
python main.py

# Run yolo.exe command
yolo task=classify mode=train model=$MODEL_TYPE data=$DATA epochs=$EPOCHS imgsz=$IMGSZ
