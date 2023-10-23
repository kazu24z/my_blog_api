#!/bin/bash
set -e

# 既存のサーバープロセスを削除
rm -f /app/tmp/pids/server.pid

# コマンドを実行
exec "$@"