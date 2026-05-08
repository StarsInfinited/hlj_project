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
