// https://github.com/broven/openscad-cat-deterrent-mat
/* [主要参数] */
layer_height_mm = 0.2;
layer_thickness_mm = 0.42;
// 垫子的宽度（厘米）
width_cm = 10;
// 垫子的长度（厘米）
height_cm = 10;
// 垫子底板的层数
depth_layer = 2;

/* [尖刺参数] */
// 尖刺壁厚
spike_wall_layer = 2;

/* [高级参数] */
// 尖刺的高度（毫米）
spike_height_mm = 7;
// 尖刺的间距（毫米）
spike_spacing_mm = 10;
// 尖刺底部直径（毫米）
spike_base_diameter_mm = 7;
// 尖刺顶部直径（毫米）
spike_top_diameter_mm = 0.5;
// 尖刺的圆角半径（毫米，0 表示尖锐）
spike_rounding_mm = 0.1;

// ============================================
// 内部变量（以下划线开头，不会显示在 Customizer 界面）
// ============================================

// 转换为毫米（OpenSCAD 默认使用毫米）
_width_mm = width_cm * 10;
_height_mm = height_cm * 10;
_depth_mm = depth_layer * layer_height_mm;
_spike_wall_thickness_mm = spike_wall_layer * layer_thickness_mm + 0.1;
// 计算尖刺的行数和列数
_spike_cols = floor(_width_mm / spike_spacing_mm);
_spike_rows = floor(_height_mm / spike_spacing_mm);

// 计算实际使用的宽度和高度（基于尖刺数量）
_actual_width = _spike_cols * spike_spacing_mm;
_actual_height = _spike_rows * spike_spacing_mm;

// ============================================
// 主模块
// ============================================

module cat_deterrent_mat() {
    // 将整个模型居中到坐标系原点
    translate([-_actual_width/2, -_actual_height/2, 0]) {
        // 底板（带通孔）
        difference() {
            base_plate();
            // 在底板上打孔（尖刺底部通孔）
            translate([spike_spacing_mm/2, spike_spacing_mm/2, -0.1]) {
                base_plate_holes();
            }
        }
        
        // 尖刺阵列（中空）
        translate([spike_spacing_mm/2, spike_spacing_mm/2, _depth_mm]) {
            spike_array();
        }
    }
}

// ============================================
// 底板模块
// ============================================

module base_plate() {
    cube([_actual_width, _actual_height, _depth_mm]);
}

// ============================================
// 单个尖刺模块（中空）
// ============================================

module spike() {
    difference() {
        // 外部尖刺
        spike_solid();
        
        // 内部空心（减去壁厚）
        translate([0, 0, -0.1]) {
            spike_hollow();
        }
    }
}

// 实心尖刺（用于创建中空效果）
module spike_solid() {
    // 使用较小的 $fn 值以减少 CSG 复杂度
    _fn = 8;
    // 简单的尖锐尖刺（已去除圆角优化）
    cylinder(h = spike_height_mm, 
            d1 = spike_base_diameter_mm, 
            d2 = spike_top_diameter_mm,
            $fn = _fn);
}

// 内部空心部分（用于减去）
module spike_hollow() {
    // 计算内部直径（外部直径减去两倍壁厚）
    _inner_base_diameter = max(0.1, spike_base_diameter_mm - 2 * _spike_wall_thickness_mm);
    _inner_top_diameter = max(0.1, spike_top_diameter_mm - 2 * _spike_wall_thickness_mm);
    
    // 顶部封闭层厚度：至少为壁厚，确保顶部完全封闭
    _top_closed_thickness = max(_spike_wall_thickness_mm, 0.2);
    
    // 内部空心在尖刺部分的高度（顶部留出封闭层）
    _spike_hollow_height = spike_height_mm - _top_closed_thickness;
    
    // 使用较小的 $fn 值以减少 CSG 复杂度
    _fn = 8;
    
    // 简单的内部空心（限制高度，顶部留出封闭层，已去除圆角优化）
    if (_spike_hollow_height > 0) {
        cylinder(h = _spike_hollow_height, 
                d1 = _inner_base_diameter, 
                d2 = _inner_top_diameter,
                $fn = _fn);
    }
}

// ============================================
// 尖刺阵列模块
// ============================================

module spike_array() {
    for (i = [0 : _spike_cols - 1]) {
        for (j = [0 : _spike_rows - 1]) {
            translate([i * spike_spacing_mm, j * spike_spacing_mm, 0]) {
                spike();
            }
        }
    }
}

// 底板上的通孔（简化版本，只需要圆柱孔）
module base_plate_hole() {
    // 计算内部底部直径（用于通孔）
    _inner_base_diameter = max(0.1, spike_base_diameter_mm - 2 * _spike_wall_thickness_mm);
    
    // 使用较小的 $fn 值以减少 CSG 复杂度（统一为 8）
    _fn = 8;
    
    // 在底板上打一个圆柱孔，确保完全穿透
    cylinder(h = _depth_mm + 0.2, 
            d = _inner_base_diameter, 
            $fn = _fn);
}

// 底板通孔阵列
module base_plate_holes() {
    for (i = [0 : _spike_cols - 1]) {
        for (j = [0 : _spike_rows - 1]) {
            translate([i * spike_spacing_mm, j * spike_spacing_mm, 0]) {
                base_plate_hole();
            }
        }
    }
}

// ============================================
// 渲染主模型
// ============================================

cat_deterrent_mat();

