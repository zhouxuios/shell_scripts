# 1. 安装 JDK 17
echo "🔧 安装 OpenJDK 17..."
# 如果已经存在旧的，先清理，防止 mv 嵌套
rm -rf /usr/local/java/jdk17
mkdir -p /usr/local/java

curl -L -O https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz
tar -xzf jdk-17_linux-x64_bin.tar.gz -C /usr/local/java
mv /usr/local/java/jdk-17* /usr/local/java/jdk17
rm -f jdk-17_linux-x64_bin.tar.gz

# 2. 写入环境变量 (使用 'EOF' 防止 $ 符号被当前 shell 解析)
if ! grep -q "JAVA_HOME=/usr/local/java/jdk17" /etc/profile; then
    cat >> /etc/profile <<'EOF'

# Java Environment
export JAVA_HOME=/usr/local/java/jdk17
export PATH=$JAVA_HOME/bin:$PATH
EOF
fi

# 关键：手动为当前脚本进程加载变量
export JAVA_HOME=/usr/local/java/jdk17
export PATH=$JAVA_HOME/bin:$PATH

echo "🔎 验证安装结果："
java -version