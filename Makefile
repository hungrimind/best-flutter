# Variables
FLUTTER_VERSION := 3.27.3
SOLUTION_DIRS := $(shell find . -type d -name "*solution*" -exec test -f '{}/pubspec.yaml' \; -print)

# Local development commands
.PHONY: get-all
get-all:
	@for d in $(SOLUTION_DIRS); do \
		echo "=== Getting dependencies for $$d ==="; \
		cd $$d && flutter pub get && cd -; \
	done

.PHONY: test-all
test-all:
	@for d in $(SOLUTION_DIRS); do \
		echo "=== Testing $$d ==="; \
		cd $$d && flutter test --exclude-tags=golden && cd -; \
	done

.PHONY: format
format:
	@for d in $(SOLUTION_DIRS); do \
		echo "=== Formatting $$d ==="; \
		cd $$d && dart format lib test && cd -; \
	done

.PHONY: format-check
format-check:
	@for d in $(SOLUTION_DIRS); do \
		echo "=== Checking format for $$d ==="; \
		cd $$d && dart format $$(find lib -name "*.dart" -not \( -name "*.*freezed.dart" -o -name "*.*g.dart" \) ) --set-exit-if-changed && cd -; \
	done

.PHONY: analyze-all
analyze-all:
	@for d in $(SOLUTION_DIRS); do \
		echo "=== Analyzing $$d ==="; \
		cd $$d && dart analyze . --fatal-infos && cd -; \
	done

# Add new command for building web
.PHONY: build-web-all
build-web-all:
	@for d in $(SOLUTION_DIRS); do \
		echo "=== Building web for $$d ==="; \
		cd $$d && flutter build web && cd -; \
	done

# CI commands
.PHONY: ci-lint
ci-lint: get-all analyze-all format-check

.PHONY: ci-test
ci-test: get-all test-all

.PHONY: ci-build
ci-build: get-all build-web-all

# Run all checks (useful for pre-commit)
.PHONY: check-all
check-all: get-all format analyze-all test-all

# Help command
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make get-all      - Get dependencies for all solution projects"
	@echo "  make test-all     - Run tests for all solution projects"
	@echo "  make format       - Format code in all solution projects"
	@echo "  make format-check - Check if code is properly formatted (used in CI)"
	@echo "  make analyze-all  - Analyze code in all solution projects"
	@echo "  make build-web-all - Build web for all solution projects"
	@echo "  make ci-lint      - Run all lint-related checks (used in CI)"
	@echo "  make ci-test      - Run all tests (used in CI)"
	@echo "  make ci-build     - Build web for all projects (used in CI)"
	@echo "  make check-all    - Run all checks locally"
	@echo "  make help         - Show this help message"