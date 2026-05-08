bash
#!/bin/bash
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:9080/apisix/status)

if [ "$HTTP_CODE" = "200" ]; then
    exit 0
else
    echo "APISIX status check failed, HTTP code: $HTTP_CODE" >&2
    exit 1
fi
