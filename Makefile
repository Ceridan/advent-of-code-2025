##############################################################################
# Set up
##############################################################################
.PHONY: install
install: deps direnv

.PHONY: deps
deps: # Install dependencies
	dart pub get

.PHONY: direnv
direnv: # Set environment varaibales
	direnv allow .

##############################################################################
# Development
##############################################################################
.PHONY: format
format: # Format code
	@dart format src/**/*.dart

.PHONY: lint
lint: # Static code analysis
	@dart fix --dry-run

.PHONY: fix
fix: # Static code analysis
	@dart fix --apply

.PHONY: run
run: # Run day XX
	@dart run src/$(day)/day$(day).dart

.PHONY: test
test: # Run tests in day XX
	@dart test src/$(day)/day$(day)_test.dart

.PHONY: testall
testall: # Run all tests
	@dart test src/**/*_test.dart

.PHONY: gen
gen: # Generate next day
	@dart run src/gen.dart $(day)

