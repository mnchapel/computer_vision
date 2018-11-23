import scipy.io as sio
import numpy as np
import matplotlib.image as img

from sklearn.neighbors.kde import KernelDensity
from statsmodels.nonparametric.kernel_density import KDEMultivariate
from loadDataset import loadDataset
from updateTrajectories import updateTrajectories
from backgroundModel import backgroundModel
from createModels import createModels
from computeProbabilities import computeProbabilities
from plotInliers import plotInliers
from plotInliers import plotKdeResults



# Load data --------------------------------------------------------------------
dataset_name = "VHand";
[start_frame, last_frame, options] = loadDataset(dataset_name);
content = sio.loadmat("../data/test.mat") # octave code : save -6 path/to/file.mat var
tracks = content["tracks"];

# Background subtraction -------------------------------------------------------
start_frame = start_frame + options["frame_window"] - 1;
# --- TODO REMOVE
last_frame = start_frame+1;
# ---
for num_frame in range(start_frame, last_frame):
	print("Frame {}".format(num_frame));

	# Update trajectories
	W = updateTrajectories(num_frame, tracks, options);
	# Invert y axis in W (coordinate system starts at the lower left corner).
	W[1::2,:] = options["im_rows"] - W[1::2,:];
	print("\t There are {} trajectories.".format(np.size(W,1)));

	# Sparse labeling
	inliers = backgroundModel(W, options);
	print("\t There are {} inliers.".format(len(inliers)));
	plotInliers(W, inliers, num_frame, options);

	# Pixel-wise labeling
	[BG, FG] = createModels(W, inliers, num_frame, options);

	kde_bg = KernelDensity(kernel="epanechnikov", bandwidth=0.1);
	kde_fg = KernelDensity(kernel="epanechnikov", bandwidth=0.1);
	kde_bg.fit(BG);
	kde_fg.fit(FG);

	# x,y indexes of the whole image normalized
	linspace_r = range(0, options["im_rows"]);
	linspace_c = range(0, options["im_cols"]);
	indexes_c, indexes_r = np.meshgrid(linspace_c, linspace_r);
	indexes_r = indexes_r.reshape(options["im_rows"]*options["im_cols"], 1);
	indexes_c = indexes_c.reshape(options["im_rows"]*options["im_cols"], 1);

	# colors of the whole image
	filename = options["image_template"]%num_frame;
	im = img.imread(filename);
	colors = im[indexes_r[:], indexes_c[:]];
	colors = colors.reshape(options["im_rows"]*options["im_cols"], 3);

	# Normalization
	colors = colors/255.0;
	indexes_r = indexes_r/float(options["im_rows"]);
	indexes_c = indexes_c/float(options["im_cols"]);

	# Create data
	# --- TODO
	RGBXY = np.concatenate((colors, indexes_c, indexes_r), axis=1);
	#RGBXY = np.concatenate((indexes_c, indexes_r), axis=1);
	# ---
	inliers_probs  = kde_bg.score_samples(RGBXY);
	outliers_probs = kde_fg.score_samples(RGBXY);

	plotKdeResults(num_frame, W, inliers, inliers_probs, outliers_probs, options);
