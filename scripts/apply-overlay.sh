#!/usr/bin/env bash
set -euo pipefail
SRC=${1:?source tree path required}
OVERLAY=${2:?overlay path required}
for rel in device/xiaomi/shennong vendor/xiaomi/shennong hardware/xiaomi kernel/xiaomi/sm8650 bootable/recovery external/lptools external/se_omapi; do
  if [[ -d "$OVERLAY/$rel" ]]; then
    mkdir -p "$SRC/$rel"
    rsync -a "$OVERLAY/$rel/" "$SRC/$rel/"
  fi
done
DEVICE_MK="$SRC/device/xiaomi/shennong/device.mk"
if [[ -f "$DEVICE_MK" ]]; then
  sed -i '\#packages/modules/Virtualization/apex/product_packages.mk#s/^/# Recovery-only: /' "$DEVICE_MK"
fi
