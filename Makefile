APP_FILES=$(shell find app -type f)
LUVI_BIN=luvi-binaries/$(shell uname -s)_$(shell uname -m)/luvi

lit: $(LUVI_BIN) $(APP_FILES)
	LUVI_APP=app LUVI_TARGET=$@ $(LUVI_BIN)

$(LUVI_BIN):
	git submodule init
	git submodule update --depth 10

test: lit
	tests/run.sh

clean:
	rm -rf lit test-offline test-pull test-push test-server

install: lit
	install lit /usr/local/bin

uninstall:
	rm -f /usr/local/bin/lit

lint:
	luacheck $(APP_FILES)