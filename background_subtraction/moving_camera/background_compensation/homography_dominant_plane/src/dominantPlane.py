import cv2



def ransacHomography(mfp_src, mfp_dst, options):
	# Brief:
	#
	# Parameters:
	#	mfp_src - matched feature points in the source image.
	#	mfp_dst - matched feature points in the destination image.
	#	options - the options of the program.
	#
	# Returns
	#	H - the homography matrix.

	H = cv2.findHomography(mfp_src, mfp_dst, cv2.RANSAC, 5.0);

	return H;
