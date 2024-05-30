import os, ultralytics
from ultralytics import YOLO
from roboflow import Roboflow


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
