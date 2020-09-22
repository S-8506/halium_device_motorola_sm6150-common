#
# Copyright (C) 2017, 2020 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

PLATFORM_PATH := device/motorola/sm6150-common

BOARD_VENDOR := motorola

# Platform
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a9

BOARD_USES_QCOM_HARDWARE := true
TARGET_BOOTLOADER_BOARD_NAME := sm6150
TARGET_BOARD_PLATFORM := sm6150

TARGET_USES_64_BIT_BINDER := true

BUILD_BROKEN_DUP_RULES := true

# APEX image
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Audio
AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT := true
BOARD_SUPPORTS_SOUND_TRIGGER := true
BOARD_USES_ALSA_AUDIO := true
USE_XML_AUDIO_POLICY_CONF := 1
USE_CUSTOM_AUDIO_POLICY := 1

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(PLATFORM_PATH)/bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
QCOM_BT_USE_BTNV := true

# Boot Animtion
TARGET_BOOTANIMATION_HALF_RES := true

# Camera
USE_CAMERA_STUB := true
TARGET_USES_QTI_CAMERA_DEVICE := true

# Charger
BOARD_CHARGER_ENABLE_SUSPEND := true

# Display
MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so
TARGET_USES_ION := true
TARGET_USES_HWC2 := true
TARGET_USES_GRALLOC1 := true

# DRM
TARGET_ENABLE_MEDIADRM_64 := true

# Enable dexpreopt to speed boot time
ifeq ($(HOST_OS),linux)
    ifneq ($(TARGET_BUILD_VARIANT),eng)
        ifeq ($(WITH_DEXPREOPT),)
            WITH_DEXPREOPT := true
        endif
    endif
endif

# GPS
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := default
GNSS_HIDL_VERSION := 2.0
USE_DEVICE_SPECIFIC_GPS := true

# HIDL
DEVICE_MANIFEST_FILE := $(PLATFORM_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(PLATFORM_PATH)/compatibility_matrix.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := $(PLATFORM_PATH)/framework_manifest.xml
TARGET_FS_CONFIG_GEN += \
    $(PLATFORM_PATH)/config.fs \
    $(PLATFORM_PATH)/mot_aids.fs

ODM_MANIFEST_SKUS += \
	365 \
	366

ODM_MANIFEST_365_FILES := $(PLATFORM_PATH)/manifest_sdmmagpie.xml
ODM_MANIFEST_366_FILES := $(PLATFORM_PATH)/manifest_sdmmagpie.xml

# Init
TARGET_INIT_VENDOR_LIB := //$(PLATFORM_PATH):libinit_sm6150
TARGET_RECOVERY_DEVICE_MODULES := libinit_sm6150

# Kernel
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0x880000 androidboot.hardware=qcom androidboot.console=ttyMSM0 lpm_levels.sleep_disabled=1 androidboot.usbcontroller=a600000.dwc3 loop.max_part=7 cgroup.memory=nokmem,nosocket service_locator.enable=1
#BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_SOURCE := kernel/motorola/sm6150

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_FLASH_BLOCK_SIZE := 0x40000
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SUPER_PARTITION_SIZE := 9730785280
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 4861198336
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system product vendor
else
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true
endif

TARGET_EXFAT_DRIVER := exfat
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USES_MKE2FS := true

TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product

# RIL
ENABLE_VENDOR_RIL_SERVICE := true
TARGET_PROVIDES_QTI_TELEPHONY_JAR := true
TARGET_USES_PRE_UPLINK_FEATURES_NETMGRD := true

# Root
BOARD_ROOT_EXTRA_SYMLINKS := \
    /mnt/vendor/persist:/persist

# Vendor Security Patch Level
VENDOR_SECURITY_PATCH := 2019-11-01

# SELinux
TARGET_SEPOLICY_DIR := msmsteppe
include device/qcom/sepolicy/sepolicy.mk
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += $(PLATFORM_PATH)/sepolicy/private
BOARD_PLAT_PUBLIC_SEPOLICY_DIR += $(PLATFORM_PATH)/sepolicy/public
BOARD_SEPOLICY_DIRS += $(PLATFORM_PATH)/sepolicy/vendor

# Treble
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
BOARD_VNDK_VERSION := current
PRODUCT_FULL_TREBLE_OVERRIDE := true

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2
ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
BOARD_AVB_VBMETA_SYSTEM := system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1
endif

# Wifi
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_qcwcn
BOARD_WLAN_DEVICE := qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
WIFI_DRIVER_DEFAULT := qca_cld3
WIFI_DRIVER_STATE_CTRL_PARAM := "/dev/wlan"
WIFI_DRIVER_STATE_OFF := "OFF"
WIFI_DRIVER_STATE_ON := "ON"
WIFI_HIDL_FEATURE_AWARE := true
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WPA_SUPPLICANT_VERSION := VER_0_8_X
