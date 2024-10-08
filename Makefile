# Sample Makefile
#
# Copy this Makefile to your local project and edit as needed. It works with cc65 and this repo to create clean
# easy builds that will pull down fujinet-lib for you automatically...
#
# Set the TARGETS and PROGRAM values as required.
# Set the FujinetLib version you want to include.
# See makefiles/build.mk for details on directory structure for src files and how to add custom extensions to the build.
#
# delete all comments above this when you use this as your Makefile

TARGETS := atari apple2 apple2enh c64
#TARGETS := atari apple2 apple2enh c64 c128

PROGRAM := contiki


# Set DEBUG to true or false
DEBUG := false
export DEBUG


# where your disk building tools are
# this is just for building the PO Apple2 disks - repoint if you have ac elsewhere
export FUJINET_BUILD_TOOLS_DIR := ../fujinet-build-tools

export FUJINET_LIB_VERSION := 4.5.2

ifeq ($(wildcard $(FUJINET_BUILD_TOOLS_DIR)),)
$(error You should have FUJINET_BUILD_TOOLS_DIR set to the location of fujinet-build-tools repo)
endif

SUB_TASKS := clean disk test release
.PHONY: all help $(SUB_TASKS)

all:
	@for target in $(TARGETS); do \
		echo "--------------------------------------------------"; \
		echo "Building target: $$target for program: $(PROGRAM)"; \
		echo "--------------------------------------------------"; \
		$(MAKE)  -f ./makefiles/build.mk CURRENT_TARGET=$$target PROGRAM=$(PROGRAM) $(MAKECMDGOALS); \
	done

# if disk images were built show them
	@if [ -d ./dist ]; then \
		echo "Contents of dist:"; \
		ls -1 ./dist; \
	fi

$(SUB_TASKS): _do_all
$(SUB_TASKS):
	@:

_do_all: all

help:
	@echo "Makefile for $(PROGRAM)"
	@echo ""
	@echo "Available tasks:"
	@echo "all       - do all compilation tasks, create app in build directory"
	@echo "clean     - remove all build artifacts"
	@echo "release   - create a release of the executable in the build/ dir"
	@echo "disk      - generate platform specific disk images in dist/ dir"
	@echo "test      - run application in emulator for given platform."
	@echo "            specific platforms may expose additional variables to run with"
	@echo "            different emulators, see makefiles/custom-<platform>.mk"
	