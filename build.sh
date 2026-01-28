echo "Configuring and building Thirdparty/DBoW2 ..."

cd Thirdparty/DBoW2
rm -rf build && mkdir build # Clean old failed states
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$CONDA_PREFIX
make -j$(nproc)

cd ../../g2o

echo "Configuring and building Thirdparty/g2o ..."

rm -rf build && mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$CONDA_PREFIX
make -j$(nproc)

cd ../../Sophus

echo "Configuring and building Thirdparty/Sophus ..."

rm -rf build && mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$CONDA_PREFIX
make -j$(nproc)

cd ../../../

echo "Uncompress vocabulary ..."

cd Vocabulary
# Only uncompress if the .txt file doesn't exist yet to save time
if [ ! -f "ORBvoc.txt" ]; then
    tar -xf ORBvoc.txt.tar.gz
fi
cd ..

echo "Configuring and building ORB_SLAM3 ..."

rm -rf build && mkdir build
cd build
# Added the prefix path here to solve the Pangolin/OpenGL mismatch
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$CONDA_PREFIX
make -j$(nproc)