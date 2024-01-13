#!/bin/sh

killall -q polybar
wait
while pidof -q polybar; do
    sleep 1
done

exec polybar mybar
