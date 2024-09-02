#!/bin/bash

# 网站列表及其对应的密码
declare -A WEBSITES=(
    ["https://site1.com/login"]="password1"
    ["https://site2.com/login"]="password2"
    ["https://site3.com/login"]="password3"
    ["https://site4.com/login"]="password4"
    ["https://site5.com/login"]="password5"
    ["https://site6.com/login"]="password6"
    ["https://site7.com/login"]="password7"
    ["https://site8.com/login"]="password8"
    ["https://site9.com/login"]="password9"
    ["https://site10.com/login"]="password10"
    ["https://site11.com/login"]="password11"
    # 可以根据需要添加更多网站
)

# 循环遍历网站列表
for URL in "${!WEBSITES[@]}"; do
    PASSWORD=${WEBSITES[$URL]}
    
    # 生成临时文件用于cookie存储
    COOKIE_FILE=$(mktemp)

    # 提交登录请求
    RESPONSE=$(curl -s -c $COOKIE_FILE -d "password=$PASSWORD" $URL)
    
    # 检查登录是否成功
    if [[ $RESPONSE == *"Welcome"* ]]; then
        echo "成功登录：$URL"
        
        # 在成功登录后等待5分钟
        echo "等待5分钟..."
        sleep 300 # 300秒 = 5分钟
    else
        echo "登录失败：$URL"
    fi
    
    # 删除cookie文件
    rm $COOKIE_FILE
done
