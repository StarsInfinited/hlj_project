bash
#!/bin/bash
# check_apisix.sh
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:9080/apisix/status)

if [ "$HTTP_CODE" = "200" ]; then
    logger -t check_apisix "APISIX is healthy (HTTP 200)"
    echo "APISIX is healthy"
    exit 0
else
    logger -t check_apisix "APISIX check FAILED (HTTP $HTTP_CODE)"
    echo "APISIX check FAILED (HTTP $HTTP_CODE)" >&2
    exit 1
fi


sudo tee /etc/keepalived/check_apisix.sh <<'EOF'
#!/bin/bash
# 强制禁用代理，2 秒连接超时，-f 使非 2XX 状态码失败
curl -f -s --noproxy '*' --connect-timeout 2 http://127.0.0.1:9080/apisix/status

if [ $? -eq 0 ]; then
    logger -t check_apisix "OK"
    exit 0
else
    logger -t check_apisix "FAIL"
    exit 1
fi
EOF
