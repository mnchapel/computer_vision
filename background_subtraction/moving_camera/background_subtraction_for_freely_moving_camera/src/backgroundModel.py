from __future__ import division
from projectionError import projectionError
import numpy as np



def backgroundModel(W, options):
	# Brief:
	#
	# Parameters:
	#   W       - 2FxP, the trajectories
	#   options - the options of the program
	#
	# Returns
	#   inliers -

	nb_tracks = np.size(W,1);
	max_inliers = 0;
	inliers = [];

	if nb_tracks<3:
		return;

	# Normalization ------------------------------------------------------------
	W_bis = W[2:,:];
	W_bis = W[0:-2,:]-W_bis;
	W_norm = np.zeros((options["frame_window"]-1, nb_tracks));

	for i in range(0,nb_tracks):
		for j in range(0,options["frame_window"]-1):
			W_norm[j,i] = np.linalg.norm(W_bis[j*2:j*2+2, i]);

	W_sum = W_norm.sum(0);
	W = W / W_sum;

	# Mean ---------------------------------------------------------------------
	Wx_tmp = W[0::2,:];
	Wy_tmp = W[1::2,:];
 	W[0::2,:] -= Wx_tmp.mean(0);
 	W[1::2,:] -= Wy_tmp.mean(0);

	# RANSAC -------------------------------------------------------------------
	for i in range (0,options["ransac_nb_iter"]):
		# Select 3 trajectories randomly
		rand_ids = np.random.permutation(nb_tracks);
		W_rand = W[:,rand_ids[0:3]];

		# Compute the projection error for each point
		W_errors = projectionError(W_rand, W);

		# Count inliers
		new_inliers_id = np.where(W_errors < options["ransac_threshold"]);
		new_inliers_id = new_inliers_id[0];
		nb_inliers = len(new_inliers_id);

		if(max_inliers < nb_inliers):
			max_inliers = nb_inliers;
			inliers = new_inliers_id;

		if(max_inliers > options["ransac_nb_inliers"]):
			break;

	return inliers;
