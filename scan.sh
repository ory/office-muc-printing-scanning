#!/bin/bash
set -euo pipefail

help="ORY Munich Office Scanning Utility

usage:
    scan.sh [front|back] [flatbed|ADF] <output.pdf>

Prequisities: sane-airscan, imagemagick
"

tmpdir="$(mktemp -d)"
scanimageArgs=("--progress" "--format=jpeg")

case $1 in
    front)
        scanimageArgs+=("--device" "airscan:w0:Brother MFC-L6900DW series")
        ;;
    back)
        scanimageArgs+=("--device" "airscan:w1:Brother MFC-L8690CDW series")
        ;;
    *)
        echo "$help"
        exit
esac

case $2 in
    flatbed)
        scanimageArgs+=("--output-file" "$tmpdir/single.jpg" "--source" "flatbed")
        ;;
    ADF)
        scanimageArgs+=("--batch=$tmpdir/part%d.jpg" "--source" "ADF")
        ;;
    *)
        echo "$help"
        exit
esac

scanimage "${scanimageArgs[@]/#/}"

convert "$tmpdir"/*.jpg -auto-orient "$3"
