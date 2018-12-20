# Homography compensation on dominant plane

## Data
Images come from [1] (http://vis-www.cs.umass.edu/motionSegmentation/complexBgVideos.html)

## Motion Compensation
In order to compensate the camera motion, a homography is computed via RANSAC on SIFT feature points between the current image and the first image of the sequence. The homography is then applied on the current image to register it with the first image. As one can see on the result below, the ground does not move because it is the dominant plane in the image. However, the trees nearby and the man are moving. The man moves because he is walking and the trees nearby move because of the parallax motion. If we take a look at the original video, we can see that rotations and zoom are removed.

![result](images/res.gif)

[1] Manjunath Narayana, Allen Hanson, Erik Learned-Miller, "Coherent Motion Segmentation in Moving Camera Videos using Optical Flow Orientations", International Conference on Computer Vision (ICCV), 2013.
