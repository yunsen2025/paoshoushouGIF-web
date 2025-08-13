#!/bin/bash
# 手动打包脚本 - 如果GitHub Actions有问题可以手动运行

# 设置变量
DATE=$(date +"%Y%m%d-%H%M%S")
GIF_COUNT=$(find gif -name "*.gif" | wc -l)
PACK_NAME="paoshoushou-gif-pack-${DATE}"

echo "🎭 开始打包表情包..."
echo "📊 发现 ${GIF_COUNT} 个表情包文件"

# 创建临时目录
mkdir -p "release-temp/${PACK_NAME}"

# 复制gif文件
cp -r gif/* "release-temp/${PACK_NAME}/"

# 创建说明文件
cat > "release-temp/${PACK_NAME}/README.txt" << EOF
刨手手表情包合集
==================

📦 包含表情包数量: ${GIF_COUNT} 个
📅 打包时间: $(date '+%Y年%m月%d日 %H:%M:%S')
🌐 项目地址: https://github.com/yunsen2025/paoshoushouGIF-web
🎯 在线预览: https://paoshoushou.112601.xyz/

使用说明:
- 所有文件均为GIF格式
- 可直接用于QQ、微信等聊天软件
- 支持拖拽导入到各类表情包管理工具

版权声明:
本表情包仅供个人学习交流使用，版权归原作者所有。
如有侵权，请联系删除。
EOF

# 打包
cd release-temp
zip -r "../${PACK_NAME}.zip" "${PACK_NAME}/"
cd ..

# 清理临时文件
rm -rf release-temp

echo "✅ 打包完成!"
echo "📦 文件名: ${PACK_NAME}.zip"
echo "💾 文件大小: $(du -h ${PACK_NAME}.zip | cut -f1)"
echo ""
echo "📝 接下来请手动:"
echo "1. 去 GitHub 仓库的 Releases 页面"
echo "2. 点击 'Create a new release'"
echo "3. 上传生成的 ${PACK_NAME}.zip 文件"
echo "4. 设置标签为: gif-pack-${DATE}"
