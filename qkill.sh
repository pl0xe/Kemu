#!/usr/bin/env sh

ps aux | grep -i qemu | grep -v grep | awk {'print $2'} | xargs kill
