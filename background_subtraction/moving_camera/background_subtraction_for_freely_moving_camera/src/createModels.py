import matplotlib.image as img
import numpy as np


def createModels(W, inliers, num_frame, options):
	# Brief:
	#
	# Parameters:
	#   W       - 2FxP, the trajectories
	#   inliers - inliers id
	#   num_frame - the current frame number
	#   options - the options of the program
	#
	# Returns
	#   BG  - the background model
	#   FG  - the foreground model

	nb_tracks = np.size(W,1);

	# Get the current image
	filename = options["image_template"]%num_frame;
	im = img.imread(filename);

	# Get feature points
	points = np.array([W[0,:], W[1,:]]);
	outliers = np.setdiff1d(range(nb_tracks), inliers);

	inliers_points  = points[:,inliers];
	outliers_points = points[:,outliers];

	# Get colors
	inliers_pix  = inliers_points.astype(int);
	outliers_pix = outliers_points.astype(int);
	inliers_rgb  = im[inliers_pix[1,:],  inliers_pix[0,:]];
	outliers_rgb = im[outliers_pix[1,:], outliers_pix[0,:]];

	# Normalize data
	inliers_rgb  = inliers_rgb/255.0;
	outliers_rgb = outliers_rgb/255.0;
	inliers_points[0,:] = inliers_points[0,:]/float(options["im_cols"]);
	inliers_points[1,:] = inliers_points[1,:]/float(options["im_rows"]);
	outliers_points[0,:] = outliers_points[0,:]/float(options["im_cols"]);
	outliers_points[1,:] = outliers_points[1,:]/float(options["im_rows"]);

	# Create models
	# model = [r,g,b,x,y]
	# --- TODO
	BG = np.concatenate((inliers_rgb,  inliers_points.T),  axis=1);
	FG = np.concatenate((outliers_rgb, outliers_points.T), axis=1);
	#BG = inliers_points.T;
	#FG = outliers_points.T;
	# ---

	return BG, FG;
