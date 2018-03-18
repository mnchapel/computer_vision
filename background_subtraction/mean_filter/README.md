# Background subtraction using mean filtering

## Data
Images come from the ARENA-N1-01_02_ENV_RGB_3 train sequence of the PETS2017 dataset [1] (https://motchallenge.net/data/PETS2017/).

## Background subtraction
The background model is construct with the <a href="http://www.codecogs.com/eqnedit.php?latex=n" target="_blank"><img src="http://latex.codecogs.com/gif.latex?n" title="n" /></a> previous images at time <a href="http://www.codecogs.com/eqnedit.php?latex=t" target="_blank"><img src="http://latex.codecogs.com/gif.latex?t" title="t" /></a>:

<p style="text-align: center;"><a href="http://www.codecogs.com/eqnedit.php?latex=B(x,y,t)&space;=&space;\frac{1}{n}&space;\sum^n_{i=1}&space;I(x,y,t-i)" target="_blank"><img src="http://latex.codecogs.com/gif.latex?B(x,y,t)&space;=&space;\frac{1}{n}&space;\sum^n_{i=1}&space;I(x,y,t-i)" title="B(x,y,t) = \frac{1}{n} \sum^n_{i=1} I(x,y,t-i)" /></a></p>

Current image rgb #50                    | Current image grayscale #50                          | Background image grayscale #50
:---------------------------------------:|:----------------------------------------------------:|:----------------------------------------:
![current image rgb](images/img_rgb.jpg) | ![current image grayscale](images/img_grayscale.jpg) | ![background model](images/bg_model.jpg)

The current image is then subtracted to the background model and thresholded:

<p style="text-align: center;"><a href="http://www.codecogs.com/eqnedit.php?latex=|I(x,y,t)&space;-&space;B(x,y,t)|&space;>&space;threshold" target="_blank"><img src="http://latex.codecogs.com/gif.latex?|I(x,y,t)&space;-&space;B(x,y,t)|&space;>&space;threshold" title="|I(x,y,t) - B(x,y,t)| > threshold" /></a></p>

## Results
Some results with different <a href="http://www.codecogs.com/eqnedit.php?latex=n" target="_blank"><img src="http://latex.codecogs.com/gif.latex?n" title="n" /></a> values (here threshold = 20)

|      | Background model                              | Current image grayscale # 50                         | Mask
|:----:|:---------------------------------------------:|:----------------------------------------------------:|:-------------------------------------:
| n=10 | ![background image](images/bg_model_n_10.jpg) | ![current image grayscale](images/img_grayscale.jpg) | ![current image](images/res_n_10.jpg)
| n=20 | ![background image](images/bg_model_n_20.jpg) | ![current image grayscale](images/img_grayscale.jpg) | ![current image](images/res_n_20.jpg)
| n=30 | ![background image](images/bg_model_n_30.jpg) | ![current image grayscale](images/img_grayscale.jpg) | ![current image](images/res_n_30.jpg)
| n=40 | ![background image](images/bg_model_n_40.jpg) | ![current image grayscale](images/img_grayscale.jpg) | ![current image](images/res_n_40.jpg)

## Reference
[1] Patino, L., Cane, T., Vallee, A. & Ferryman, J. PETS 2016: Dataset and Challenge. In The IEEE Conference on Computer Vision and Pattern Recognition (CVPR) Workshops, 2016.
