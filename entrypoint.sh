#!/bin/bash
yolo task=detect mode=train model=$MODEL_NAME data=$DATA epochs=$EPOCHS imgsz=$IMGSZ
