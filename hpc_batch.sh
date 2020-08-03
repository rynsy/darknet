# rclone --config=$HOME/.config/rclone/rclone.conf lsd remote:/Courses/CS612/Bumgardner
# rclone --config=$HOME/rclone.conf --transfers=32 --checkers=16 --drive-chunk-size=16384k --drive-upload-cutoff=16384k copy ~/darknet_batch.sh remote:Courses/CS612/Bumgardner/darknet_batch2.sh
# TODO: Pre-prep the test/train text files

# echo $SCRATCH has scratch directory

cd $SCRATCH

git clone https://github.com/rynsy/darknet
cd darknet
make

mkdir logs
rclone --config=$HOME/rclone.conf --transfers=32 --checkers=16 --drive-chunk-size=16384k --drive-upload-cutoff=16384k copy remote:Courses/CS612/Bumgardner/images.zip .
rclone --config=$HOME/rclone.conf --transfers=32 --checkers=16 --drive-chunk-size=16384k --drive-upload-cutoff=16384k copy remote:Courses/CS612/Bumgardner/darknet53.conv.74 .

unzip images.zip
rclone --config=$HOME/rclone.conf --transfers=32 --checkers=16 --drive-chunk-size=16384k --drive-upload-cutoff=16384k copy remote:Courses/CS612/Bumgardner/labels.zip .
unzip labels.zip
mv labels/*.txt images/

python split_data.py

# split data, create text files, put them in cfg

./darknet detector \
    train \
    cfg/breath.data \
    cfg/breath-frozen.cfg \
    darknet53.conv.74 > logs/training-output.log
cp darknet53.conv.74 $HOME/darknet53-breath.conv.74
cp -rf logs $HOME/logs
