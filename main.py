from roboflow import Roboflow
import os

# main.py

def main():
    key = os.environ["ROBOFLOW_API_KEY"]
    rf = Roboflow(api_key=key)
    project = rf.workspace("bunnyai").project("animals-7fizt")
    version = project.version(1)
    dataset = version.download("yolov8")

if __name__ == "__main__":
    main()