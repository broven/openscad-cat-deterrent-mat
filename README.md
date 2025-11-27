# OpenSCAD Cat Deterrent Mat

一个使用 OpenSCAD 设计的猫咪驱赶垫项目。

## 开发环境设置

### 1. 安装 OpenSCAD

#### macOS (使用 Homebrew)
```bash
brew install --cask openscad
```

#### 其他平台
- **Windows**: 从 [OpenSCAD 官网](https://openscad.org/downloads.html) 下载安装程序
- **Linux**: 使用包管理器安装，例如：
  ```bash
  sudo apt-get install openscad  # Ubuntu/Debian
  sudo yum install openscad      # CentOS/RHEL
  ```

### 2. 安装 VS Code 扩展

打开 VS Code，安装推荐的扩展：

1. **OpenSCAD Language Support** (leoc-io.openscad-language-support)
   - 提供语法高亮、代码补全和预览功能

2. **OpenSCAD** (jmaxxz.openscad)
   - 提供额外的 OpenSCAD 支持

或者使用命令行安装：
```bash
code --install-extension leoc-io.openscad-language-support
code --install-extension jmaxxz.openscad
```

### 3. 配置 OpenSCAD 路径

如果 OpenSCAD 安装在其他位置，请修改 `.vscode/settings.json` 中的 `openscad.executable` 路径。

#### macOS 常见路径：
- Homebrew: `/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD`
- 手动安装: `/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD`

#### Linux 常见路径：
- `/usr/bin/openscad`

#### Windows 常见路径：
- `C:\Program Files\OpenSCAD\openscad.exe`

## 使用方法

### 预览 OpenSCAD 文件

1. 打开任意 `.scad` 文件
2. 使用以下方式预览：
   - **快捷键**: `Cmd+Shift+P` (macOS) 或 `Ctrl+Shift+P` (Windows/Linux)，然后输入 "OpenSCAD: Preview"
   - **命令面板**: 选择 "OpenSCAD: Preview" 命令
   - **右键菜单**: 在 `.scad` 文件中右键，选择 "OpenSCAD: Preview"

### 渲染和导出

1. **在 VS Code 中**: 使用扩展的预览功能
2. **在 OpenSCAD 应用中**: 
   - 打开 `.scad` 文件
   - 点击 "Render" (F6) 进行渲染
   - 点击 "Export" 导出为 STL、OFF 等格式

### 自动刷新

开发环境已配置为自动刷新预览（延迟 500ms）。当你保存文件时，预览会自动更新。

## 项目结构

```
.
├── .vscode/          # VS Code 配置文件
│   ├── settings.json # OpenSCAD 相关设置
│   └── extensions.json # 推荐的扩展
├── example.scad      # 示例文件
├── LICENSE           # MIT 许可证
└── README.md         # 本文件
```

## 开发提示

- 使用 `//` 进行单行注释
- 使用 `/* */` 进行多行注释
- 变量名区分大小写
- 使用模块（module）来组织代码
- 使用函数（function）来封装计算逻辑

## 参考资源

- [OpenSCAD 官方文档](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual)
- [OpenSCAD 语言参考](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/General)
- [OpenSCAD 教程](https://openscad.org/documentation.html)

## 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

