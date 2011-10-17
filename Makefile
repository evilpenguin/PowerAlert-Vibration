export THEOS_DEVICE_IP = localhost
export THEOS_DEVICE_PORT = 2222

include theos/makefiles/common.mk
TWEAK_NAME = PowerAlertVibration
PowerAlertVibration_FILES = Tweak.xm
PowerAlertVibration_FRAMEWORKS = AudioToolbox
include $(THEOS_MAKE_PATH)/tweak.mk
