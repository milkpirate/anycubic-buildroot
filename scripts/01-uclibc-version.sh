#!/bin/bash
UCLIBC_MK="buildroot/package/uclibc/uclibc.mk"
UCLIBC_HASH="buildroot/package/uclibc/uclibc.hash"
TARGET_VER="1.0.31"

if [[ ! -f "$UCLIBC_MK" ]]; then
  echo "  [uClibc] Error: $UCLIBC_MK not found."
  exit 1
fi

if ! grep -q "UCLIBC_VERSION = $TARGET_VER" "$UCLIBC_MK"; then
  sed -i "s/^UCLIBC_VERSION = .*/UCLIBC_VERSION = $TARGET_VER/" "$UCLIBC_MK"
  echo "  [uClibc] Forced version to $TARGET_VER"
fi

if [[ ! -f "$UCLIBC_HASH" ]]; then
  echo "  [uClibc] Error: $UCLIBC_HASH not found."
  exit 1
fi

SHA256=$(curl --silent --connect-timeout 5 https://downloads.uclibc-ng.org/releases/1.0.31/uClibc-ng-1.0.31.tar.xz.sha256 | cut -f1 -d' ')

if ! grep -q "$SHA256" "$UCLIBC_HASH"; then
  echo "sha256  $SHA256  uClibc-ng-$TARGET_VER.tar.xz" >> "$UCLIBC_HASH"
  echo "  [uClibc] Added SHA256 hash for version $TARGET_VER"
fi
