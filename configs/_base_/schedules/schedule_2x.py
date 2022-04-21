# optimizer
# This schedule is mainly used by models on nuScenes dataset
optimizer = dict(
    type="AdamW",
    lr=0.001,
    weight_decay=0.01,
    # paramwise_cfg=dict(
    #    custom_keys={
    #        "pts_middle_encoder": dict(lr_mult=0.0),
    #        "pts_voxel_encoder": dict(lr_mult=0.0),
    #        "pts_backbone": dict(lr_mult=0.0),
    #        "pts_bbox_head": dict(lr_mult=0.0),
    #    }
    # ),
)  # lr 変更すべき

# max_norm=10 is better for SECOND
optimizer_config = dict(grad_clip=dict(max_norm=35, norm_type=2))
lr_config = dict(
    policy="step",
    warmup="linear",
    warmup_iters=1000,
    warmup_ratio=1.0 / 1000,
    step=[20, 23],
    # step=[33, 38],
    # step=[50, 58],
    # step=[100, 115],
)
momentum_config = None
# runtime settings
runner = dict(type="EpochBasedRunner", max_epochs=24)
