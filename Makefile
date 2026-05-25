# Makefile — Cotechnoe Cloud Hub Documentation

SHELL := /bin/bash
.DEFAULT_GOAL := help

WIKI_DIR   := wiki
DOCS_DIR   := docs
FR_SUFFIX  := -fr

##@ Help

.PHONY: help
help: ## Show this help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Quality

.PHONY: lint
lint: ## Lint Markdown files (requires markdownlint-cli)
	@command -v markdownlint >/dev/null 2>&1 || { echo "markdownlint-cli not found. Run: npm install -g markdownlint-cli"; exit 1; }
	markdownlint '**/*.md' --ignore node_modules

.PHONY: check-links
check-links: ## Check for broken links in Markdown files (requires markdown-link-check)
	@command -v markdown-link-check >/dev/null 2>&1 || { echo "markdown-link-check not found. Run: npm install -g markdown-link-check"; exit 1; }
	find . -name '*.md' -not -path './node_modules/*' | xargs -I{} markdown-link-check {}

##@ Preview

.PHONY: preview
preview: ## Serve docs locally (requires grip or mdbook)
	@if command -v grip >/dev/null 2>&1; then \
		echo "Starting Grip preview at http://localhost:6419 ..."; \
		grip README.md 6419; \
	else \
		echo "grip not found. Run: pip install grip"; \
		exit 1; \
	fi

##@ Translation

.PHONY: sync-fr
sync-fr: ## List EN wiki pages that have no FR counterpart
	@echo "Checking for missing French translations in $(WIKI_DIR)/..."
	@missing=0; \
	for f in $(WIKI_DIR)/*.md; do \
		base=$$(basename "$$f" .md); \
		if [[ "$$base" != *"-fr" ]]; then \
			fr_file="$(WIKI_DIR)/$${base}$(FR_SUFFIX).md"; \
			if [ ! -f "$$fr_file" ]; then \
				echo "  MISSING: $$fr_file"; \
				missing=$$((missing+1)); \
			fi; \
		fi; \
	done; \
	for f in $(DOCS_DIR)/*.md; do \
		base=$$(basename "$$f" .md); \
		if [[ "$$base" != *"-fr" ]]; then \
			fr_file="$(DOCS_DIR)/$${base}$(FR_SUFFIX).md"; \
			if [ ! -f "$$fr_file" ]; then \
				echo "  MISSING: $$fr_file"; \
				missing=$$((missing+1)); \
			fi; \
		fi; \
	done; \
	if [ "$$missing" -eq 0 ]; then \
		echo "All English pages have a French counterpart."; \
	else \
		echo "$$missing missing French translation(s) found."; \
	fi

##@ CI

.PHONY: ci
ci: lint check-links ## Run all CI checks (lint + check-links)
