SITE_DIR := /Volumes/CARD/blogs/alevis.github.io
NEW_POST := /Volumes/CARD/blogs/scripts/new_post.py

.PHONY: dev down build clean new-post

dev:
	docker compose up serene -d

down:
	docker compose down

build:
	docker run --rm -v $(SITE_DIR):/site -w /site ghcr.io/getzola/zola:v0.22.1 build

clean:
	rm -rf $(SITE_DIR)/public

new-post:
	@if [ -z "$(TITLE)" ]; then \
		echo 'Usage: make new-post TITLE="Post Title" DESC="Short summary" CATEGORIES="Notes" TAGS="zola,writing"'; \
		exit 1; \
	fi
	python3 $(NEW_POST) "$(TITLE)" --description "$(DESC)" --categories "$(CATEGORIES)" --tags "$(TAGS)"
