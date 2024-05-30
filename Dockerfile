# Use an official Python runtime as the base image
FROM ultralytics/ultralytics:latest-python
# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the Python and opencv dependencies
RUN apt-get update \
    && apt-get install -y ffmpeg libsm6 libxext6 \
    && apt-get clean \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Configure keys and model
ENV ROBOFLOW_API_KEY "your_api_key"
ENV ROBOFLOW_WORKSPACE "your_workspace"
ENV ROBOFLOW_PROJECT "your_project_name"
ENV DATA "data"
ENV MODEL_TYPE "yolov8"
ENV MODEL_NAME "yolov8s.pt"
ENV EPOCHS 100
ENV IMGSZ 640

ENTRYPOINT [ "bash", "entrypoint.sh" ]