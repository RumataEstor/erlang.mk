# Copyright (c) 2014, Juan Facorro <juan@inaka.net>
# This file is part of erlang.mk and subject to the terms of the ISC License.

.PHONY: elvis distclean-elvis

# Configuration.

ELVIS_CONFIG ?= $(CURDIR)/elvis.config

ELVIS ?= $(CURDIR)/elvis
export ELVIS

ELVIS_URL ?= https://github.com/inaka/elvis/releases/download/0.2.3/elvis
ELVIS_CONFIG_URL ?= https://github.com/inaka/elvis/releases/download/0.2.3/elvis.config
ELVIS_OPTS ?=

# Core targets.

help::
	@printf "%s\n" "" \
		"Elvis targets:" \
		"  elvis       Run Elvis using the local elvis.config or download the default otherwise"

ifneq ($(wildcard $(ELVIS_CONFIG)),)
rel:: distclean-elvis
endif

distclean:: distclean-elvis

# Plugin-specific targets.

$(ELVIS):
	@$(call core_http_get,$(ELVIS_CONFIG),$(ELVIS_CONFIG_URL))
	@$(call core_http_get,$(ELVIS),$(ELVIS_URL))
	@chmod +x $(ELVIS)

elvis: $(ELVIS)
	@$(ELVIS) rock -c $(ELVIS_CONFIG) $(ELVIS_OPTS)

distclean-elvis:
	$(gen_verbose) rm -rf $(ELVIS)
