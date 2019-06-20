DECKSCHRUBBER_TAG := v0.6.0

.PHONY: build_%
build_%:
	docker build --build-arg DIST=$* -t deckschrubber-build .

.PHONY: package_%
package_%: build_%
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
