CCS_TOOLS_DIR := ccs-tools
CCS_YAML_TO_BIN := $(CCS_TOOLS_DIR)/ccs-yaml-to-bin
SENSOR_DIR := sensors
OUT_DIR := output

SENSORS := $(wildcard $(SENSOR_DIR)/*.yaml)
BINS := $(patsubst $(SENSOR_DIR)/%.yaml,$(OUT_DIR)/%.bin,$(SENSORS))

.PHONY: all clean

all: $(BINS)

$(CCS_TOOLS_DIR):
	git submodule update

$(OUT_DIR):
	mkdir -p $@

$(OUT_DIR)/%.bin: $(SENSOR_DIR)/%.yaml | $(OUT_DIR) $(CCS_TOOLS_DIR)
	cd $(CCS_TOOLS_DIR) && ./ccs-yaml-to-bin -s -o ../$(OUT_DIR)/$*.bin ../$(SENSOR_DIR)/$*.yaml

clean:
	rm -rf $(OUT_DIR)
