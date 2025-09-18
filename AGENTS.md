# Steel Agent Guidelines

## Build/Test Commands

- **Build**: `flint build <MANIFEST_PATH> test`

## Package standards

All packages MUST be built with MUSL and runnable on any machine with the same architecture.
All packages SHOULD be as secure and optimized as possible.

## Code Style Guidelines

### Shell Scripts

- Use `set -e` for error handling
- Use `#!/bin/bash` shebang
- Environment variables: `CPPFLAGS`, `LDFLAGS`, `CC=musl-gcc`
- Directory structure: `mkdir -p out` before installation
- Static builds preferred: `--enable-static` or `--static`

### YAML Package Definitions

- Use `edition: 2025` for current packages
- Include metadata: title, description, license, version, homepage_url
- Specify `commands: [binary_names]` for executable packages
- Use `build_script: script.sh` to reference build scripts
- Include dependencies with `include:` for required packages, and `sdks:` for build dependencies

### Naming Conventions

- Package IDs: lowercase with hyphens (e.g., `du-dust`, `linux-headers`)
- Scripts: Match package name with `.sh` extension
- Directories: Use `out` for build output

### Error Handling

- Use `set -e` in scripts to fail on first error
- Check for required tools before building
- Validate build outputs exist before completion
