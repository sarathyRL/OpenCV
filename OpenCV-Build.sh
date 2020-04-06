# Script to build OpenCV 4.2.0 on conda environment (Python3).

# Requirements
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install build-essential cmake pkg-config
sudo apt-get install libjpeg-dev libpng-dev libtiff-dev libavcodec-dev libavformat-dev
sudo apt-get install libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libgtk-3-dev
sudo apt-get install libatlas-base-dev gfortran python3-dev

# Get opencv and opencv_contrib
cd ~/Downloads
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
cd opencv; git checkout 4.2.0
cd ../opencv_contrib; git checkout 4.2.0
cd ..

# Create virtual environment
conda create -y --name opencv numpy
conda activate opencv

# CMAKE and Insatll
cd opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=~/anaconda3/envs/cv \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D INSTALL_C_EXAMPLES=OFF \
    -D BUILD_NEW_PYTHON_SUPPORT=ON \
    -D BUILD_opencv_python3=ON \
    -D HAVE_opencv_python3=ON \
    -D PYTHON_DEFAULT_EXECUTABLE=$(which python3) \
    -D OPENCV_EXTRA_MODULES_PATH=~/Downloads/opencv_contrib-4.2.0/modules \
    -D PYTHON_EXECUTABLE=~/anaconda3/envs/cv/bin/python \
    -D BUILD_EXAMPLES=ON ..
make -j4
make install
ldconfig -n ~/anaconda3/envs/cv/lib

# Check
python -c "import cv2; 
print(cv2.__version__)"
