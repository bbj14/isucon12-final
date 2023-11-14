#!/bin/bash

set -e

# alp で解析
echo
echo '## alp'
echo '```'
sudo alp json --file /var/log/nginx/access.log -m "/image/[0-9a-zA-Z]+,/posts/[0-9a-zA-Z]+,/@[0-9a-zA-Z]+" --sort avg -r
echo '```'

# pt-query-digest で解析
echo
echo '## pt-query-digest'
echo '```'
sudo pt-query-digest /var/log/mysql/mysql-slow.log
echo '```'