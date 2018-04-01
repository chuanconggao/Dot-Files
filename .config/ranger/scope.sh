#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

# If the option `use_preview_script` is set to `true`,
# then this script will be called and its output will be displayed in ranger.
# ANSI color codes are supported.
# STDIN is disabled, so interactive scripts won't work properly

# This script is considered a configuration file and must be updated manually.
# It will be left untouched if you upgrade ranger.

# Meanings of exit codes:
# code | meaning    | action of ranger
# -----+------------+-------------------------------------------
# 0    | success    | Display stdout as preview
# 1    | no preview | Display no preview at all
# 2    | plain text | Display the plain content of the file
# 3    | fix width  | Don't reload when width changes
# 4    | fix height | Don't reload when height changes
# 5    | fix both   | Don't ever reload
# 6    | image      | Display the image `$IMAGE_CACHE_PATH` points to as an image preview
# 7    | image      | Display the file directly as an image

# Script arguments
FILE_PATH="${1}"         # Full path of the highlighted file
IMAGE_CACHE_PATH="${4}"  # Full path that should be used to cache image preview
PV_IMAGE_ENABLED="${5}"  # 'True' if image previews are enabled, 'False' otherwise.


handle_extension() {
    local file_extension="${FILE_PATH##*.}"
    local file_extension_lower=$(echo ${file_extension} | tr '[:upper:]' '[:lower:]')

    case "${file_extension_lower}" in
        # QuickLook
        pdf|doc|docx|xls|xlsx|ppt|pptx|htm|html|xhtml|icns|svg|mov|mp4|mpeg)
            if [[ "${PV_IMAGE_ENABLED}" == 'True' ]]; then
                qlmanage -o "$TMPDIR" -t -s 800 "$FILE_PATH" && convert "$TMPDIR/$(basename "$FILE_PATH").png" "$IMAGE_CACHE_PATH" && exit 6
            fi
            exit 1;;

        # CSV
        csv)
            head "$FILE_PATH" | csvlook -I && exit 0
            exit 1;;
        tsv)
            head "$FILE_PATH" | csvlook -t -I && exit 0
            exit 1;;
    esac
}

handle_mime() {
    local mimetype="${1}"

    case "${mimetype}" in
        # Text
        text/*)
            exit 2;;

        # Image
        image/*)
            if [[ "${PV_IMAGE_ENABLED}" == 'True' ]]; then
                exit 7
            fi
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;

        # Video and audio
        video/* | audio/*)
            mediainfo "${FILE_PATH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;
    esac
}

handle_fallback() {
    echo '----- File Type Classification -----' && file --dereference --brief -- "${FILE_PATH}" && exit 5
    exit 1
}


handle_extension
handle_mime "$(file --dereference --brief --mime-type -- "${FILE_PATH}")"
handle_fallback

exit 1
