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
ENV ROBOFLOW_API_KEY=your_api_key \
    ROBOFLOW_WORKSPACE=your_workspace \
    ROBOFLOW_PROJECT=your_project_name \
    DATA=data \
    MODEL_TYPE=yolov8 \
    MODEL_NAME=yolov8s.pt \
    EPOCHS=100 \
    IMGSZ=640

RUN env

ENTRYPOINT [ "bash", "entrypoint.sh" ]