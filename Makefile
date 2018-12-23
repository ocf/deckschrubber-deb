DECKSCHRUBBER_TAG := v0.6.0

.PHONY: build-image
build-image:
	docker build -t deckschrubber-build .

.PHONY: package_%
package_%: build-image
	mkdir -p "dist_$*"
	docker run -e "DECKSCHRUBBER_TAG=${DECKSCHRUBBER_TAG}" \
		-e "DIST_TAG=$*" \
		--user $(shell id -u ${USER}):$(shell id -g ${USER}) \
		-v $(CURDIR)/dist_$*:/mnt:rw \
		deckschrubber-build

.PHONY: clean
clean:
	rm -rf dist_*

.PHONY: test
test: ;
