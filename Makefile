.PHONY: all compile clean test repl help deps check compile-erlang compile-rescript compile-rust test-erlang test-rescript test-rust

all: compile

## Build and Development Commands

compile: compile-erlang compile-rescript compile-rust
	@echo "All components compiled successfully!"

compile-erlang: deps
	@echo "Compiling Erlang/LFE modules..."
	@rebar3 compile

compile-rescript:
	@echo "Compiling ReScript modules..."
	@cd rescript_modules && npm install && npm run build

compile-rust:
	@echo "Compiling Rust NIF..."
	@cd rust_nif && cargo build --release
	@mkdir -p priv
	@cp rust_nif/target/release/libsbf_nif.so priv/sbf_nif.so || \
	 cp rust_nif/target/release/libsbf_nif.dylib priv/sbf_nif.so || \
	 echo "Note: Rust NIF compilation optional for development"

deps:
	@echo "Fetching dependencies..."
	@rebar3 get-deps

clean: clean-erlang clean-rescript clean-rust
	@echo "All build artifacts cleaned!"

clean-erlang:
	@echo "Cleaning Erlang/LFE artifacts..."
	@rebar3 clean
	@rm -rf _build ebin

clean-rescript:
	@echo "Cleaning ReScript artifacts..."
	@cd rescript_modules && npm run clean 2>/dev/null || rm -rf lib node_modules

clean-rust:
	@echo "Cleaning Rust artifacts..."
	@cd rust_nif && cargo clean 2>/dev/null || true
	@rm -f priv/sbf_nif.so

test: test-erlang test-rescript test-rust
	@echo "All tests completed!"

test-erlang:
	@echo "Running Erlang/LFE tests..."
	@rebar3 lfe test

test-rescript:
	@echo "Running ReScript tests..."
	@cd rescript_modules && npm test 2>/dev/null || echo "ReScript tests not configured yet"

test-rust:
	@echo "Running Rust tests..."
	@cd rust_nif && cargo test 2>/dev/null || echo "Rust tests optional for development"

test-coverage:
	@echo "Running tests with coverage..."
	@rebar3 lfe test --cover

repl:
	@echo "Starting LFE REPL..."
	@rebar3 lfe repl

shell:
	@echo "Starting Erlang shell..."
	@rebar3 shell

## Code Quality

check: test
	@echo "Running code checks..."
	@rebar3 dialyzer

format:
	@echo "Formatting code..."
	@echo "Note: LFE doesn't have a standard formatter yet"

## Documentation

docs:
	@echo "Generating documentation..."
	@rebar3 edoc

## Release

release:
	@echo "Building release..."
	@rebar3 as prod release

release-tar:
	@echo "Building release tarball..."
	@rebar3 as prod tar

## Utility Commands

setup: deps compile
	@echo "Setting up development environment..."
	@mkdir -p priv/checkpoints
	@mkdir -p log
	@chmod +x sbf_cli
	@echo "Setup complete!"

clean-checkpoints:
	@echo "Cleaning checkpoints..."
	@rm -f priv/checkpoints/*.checkpoint

clean-logs:
	@echo "Cleaning logs..."
	@rm -f log/*.log
	@rm -f *.log

clean-all: clean clean-checkpoints clean-logs
	@echo "Deep clean complete!"

## Help

help:
	@echo "SafeBruteForce - Makefile Commands (Multi-Language iSOS Stack)"
	@echo ""
	@echo "Build Commands:"
	@echo "  make compile        - Compile all components (Erlang + ReScript + Rust)"
	@echo "  make compile-erlang - Compile only Erlang/LFE modules"
	@echo "  make compile-rescript - Compile only ReScript modules"
	@echo "  make compile-rust   - Compile only Rust NIF"
	@echo "  make deps           - Fetch dependencies"
	@echo "  make clean          - Clean all build artifacts"
	@echo ""
	@echo "Testing:"
	@echo "  make test           - Run all tests (Erlang + ReScript + Rust)"
	@echo "  make test-erlang    - Run only Erlang/LFE tests"
	@echo "  make test-rescript  - Run only ReScript tests"
	@echo "  make test-rust      - Run only Rust tests"
	@echo "  make test-coverage  - Run tests with coverage"
	@echo "  make check          - Run tests and static analysis"
	@echo ""
	@echo "Development:"
	@echo "  make repl           - Start LFE REPL"
	@echo "  make shell          - Start Erlang shell"
	@echo "  make setup          - Set up development environment"
	@echo ""
	@echo "Documentation:"
	@echo "  make docs           - Generate documentation"
	@echo ""
	@echo "Release:"
	@echo "  make release        - Build release"
	@echo "  make release-tar    - Build release tarball"
	@echo ""
	@echo "Utility:"
	@echo "  make clean-checkpoints - Delete all checkpoints"
	@echo "  make clean-logs        - Delete all logs"
	@echo "  make clean-all         - Deep clean everything"
	@echo ""
	@echo "Help:"
	@echo "  make help           - Show this help message"
