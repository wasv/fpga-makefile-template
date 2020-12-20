all: flash

flash: flashloader-ocd
	$(MAKE) -C project ocd_flash

flashloader-%:
	$(MAKE) -C flashloader $(*)

project-%:
	$(MAKE) -C project $(*)

clean:
	git clean -fdX

.PHONY: all flash clean flashloader-% project-%
