#
# Copyright 2015 Stephen Street <stephen@redrocketcomputing.com>
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/. 
#

export PROJECT_ROOT ?= ${CURDIR}
export OUTPUT_ROOT ?= ${PROJECT_ROOT}/build
export BUILD_TYPE ?= release
export CROSS_COMPILE ?= arm-none-eabi-
export CORTEX_M ?= 3

include ${PROJECT_ROOT}/tools/makefiles/tree.mk

targets: backtrace samples

distclean:
	@echo "DISTCLEAN ${PROJECT_ROOT}"
	$(Q)-${RM} -r ${OUTPUT_ROOT}
