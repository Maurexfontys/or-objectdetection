FROM python

COPY YOLO_DETECTION /app/YOLO_DETECTION
COPY entrypoint.sh /app/entrypoint.sh
COPY requirements.txt /app/requirements.txt

WORKDIR /app/YOLO_DETECTION/config
RUN ./download_weights.sh

WORKDIR /app/YOLO_DETECTION
RUN pip install -r /app/requirements.txt
RUN apt-get update && apt-get install -y libgl1-mesa-glx && rm -rf /var/lib/apt/lists/*
RUN apt-get update &&\
apt-get install -y \
python-skimage \
python-pip
RUN pip install --upgrade scikit-image

FROM nvidia/cuda:10.2-base
CMD nvidia-smi

ENTRYPOINT ["/app/entrypoint.sh"]
