import os, ultralytics, torch
from ultralytics import YOLO
from roboflow import Roboflow

print('Checking if GPU is available:', torch.cuda.is_available())

ultralytics.checks()
# Retrieve the bunnyai animals dataset from Roboflow
key = os.getenv("ROBOFLOW_API_KEY") # key injected into container at runtime
workspaceName = os.getenv("ROBOFLOW_WORKSPACE")
projectName = os.getenv("ROBOFLOW_PROJECT")
modelName = os.getenv("MODEL_NAME")
modelType = os.getenv("MODEL_TYPE")

# Load a pretrained model
model = YOLO(modelName)

rf = Roboflow(api_key=key)
project = rf.workspace(workspaceName).project(projectName)
version = project.version(2)
version.download(modelType)
