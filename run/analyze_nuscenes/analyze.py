import numpy as np
import matplotlib.pyplot as plt
from nuscenes.nuscenes import NuScenes
import os.path as osp
from nuscenes.utils.data_classes import LidarPointCloud
from nuscenes.utils.geometry_utils import view_points


def get_coordinate_from_token(sample_data_token):
    # sd_record = nusc.get('sample_data', sample_data_token)
    # sample_rec = nusc.get('sample', sd_record['sample_token'])

    sample_rec = nusc.get("sample", sample_data_token)

    ref_chan = "LIDAR_TOP"
    ref_sd_token = sample_rec["data"][ref_chan]
    ref_sd_record = nusc.get("sample_data", ref_sd_token)

    pcl_path = osp.join(DATAROOT, ref_sd_record["filename"])
    pc = LidarPointCloud.from_file(pcl_path)
    points = view_points(pc.points[:3, :], np.eye(4), normalize=False)
    x = points[0, :]
    y = points[1, :]

    return x, y


DATAROOT = "/home/t_yamamoto/workspace4/mmdetection3d/data/nuscenes"
nusc = NuScenes(
    version="v1.0-trainval",
    dataroot=DATAROOT,
    verbose=True,
)

print("Scene count: ", len(nusc.scene))

xs = ys = np.empty(0)

for scene_no in range(len(nusc.scene)):
    # for scene_no in range(1):
    print(f"\r{scene_no}/{len(nusc.scene)}")
    my_scene = nusc.scene[scene_no]
    first_sample_token = my_scene["first_sample_token"]

    sample_data_token = first_sample_token
    while True:
        # print("sample_data_token: ", sample_data_token)
        x, y = get_coordinate_from_token(sample_data_token)
        xs = np.append(xs, x)
        ys = np.append(ys, y)
        sample_data_token = nusc.get("sample", sample_data_token)["next"]
        if sample_data_token == "":
            break
    # if len(xs) > 1000000:
    #     break


fig = plt.figure(figsize=(8.0, 6.0))
ax = fig.add_subplot(1, 1, 1)
# ax.scatter(x, y, s=0.01)
ax.scatter(xs, ys, s=0.01)
ax.set_title("plot to xy plane")
ax.set_xlabel("x")
ax.set_ylabel("y")
# fig.savefig(f"./plot_to_xyplane_{first_sample_token}_until_end.png")
fig.savefig("./plot_to_xyplane_all.png")
fig.show()


dist = np.linalg.norm(np.stack([xs, ys]), axis=0)

# plot
fig = plt.figure(figsize=(8.0, 6.0))
ax = fig.add_subplot(1, 1, 1)
ax.hist(dist, bins=500, range=(0, 50))
ax.set_title("Distance of points in nuScenes")
ax.set_xlabel("Distance from center [m]")
ax.set_ylabel("Frequency")
ax.set_xlim(0, 50)
# ax.set_ylim(0, 25000)
fig.savefig("./point_dist_all.png")
fig.show()

fig = plt.figure(figsize=(8.0, 6.0))
ax = fig.add_subplot(1, 1, 1)
ax.hist(dist, bins=500, range=(0, 50), cumulative=True, density=True)
ax.set_title("Distance of points in nuScenes (cumulative)")
ax.set_xlabel("Distance from center [m]")
ax.set_ylabel("Cumulative Ratio")
ax.set_xlim(0, 50)
ax.set_ylim(0, 1)
fig.savefig("./point_dist_cumulative_all.png")
fig.show()

# Reference
# /home/t_yamamoto/workspace4/nuscenes-devkit/python-sdk/tutorials/nuscenes_tutorial.ipynb
# https://www.nuscenes.org/tutorials/nuscenes_tutorial.html
