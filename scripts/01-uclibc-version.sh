#!/bin/bash
# "Fuzzy" patch to get the desired uclibc version, after that the (real) patches and configs work fine.
UCLIBC_MK="buildroot/package/uclibc/uclibc.mk"
UCLIBC_HASH="buildroot/package/uclibc/uclibc.hash"
TARGET_VER="1.0.31"

set -e  # Exit on any error

if [[ ! -f "$UCLIBC_MK" ]]; then
  echo "  [uClibc] Error: $UCLIBC_MK not found." >&2
  exit 1
fi

if ! grep -q "UCLIBC_VERSION = $TARGET_VER" "$UCLIBC_MK"; then
  sed -i "s/^UCLIBC_VERSION = .*/UCLIBC_VERSION = $TARGET_VER/" "$UCLIBC_MK"
  echo "  [uClibc] Forced version to $TARGET_VER"
fi

if [[ ! -f "$UCLIBC_HASH" ]]; then
  echo "  [uClibc] Error: $UCLIBC_HASH not found." >&2
  exit 1
fi

SHA_URL="https://downloads.uclibc-ng.org/releases/$TARGET_VER/uClibc-ng-$TARGET_VER.tar.xz.sha256"
echo "  [uClibc] Downloading SHA256 from $SHA_URL"
FILE_SHA=
FILE_SHA="$(wget --timeout=5 --tries=3 -q -O- "$SHA_URL")"

if ! grep -q "$FILE_SHA$" "$UCLIBC_HASH"; then
  echo "sha256  $FILE_SHA" >> "$UCLIBC_HASH"
  echo "  [uClibc] Added SHA256 hash for version $TARGET_VER"
else
  echo "  [uClibc] SHA256 already present"
fi
