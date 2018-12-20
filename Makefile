DECKSCHRUBBER_TAG := v0.6.0

.PHONY: build-image
build-image:
	docker build -t deckschrubber-build .

.PHONY: clean build-package
build-package: clean build-image
	mkdir build
	docker run -e "DECKSCHRUBBER_TAG=${DECKSCHRUBBER_TAG}" \
		--user $(shell id -u ${USER}):$(shell id -g ${USER}) \
		-v $(CURDIR)/build:/mnt:rw \
		deckschrubber-build

.PHONY: clean
clean:
	rm -rf build
