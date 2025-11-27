#!/bin/bash -x

# 使用 Manifold 后端（比默认的 CGAL 更快）
# OpenSCAD 会自动使用缓存，无需手动指定
openscad --backend=Manifold -o output/A1_full_plate.stl -D width_cm=25.6 -D height_cm=25.6 main.scad
openscad --backend=Manifold -o output/A1_mini_full_plate.stl -D width_cm=18 -D height_cm=18 main.scad
