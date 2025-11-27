/* [主要参数] */
// 垫子的宽度（厘米）
width_cm = 14.5;
// 垫子的长度（厘米）
height_cm = 40;
// 垫子底板的厚度（毫米，建议设置为首层厚度）
depth_mm = 0.2;

/* [尖刺参数] */
// 尖刺的高度（毫米）
spike_height_mm = 7;
// 尖刺的间距（毫米）
spike_spacing_mm = 10;
// 尖刺底部直径（毫米）
spike_base_diameter_mm = 7;
// 尖刺顶部直径（毫米）
spike_top_diameter_mm = 0.5;

/* [高级参数] */
// 尖刺的圆角半径（毫米，0 表示尖锐）
spike_rounding_mm = 0.1;

// ============================================
// 内部变量（以下划线开头，不会显示在 Customizer 界面）
// ============================================

// 转换为毫米（OpenSCAD 默认使用毫米）
_width_mm = width_cm * 10;
_height_mm = height_cm * 10;
_depth_mm = depth_mm;

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
        // 底板
        base_plate();
        
        // 尖刺阵列
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
// 单个尖刺模块
// ============================================

module spike() {
    // 使用 hull 和两个圆柱体创建锥形尖刺
    if (spike_rounding_mm > 0) {
        // 带圆角的尖刺
        hull() {
            translate([0, 0, 0]) {
                cylinder(h = spike_rounding_mm, 
                        d1 = spike_base_diameter_mm, 
                        d2 = spike_base_diameter_mm - spike_rounding_mm * 0.5,
                        $fn = 16);
            }
            translate([0, 0, spike_height_mm - spike_rounding_mm]) {
                cylinder(h = spike_rounding_mm, 
                        d1 = spike_top_diameter_mm + spike_rounding_mm * 0.5, 
                        d2 = spike_top_diameter_mm,
                        $fn = 16);
            }
            translate([0, 0, spike_rounding_mm]) {
                cylinder(h = spike_height_mm - 2 * spike_rounding_mm, 
                        d1 = spike_base_diameter_mm - spike_rounding_mm * 0.5, 
                        d2 = spike_top_diameter_mm + spike_rounding_mm * 0.5,
                        $fn = 16);
            }
        }
    } else {
        // 尖锐的尖刺
        cylinder(h = spike_height_mm, 
                d1 = spike_base_diameter_mm, 
                d2 = spike_top_diameter_mm,
                $fn = 16);
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

// ============================================
// 渲染主模型
// ============================================

cat_deterrent_mat();

