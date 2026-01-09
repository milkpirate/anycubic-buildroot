#!/bin/bash
# "Fuzzy" patch to get the desired uclibc version, after that the (real) patches and configs work fine.
UCLIBC_MK="buildroot/package/uclibc/uclibc.mk"
UCLIBC_HASH="buildroot/package/uclibc/uclibc.hash"
TARGET_VER="1.0.31"
SHA256="2215d7377118434d1697fd575f10d7a6be3f29e460d6b0e1ee9f6f5306288060"

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

if ! grep -q "$SHA256" "$UCLIBC_HASH"; then
  echo "sha256  $SHA256" >> "$UCLIBC_HASH"
  echo "  [uClibc] Added SHA256 hash for version $TARGET_VER"
else
  echo "  [uClibc] SHA256 already present"
fi
