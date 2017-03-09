NAME = alex/snmp_exporter_generator
VERSION = latest

directory = ./snmp_exporter

all: build | $(directory)
	@echo "Continuation regardless"
	cd $(directory) && git pull
$(directory):
	@echo "Folder $(directory) does not exist"
	@git clone https://github.com/prometheus/snmp_exporter.git

build: $(directory)
	docker build -t $(NAME):$(VERSION) --rm .

.PHONY: all build
