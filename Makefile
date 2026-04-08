# Convenience Makefile wrapper for CMake build
# Delegates common commands to the build directory

.PHONY: all mini full configure clean distclean help

# Default target
all: mini full

# Configure CMake (creates build directory)
configure:
	@echo "Configuring CMake..."
	cmake -B build -DCMAKE_BUILD_TYPE=Release

# Build mini 800K image
mini: configure
	@echo "Building A2osX mini image..."
	cmake --build build --target mini -j8

# Build full 800K image
full: configure
	@echo "Building A2osX full image..."
	cmake --build build --target full -j8

# Clean build artifacts and /tmp assembly files
clean:
	@echo "Cleaning build artifacts..."
	@if [ -d build ]; then $(MAKE) -C build clean; fi
	@echo "Cleaning /tmp assembly artifacts..."
	cmake --build build --target clean_tmp 2>/dev/null || \
	    sh -c "rm -f /tmp/a2osx.lst /tmp/a2osx.sym /tmp/a2osx.sym2 /tmp/a2osx.sym3 && rm -rf /tmp/a2osx-build"

# Full clean (removes build directory and /tmp artifacts)
distclean:
	@echo "Cleaning /tmp assembly artifacts..."
	sh -c "rm -f /tmp/a2osx.lst /tmp/a2osx.sym /tmp/a2osx.sym2 /tmp/a2osx.sym3 && rm -rf /tmp/a2osx-build"
	@echo "Removing build directory..."
	rm -rf build

# Show available targets
help:
	@echo "A2osX Makefile targets:"
	@echo "  make           - Build both mini and full images (default)"
	@echo "  make mini      - Build mini 800K image"
	@echo "  make full      - Build full 800K image"
	@echo "  make configure - Run CMake configuration"
	@echo "  make clean     - Clean build artifacts and /tmp files"
	@echo "  make distclean - Remove build directory and /tmp files"
	@echo "  make help      - Show this help"
	@echo ""
	@echo "Output images:"
	@echo "  build/a2osx-mini.po  - Mini 800K ProDOS image"
	@echo "  build/a2osx-full.po  - Full 800K ProDOS image"
