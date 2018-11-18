import cv2
import numpy as np

from loadDataset import loadDataset
from featurePoints import *
from dominantPlane import *




# Load data --------------------------------------------------------------------
dataset_name = "forest";
filename_template = "forest_%05d.png";
start_frame, last_frame, options = loadDataset(dataset_name, filename_template);

# For each frame in the dataset ------------------------------------------------
for num_frame in range(start_frame, last_frame+1):
	print("Frame {}".format(num_frame));

	# Read the current frame (aka the destination image)
	filename = options["image_template"]%num_frame;
	im = cv2.imread(filename);

	fp_src, desc_src = findFeaturePointsSIFT(im);
	print("\t There are {} feature points.".format(len(fp_src)));

	if(num_frame > start_frame):
		mfp_src, mfp_dst = matchFeaturePoints(fp_src, fp_dst, desc_src, desc_dst);
		H, status = cv2.findHomography(mfp_src, mfp_dst, cv2.RANSAC, 5.0);

		im_warped = cv2.warpPerspective(im, H, (options["im_cols"], options["im_rows"]));

		filename = "../results/res_%03d.jpg"%num_frame;
		cv2.imwrite(filename, im_warped);
	else:
		fp_dst   = fp_src;
		desc_dst = desc_src;
