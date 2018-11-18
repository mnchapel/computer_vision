import cv2
import numpy as np

from drawFunctions import *



def findFeaturePointsSIFT(im):
	# Brief
	#
	# Parameters:
	#	im - the current image.
	#
	# Returns:
	#	fp   - feature points.
	#	desc - feature point descriptors.

	sift = sift = cv2.xfeatures2d.SIFT_create();
	fp, desc = sift.detectAndCompute(im, None);

	#img = draw_keypoints(im, fp);
	#cv2.imwrite('sift_keypoints.png', img);

	return fp, desc;



def matchFeaturePoints(fp_src, fp_dst, desc_src, desc_dst):
	# Brief
	#
	# Parameters:
	#	fp_src   - feature points in the source image.
	#	fp_dst   - feature points in the destination image.
	#	desc_src - feature point descriptors in the source image.
	#	desc_dst - feature point descriptors in the destination image.
	#
	# Returns
	#

	matcher = cv2.BFMatcher(cv2.NORM_L2, True);
	matches = matcher.match(desc_src, desc_dst);

	mfp_src = np.float32([fp_src[match.queryIdx].pt for match in matches]).reshape(-1,1,2);
	mfp_dst = np.float32([fp_dst[match.trainIdx].pt for match in matches]).reshape(-1,1,2);

	return mfp_src, mfp_dst;
