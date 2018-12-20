DECKSCHRUBBER_TAG := v0.6.0
DIST_TAG := stable

.PHONY: build-image
build-image:
	docker build -t deckschrubber-build .

.PHONY: clean build-package
build-package: clean build-image
	mkdir -p deckschrubber/target
	docker run -e "DECKSCHRUBBER_TAG=${DECKSCHRUBBER_TAG}" \
        -e "DIST_TAG=${DIST_TAG}" \
		--user $(shell id -u ${USER}):$(shell id -g ${USER}) \
		-v $(CURDIR)/deckschrubber:/mnt:rw \
		deckschrubber-build

.PHONY: clean
clean:
	rm -rf deckschrubber
