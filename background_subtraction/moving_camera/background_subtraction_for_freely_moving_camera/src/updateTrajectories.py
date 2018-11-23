import numpy as np

def updateTrajectories(num_frame, tracks, options):
	# Brief:
	#
	# Parameters
	#     num_frame - the current frame
	#     tracks    -
	#     options   -
	#
	# Returns
	# W - 2F x P, trajectory matrix

	W = np.zeros((options["frame_window"]*2, 0));

	nb_tracks = len(tracks);
	for i in range(0,nb_tracks):
		track_start_frame = tracks[i,0][0,0][0][0][0];
		track_last_frame  = tracks[i,0][0,0][1][0][0];

		if((track_start_frame <= num_frame) and (track_last_frame >= num_frame) and ((num_frame-track_start_frame+1) >= (options["frame_window"]))):
			id_start = int(num_frame-track_start_frame-options["frame_window"]+1);
			id_end   = int(num_frame-track_start_frame);
			#print("id_start {}".format(id_start));
			#print("id_end {}".format(id_end));
			points     = tracks[i,0][0,0][2][0][id_start*2:id_end*2+2];
			is_tracked = tracks[i,0][0,0][3][0][id_start:id_end+1];

			#print is_tracked;
			if 0 in is_tracked:
				a=0;
			else:
				W = np.c_[W, points.T];

	return W;
