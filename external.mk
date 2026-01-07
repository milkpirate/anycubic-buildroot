# This automatically includes any .mk files in your external package dir
include $(sort $(wildcard $(BR2_EXTERNAL_ANYCUBIC_KOBRA_PATH)/packages/*/*.mk))

# Special logic only for the Kobra RV1106
ifeq ($(BR2_DEFCONFIG),$(BR2_EXTERNAL_ANYCUBIC_KOBRA_PATH)/configs/anycubic_kobra_rv1106_defconfig)
	include $(sort $(wildcard $(BR2_EXTERNAL_ANYCUBIC_KOBRA_PATH)/board/kobra_rv1106/anycubic/packages/*/*.mk))
endif
