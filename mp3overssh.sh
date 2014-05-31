#!/bin/bash

remote_login="user@127.0.0.1"
remote_dir="/"

while getopts l:d: opt; do
    case $opt in
    l)
        remote_login=$OPTARG
        ;;
    d)
        remote_dir=$OPTARG
        ;;
    esac
done

IFS=$'\r\n'
MUSIC_LIST=(` ssh $remote_login "ls $remote_dir" `)

count=${#MUSIC_LIST[@]}
index=0
for f in "${MUSIC_LIST[@]}"
do
    echo [$index] $f
    let "index++"
done

read -p "Enter your selection : " s1

printf -v SONG "%q" ${MUSIC_LIST[$s1]}

ssh $remote_login "cat $remote_dir$SONG" | mplayer -cache 32 -
