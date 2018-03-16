# Backgroung subtraction using frame differencing

## Data
Images come from the ARENA-N1-01_02_ENV_RGB_3 train sequence of the PETS2017 dataset [1] (https://motchallenge.net/data/PETS2017/).

## Background subtraction
The image at time <a href="https://www.codecogs.com/eqnedit.php?latex=t" target="_blank"><img src="https://latex.codecogs.com/gif.latex?t" title="t" /></a> represents the background and the image at time <a href="https://www.codecogs.com/eqnedit.php?latex=t&plus;1" target="_blank"><img src="https://latex.codecogs.com/gif.latex?t&plus;1" title="t+1" /></a> that will be compare to the background to extract moving objects (foreground).

Background image #20                    |  Current image #21
:--------------------------------------:|:-------------------------------------:
![background image](images/bg_rgb.png)  |  ![current image](images/img_rgb.png)

In order to subtract images and threshold them, they are convert to grayscale:

Background image grayscale #20               |  Current image grayscale #21
:-------------------------------------------:|:------------------------------------------:
![background image](images/bg_grayscale.png) | ![current image](images/img_grayscale.png)

Then, the frame differencing equation with a threshold is applied:

<p style="text-align: center;"><a href="https://www.codecogs.com/eqnedit.php?latex=|I(x,y,t&plus;1)&space;-&space;I(x,y,t)|&space;>&space;threshold" target="_blank"><img src="https://latex.codecogs.com/gif.latex?|I(x,y,t&plus;1)&space;-&space;I(x,y,t)|&space;>&space;threshold" title="|I(x,y,t+1) - I(x,y,t)| > threshold" /></a></p>

Background subtraction mask #21                              |
:-----------------------------------------------------------:|
![background subtraction](images/background_subtraction.png) |

## Results
Some results with different thresholds.


Threshold = 10                                  |  Threshold = 15
:----------------------------------------------:|:------------------------------------------:
![background image](images/bg_threshold_10.png) | ![current image](images/bg_threshold_15.png)

Threshold = 30                                  |  Threshold = 60
:----------------------------------------------:|:------------------------------------------:
![background image](images/bg_threshold_30.png) | ![current image](images/bg_threshold_60.png)

## Reference
[1] Patino, L., Cane, T., Vallee, A. & Ferryman, J. PETS 2016: Dataset and Challenge. In The IEEE Conference on Computer Vision and Pattern Recognition (CVPR) Workshops, 2016.
