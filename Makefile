SHELL=/bin/bash
ifndef ELASTIC_VERSION
ELASTIC_VERSION=5.3.0
endif
export ELASTIC_VERSION

BRANCH=`echo $$ELASTIC_VERSION | egrep --only-matching '^[0-9]+[.][0-9]+'`

TARGETS := elasticsearch logstash kibana beats

images: $(TARGETS)
push: $(TARGETS:%=%-push)
clean: $(TARGETS:%=%-clean)

$(TARGETS): $(TARGETS:%=%-checkout)
	(cd stack/$@ && make)

$(TARGETS:%=%-push): $(TARGETS:%=%-checkout)
	(cd stack/$(@:%-push=%) && make push)

$(TARGETS:%=%-checkout):
	test -d stack/$(@:%-checkout=%) || \
          git clone https://github.com/elastic/$(@:%-checkout=%)-docker.git stack/$(@:%-checkout=%)
	(cd stack/$(@:%-checkout=%) && git fetch && git reset --hard origin/$(BRANCH))

$(TARGETS:%=%-clean):
	rm -rf stack/$(@:%-clean=%)
