#!/bin/bash
python main.py

# Run yolo.exe command
yolo task=classify mode=train model=$MODEL data=$DATA epochs=50 imgsz=128
