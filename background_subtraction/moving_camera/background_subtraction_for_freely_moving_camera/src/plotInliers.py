import matplotlib.pyplot as plt
import matplotlib.image as img
import numpy as np



def plotInliers(W, inliers, num_frame, options):
	# Brief: plot inliers on the current image
	#
	# Parameters:
	#	W		  - 2FxP, the trajectory matrix
	#   num_frame - the current frame number
	# 	inliers   -
	#	options   - the options of the program

	# Plot the current image ---------------------------------------------------
	filename = options["image_template"]%num_frame;
	im = img.imread(filename);
	im_plot = plt.imshow(im);

	# Plot the trajectories ----------------------------------------------------
	nb_tracks = np.size(W,1);
	points = np.array([W[0,:], W[1,:]]);

	inliers_points = points[:,inliers];
	outliers = np.setdiff1d(range(nb_tracks), inliers);
	outliers_points = points[:,outliers];

	plt.scatter(x=inliers_points[0,:],  y=inliers_points[1,:],  c='b', s=2);
	plt.scatter(x=outliers_points[0,:], y=outliers_points[1,:], c='r', s=2);

	plt.show();



def plotKdeResults(num_frame, W, inliers, probs_inliers, probs_outliers, options):
	# Brief:
	#
	# num_frame		 -
	# probs_inliers	 -
	# probs_outliers -
	# options		 -

	fig, ax = plt.subplots(1,2);

	# Plot contours of density
	linspace_r = range(0, options["im_rows"]);
	linspace_c = range(0, options["im_cols"]);
	C, R = np.meshgrid(linspace_c, linspace_r);

	res_inliers = np.exp(probs_inliers);
	res_inliers = res_inliers.reshape(options["im_rows"], options["im_cols"]);
	level_inliers = np.linspace(0, res_inliers.max(), 25);

	res_outliers = np.exp(probs_outliers);
	res_outliers = res_outliers.reshape(options["im_rows"], options["im_cols"]);
	level_outliers = np.linspace(0, res_outliers.max(), 15);

	ax[0].contourf(C, R, res_inliers,  levels=level_inliers,  cmap="Blues");
	ax[1].contourf(C, R, res_outliers, levels=level_outliers, cmap="Reds");

	ax[0].set(xlim=[0,options["im_cols"]], ylim=[0,options["im_rows"]], aspect=1);
	ax[1].set(xlim=[0,options["im_cols"]], ylim=[0,options["im_rows"]], aspect=1);

	ax[0].invert_yaxis();
	ax[1].invert_yaxis();

	# Plot the trajectories ----------------------------------------------------
	nb_tracks = np.size(W,1);
	points = np.array([W[0,:], W[1,:]]);

	inliers_points = points[:,inliers];
	outliers = np.setdiff1d(range(nb_tracks), inliers);
	outliers_points = points[:,outliers];

	#ax[0].scatter(x=inliers_points[0,:],  y=inliers_points[1,:],  c='b', s=1);
	#ax[1].scatter(x=outliers_points[0,:], y=outliers_points[1,:], c='r', s=1);

	ax[0].set_title("Inliers");
	ax[1].set_title("Outliers");

	plt.show();
