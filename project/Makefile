##
# Altera LED Test
#

PROJECT = project
TOP_LEVEL_ENTITY = TOP

FAMILY="Cyclone IV E"
PART=EP4CE6E22C8
CONFIG_DEVICE = EPCS16
SERIAL_FLASH_LOADER_DEVICE = EP4CE6
OPENOCD_CFG=../res/usbblaster.ocd
OPENOCD_SVF_CLOCK?=1MHz
OPENOCD_SVF_VOLT?=3.3

TOOLPATH=/opt/quartus/quartus/bin/

# Sources

BOARDFILE=src/pinout.board
SRCS = src/project.v

# Tool Configuration

MAP_ARGS = --read_settings_files=on --enable_register_retiming=on
FIT_ARGS = --part=$(PART) --read_settings_files=on --effort=standard --optimize_io_register_for_timing=on --one_fit_attempt=off --pack_register=auto
ASM_ARGS =
STA_ARGS =

include ../res/altera.mk
