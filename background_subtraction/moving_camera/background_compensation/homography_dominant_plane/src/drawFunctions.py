import cv2

def draw_keypoints(vis, keypoints, color = (0, 255, 255)):
	for kp in keypoints:
			x, y = kp.pt;
			cv2.circle(vis, (int(x), int(y)), 2, color);

	return vis;
