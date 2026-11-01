# glaze-os.com and the Glaze App Store.
#
#   make store      out/store: catalog and immutable assets for every app
#   make test       release and publisher checks (offline)
#
# Packages come from the built sibling checkouts; the catalog generator is
# glaze-os's tools/mkstore.py, whose format the device's App Store reads.
GLAZE_DIR ?= ../glaze-os
APPS_DIR ?= ../glaze-apps
EMU_DIR ?= ../glaze-emulators
PYTHON ?= python3
export GLAZE_DIR

.PHONY: store test clean
store:
	$(PYTHON) $(GLAZE_DIR)/tools/mkstore.py --metadata store/apps.json \
	    --packages $(GLAZE_DIR)/out/pkg --packages $(APPS_DIR)/out/pkg --packages $(EMU_DIR)/out/pkg \
	    --output out/store

test: store
	$(PYTHON) tests/site_release.py
	$(PYTHON) tests/store_publisher.py

clean:
	rm -rf out
