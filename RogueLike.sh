#!/bin/sh
echo -ne '\033c\033]0;RogueLike\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/RogueLike.x86_64" "$@"
