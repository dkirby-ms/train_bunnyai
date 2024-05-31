# Use an official Python runtime as the base image
FROM ultralytics/ultralytics

# Set the working directory in the container
WORKDIR /app

RUN apt-get update \
    && apt-get install -y unzip

ARG DATASET_URI
RUN curl -L $DATASET_URI > data.zip \
    && unzip data.zip \
    && sed -i 's/\.\.\//\/app\//' data.yaml \
    && rm data.zip \
    && apt clean 

# Copy the rest of the application code into the container
COPY entrypoint.sh .

# DATA is the path to the data.yaml file
# MODEL_NAME is the name of the model file to train
# EPOCHS is the number of epochs to train the model
# IMGSZ is the size of the input image
ENV DATA=data.yaml \
    MODEL_NAME=yolov8s.pt \
    EPOCHS=100 \
    IMGSZ=640

RUN env

ENTRYPOINT [ "bash", "entrypoint.sh" ]