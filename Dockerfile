# Use an official Python runtime as the base image
FROM ultralytics/ultralytics

# Set the working directory in the container
WORKDIR /app

RUN apt-get update \
    && apt-get install -y unzip

ARG DATASET_URL
RUN curl -L $DATASET_URL > data.zip \
    && unzip data.zip \
    && sed -i 's/\.\.\//\/app\//' data.yaml \
    && rm data.zip \
    && apt clean 

# RUN apt-get install -y nvidia-driver-555-open \
#     && apt-get install -y cuda-drivers-555 \


# Copy the requirements file into the container
COPY requirements.txt .

# Install the Python and opencv dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Configure keys and model
ENV DATA=data.yaml \
    MODEL_NAME=yolov8s.pt \
    EPOCHS=100 \
    IMGSZ=640

RUN env

ENTRYPOINT [ "bash", "entrypoint.sh" ]