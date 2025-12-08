.PHONY: all compile clean test repl help deps check

all: compile

## Build and Development Commands

compile: deps
	@echo "Compiling SafeBruteForce..."
	@rebar3 compile

deps:
	@echo "Fetching dependencies..."
	@rebar3 get-deps

clean:
	@echo "Cleaning build artifacts..."
	@rebar3 clean
	@rm -rf _build ebin

test:
	@echo "Running tests..."
	@rebar3 lfe test

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
	@echo "SafeBruteForce - Makefile Commands"
	@echo ""
	@echo "Build Commands:"
	@echo "  make compile        - Compile the project"
	@echo "  make deps           - Fetch dependencies"
	@echo "  make clean          - Clean build artifacts"
	@echo ""
	@echo "Testing:"
	@echo "  make test           - Run all tests"
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
