#!/bin/bash
#
# Copyright (C) 2018 The LineageOS Project
# Copyright (C) 2021 YAAP
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=modules
VENDOR=google

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}"

# Warning headers and guards
write_headers

write_makefiles "${MY_DIR}/proprietary-files.txt" true

sed -i 's/TARGET_DEVICE/TARGET_ARCH/g' "$ANDROIDMK"
sed -i 's/modules/arm64/g' "$ANDROIDMK"
sed -i 's/by device/by vendor/g' "$ANDROIDBP"

# Finish
write_footers
