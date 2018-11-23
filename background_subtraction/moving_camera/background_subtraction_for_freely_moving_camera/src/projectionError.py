import numpy as np



def projectionError(W_basis, W):
	# Brief:
	#
	# Parameters:
	#   W_basis - (frame_window*2) x 3
	#   W       - (frame_window*2) x m
	#
	# Returns:
	#   errors - the projection errors

	# Projection matrix
	P = np.dot(np.dot(W_basis, np.linalg.pinv(np.dot(W_basis.T, W_basis))), W_basis.T);

	# Projection error
	nb_tracks = np.size(W,1);
	diff = np.dot(P,W) - W;

	errors = np.linalg.norm(diff, axis=0);

	return errors.T;
