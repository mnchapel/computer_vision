import os
import re
import matplotlib.image as mpimg
import numpy as np
import fnmatch

def loadDataset(dataset_name):
	# Brief: load data and initialize options
	#
	# Parameters:
	#   dataset - the name of the dataset to load
	#
	# Returns:
	#   start_frame - the start frame number
	#   last_frame  - the last frame number
	#   options     - the options of the program

	# Parameters initialization (the values come from the paper)
	options = {};
	options["ransac_threshold"] = 0.1;
	options["ransac_nb_inliers"] = 6000;   # Not provided in the paper
	options["ransac_nb_iter"] = 1000;
	options["frame_window"] = 30;
	options["smoothing_parameter"] = 30;

	# Paths
	base_dir = os.path.dirname(os.path.abspath(__file__));
	data_path = base_dir + "/../data/" + dataset_name;
	filename_template = 'VHand%03d.bmp';
	image_template = data_path + "/" + filename_template;
	options["base_dir"] = base_dir;
	options["data_path"] = data_path;
	options["image_template"] = image_template;

	[start_frame, last_frame] = getStartLastFrame(data_path, 'bmp', filename_template);

	fname = image_template % 1;
	im = mpimg.imread(fname);
	options["im_rows"] = np.size(im, 0);
	options["im_cols"] = np.size(im,1);

	return start_frame, last_frame, options;



def getStartLastFrame(data_path, extension, image_template):
	# Brief:
	#
	# Parameters:
	#   data_path       -
	#   extension       -
	#   image_template  -
	#
	# Returns:
	#   start_frame - the start frame number
	#   last_frame  - the last frame number

	last_frame = 0;
	start_frame = 10e10;

	img_filenames = fnmatch.filter(os.listdir(data_path), '*.'+extension);
	for filename in img_filenames:
		regex = re.compile(r"\d+");
		#[int(frame_num) for frame_num in regex.findall(filename)];
		frame_num = regex.search(filename).group(0);
		start_frame = min(start_frame, int(frame_num));
		last_frame  = max(last_frame,  int(frame_num));

	return start_frame, last_frame;
