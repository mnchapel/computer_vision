# Homography compensation on dominant plane

## Data
Images come from the Sintel dataset [1] (http://sintel.is.tue.mpg.de/)

## Motion Compensation
In order to compensate the camera motion, a homography is computed via RANSAC on SIFT feature points between the current image and the first image of the sequence. The homography is then applied on the current image to register it with the first image. As one can see on the result below, the ground does not move because it is the dominant plane in the image. However, the trees nearby and the man are moving. The man moves because he is walking and the trees nearby move because of the parallax motion. If we take a look at the original video, we can see that rotations and zoom are removed.

![result](images/out.gif)

[1] Butler, Daniel J., et al. "A naturalistic open source movie for optical flow evaluation." European Conference on Computer Vision. Springer, Berlin, Heidelberg, 2012.
