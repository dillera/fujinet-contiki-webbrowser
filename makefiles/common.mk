###################################################################
# Common across Platforms
###################################################################
ifeq ($(DEBUG),true)
    $(info >>>Starting common.mk)
endif


CFLAGS += -D AUTOSTART_ENABLE -W -unused-param
LDFLAGS += -Wl -D,__HIMEM__=0xBF00


-include $(FUJINET_BUILD_TOOLS_DIR)/makefiles/fujinet-lib.mk

VERSION_FILE := src/version.txt
ifeq (,$(wildcard $(VERSION_FILE)))
	VERSION_FILE =
	ERSION_STRING =
else
	VERSION_STRING := $(file < $(VERSION_FILE))
endif

CFLAGS += -Osir
