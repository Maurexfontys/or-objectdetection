FROM python

COPY YOLO_DETECTION /app/YOLO_DETECTION
COPY entrypoint.sh /app/entrypoint.sh
COPY requirements.txt /app/requirements.txt

RUN cd /app/YOLO_DETECTION
RUN cd config && ./download_weights.sh && cd ..
RUN pip install -r /app/requirements.txt
RUN apt-get update && apt-get install -y libgl1-mesa-glx && rm -rf /var/lib/apt/lists/*
RUN apt-get update &&\
apt-get install -y \
python-skimage \
python-pip
RUN pip install --upgrade scikit-image


ENTRYPOINT ["/app/entrypoint.sh"]
