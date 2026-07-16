TARGET = caballo
TOP = caballo

DEVICE = 25k
PACKAGE = CABGA381

LPF = caballo.lpf

OBJS = caballo.v es_valido.v mc.v pos_mov.v reg_jugadas.v reg_tablero.v regc.v regf.v

BUILD_DIR = build

all: bit

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

#################################################
# Simulación
#################################################

sim:
	rm -f a.out *.vcd
	iverilog -DBENCH -DSIM $(TARGET)_TB.v $(OBJS)
	vvp a.out
	gtkwave $(TARGET)_TB.vcd

#################################################
# Síntesis
#################################################

$(BUILD_DIR)/$(TARGET).json: $(OBJS) | $(BUILD_DIR)
	yosys -p "synth_ecp5 -top $(TOP) -json $@" $(OBJS)

#################################################
# Place & Route
#################################################

$(BUILD_DIR)/$(TARGET).config: $(BUILD_DIR)/$(TARGET).json $(LPF)
	nextpnr-ecp5 \
		--$(DEVICE) \
		--package $(PACKAGE) \
		--lpf $(LPF) \
		--json $< \
		--textcfg $@

#################################################
# Bitstream
#################################################

$(BUILD_DIR)/$(TARGET).bit: $(BUILD_DIR)/$(TARGET).config
	ecppack $< $@

bit: $(BUILD_DIR)/$(TARGET).bit

#################################################
# Programar FPGA
#################################################

prog: $(BUILD_DIR)/$(TARGET).bit
	openFPGALoader $<

#################################################
# Limpiar
#################################################

clean:
	rm -rf build
	rm -f *.vcd *.out