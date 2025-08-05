
#!/bin/bash

# 基础配置
PROJECT_NAME="SkyLoan_phillipines"  # 替换为实际项目名
SCHEME="Debug"        # 替换为实际scheme名
EXPORT_METHOD="development"  # 导出方式: app-store/ad-hoc/enterprise/development
WORKSPACE_PATH="$PROJECT_NAME.xcworkspace"
ARCHIVE_PATH="build/$PROJECT_NAME.xcarchive"
EXPORT_PATH="build/ipa"

# 清理构建目录
function clean_build() {
    echo "🔧 清理构建目录..."
    xcodebuild clean \
    -workspace "$WORKSPACE_PATH" \
    -scheme "$SCHEME" \
    -configuration Release \
    -quiet || exit 1
}

# 执行归档操作
function archive_project() {
    echo "📦 开始归档项目..."
    xcodebuild archive \
    -workspace "$WORKSPACE_PATH" \
    -scheme "$SCHEME" \
    -configuration Release \
    -archivePath "$ARCHIVE_PATH" \
    -quiet || exit 1
}

# 导出IPA文件
function export_ipa() {
    echo "🚀 导出IPA文件..."
    xcodebuild -exportArchive \
    -archivePath "$ARCHIVE_PATH" \
    -exportPath "$EXPORT_PATH" \
    -exportOptionsPlist "ExportOptions.plist" \
    -quiet || exit 1
}

# 主执行流程
clean_build
archive_project
export_ipa

echo "✅ IPA文件已生成在: $EXPORT_PATH"

