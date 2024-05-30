#!/bin/bash
python main.py
ls
cat animals-2/data.yaml
# Run yolo.exe command
yolo task=detect mode=train model=$MODEL_NAME data=$DATA epochs=$EPOCHS imgsz=$IMGSZ
