# 1. 安装 Nginx
echo "🔧 安装 Nginx..."
yum install -y nginx
systemctl enable nginx
systemctl start nginx

# 2. 写入 Nginx 配置
echo "📝 配置 Nginx..."
# 顺手备份并移除可能的默认冲突配置
[ -f /etc/nginx/conf.d/default.conf ] && mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak

cat > /etc/nginx/conf.d/web.conf <<'EOF'
server {
    listen       80;
    server_name  localhost;

    location / {
        root   /var/www/web/static;
        index  index.html index.htm;
        try_files $uri $uri/ /index.html;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
EOF
nginx -t && nginx -s reload
echo "✅ Nginx 配置完成"