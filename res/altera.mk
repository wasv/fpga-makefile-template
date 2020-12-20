# Top Level Rules
all: svf

svf: $(PROJECT).svf
svf_flash: $(PROJECT).perm.svf

asm: $(PROJECT).asm.rpt
sta: $(PROJECT).sta.rpt
fit: $(PROJECT).fit.rpt
map: $(PROJECT).map.rpt

ocd: $(PROJECT).svf
ocd_flash: $(PROJECT).perm.svf

ocd ocd_flash:
	openocd --file=$(OPENOCD_CFG) -c 'svf -tap $$CHIPNAME.tap $(<)' -c exit

pgm: $(PROJECT).sof
	$(TOOLPATH)quartus_pgm --no_banner --mode=jtag -o "P;$(PROJECT).sof"

# Build rules
%.perm.svf: %.jic
	$(TOOLPATH)quartus_cpf -c -q $(OPENOCD_SVF_CLOCK) -g $(OPENOCD_SVF_VOLT) -n p $< $@

%.svf: %.sof
	$(TOOLPATH)quartus_cpf -c -q $(OPENOCD_SVF_CLOCK) -g $(OPENOCD_SVF_VOLT) -n p $< $@

%.jic: %.sof
	$(TOOLPATH)quartus_cpf -c -d $(CONFIG_DEVICE) -s $(SERIAL_FLASH_LOADER_DEVICE) $< $@

%.sof %.asm.rpt: %.fit.rpt asm.chg
	$(TOOLPATH)quartus_asm $(ASM_ARGS) $*

%.sta.rpt: %.fit.rpt sta.chg
	$(TOOLPATH)quartus_sta $(STA_ARGS) $*

%.fit.rpt: %.map.rpt fit.chg
	$(TOOLPATH)quartus_fit $(FIT_ARGS) $*

%.map.rpt: $(SRCS) %.qpf map.chg
	$(TOOLPATH)quartus_map $(MAP_ARGS) $(addprefix --source=,$(SRCS)) $*

%.qpf: $(BOARDFILE)
	$(TOOLPATH)quartus_sh --prepare -f $(FAMILY) -t $(TOP_LEVEL_ENTITY) $*
	echo >> $*.qsf
	cat $(BOARDFILE) >> $*.qsf
	$(TOOLPATH)quartus_sh --determine_smart_action $*

map.chg:
	touch map.chg
fit.chg:
	touch fit.chg
sta.chg:
	touch sta.chg
asm.chg:
	touch asm.chg

.SECONDARY:
.PHONY: all svf svf_flash map fit asm sta ocd ocd_flash pgm
