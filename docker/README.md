# Docker Testing Environment

This Docker environment allows you to test dotfiles setup scripts in a clean Ubuntu environment.

## Available Services

### `dev-test`

Mounts local dotfiles into the container for testing. Allows immediate testing of script modifications during development.

### `github-install`

Tests using the published `install.sh` from GitHub, simulating actual production environment conditions.

## Usage

### Basic Usage

```bash
# Navigate to docker directory
cd docker/

# Test development environment
docker-compose build --no-cache dev-test
docker-compose run --rm dev-test

# Test GitHub version
docker-compose build --no-cache github-install
docker-compose run --rm github-install

# Run specific commands
docker-compose run --rm dev-test bash -c "which sheldon && sheldon --version"
```

### Development Workflow

1. **Modify scripts**
2. **Development test**: `docker-compose build --no-cache dev-test`
3. **Verify operation**: `docker-compose run --rm dev-test bash`
4. **Commit and push changes**
5. **GitHub version test**: `docker-compose build --no-cache github-install`

## Test Coverage

### Setup Scripts

- apt package installation
- Rust & Cargo setup
- sheldon compilation and installation
- git-delta installation
- Deno setup
- uv setup
- zsh configuration symlink creation

### Environment Verification

```bash
# Recommended: Complete environment test (loads .zshrc first)
docker-compose run --rm dev-test zsh -c "
  source ~/.config/zsh/.zshrc &&
  echo '=== Installed Tools ===' &&
  echo 'Sheldon:' && sheldon --version &&
  echo 'Delta:' && delta --version &&
  echo 'Deno:' && deno --version | head -1 &&
  echo 'uv:' && uv --version
"

# Alternative: Direct path testing
docker-compose run --rm dev-test bash -c "
  echo 'Checking installed tools:';
  which zsh && echo 'zsh: OK';
  ~/.local/share/cargo/bin/sheldon --version && echo 'sheldon: OK';
  ~/.local/share/cargo/bin/delta --version && echo 'delta: OK';
  ~/.local/share/deno/bin/deno --version && echo 'deno: OK';
  ~/.local/bin/uv --version && echo 'uv: OK';
"
```

## Troubleshooting

### PATH Issues

Docker environment may not fully initialize zsh:

```bash
# Manually set PATH for testing
docker-compose run --rm dev-test bash -c "
  export PATH=\"\$HOME/.local/bin:\$HOME/.local/share/cargo/bin:\$HOME/.local/share/deno/bin:\$PATH\";
  which sheldon && which delta && which deno && which uv
"
```

### Testing zsh Configuration

```bash
# Manually source .zshrc
docker-compose run --rm dev-test zsh -c "source ~/.config/zsh/.zshrc && which sheldon"
```

## File Structure

```
docker/
├── Dockerfile.dev       # Development/local testing
├── Dockerfile.ubuntu    # GitHub install.sh testing
├── docker-compose.yml   # Service definitions
└── README.md           # This file
```
