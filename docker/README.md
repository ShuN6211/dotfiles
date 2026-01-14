# Docker Testing Environment

This Docker environment allows you to test dotfiles setup scripts in a clean Ubuntu environment.

## Available Services

### `dev-test`

Copies local dotfiles into the container and runs setup.bash during build. Allows testing of current development scripts in a clean Ubuntu environment.

### `github-install`

Tests using the published `install.sh` from GitHub, simulating actual production environment conditions.

## Usage

### Basic Usage

```bash
# Navigate to docker directory
cd docker/

# Build and test development environment
docker-compose build --no-cache dev-test
docker-compose run --rm -it dev-test  # Interactive shell

# Build and test GitHub version
docker-compose build --no-cache github-install
docker-compose run --rm -it github-install  # Interactive shell

# Quick verification
docker-compose run --rm dev-test -c "sheldon --version && delta --version"
```

### Development Workflow

1. **Modify scripts**
2. **Development test**: `docker-compose build --no-cache dev-test`
3. **Verify operation**: `docker-compose run --rm dev-test bash`
4. **Commit and push changes**
5. **GitHub version test**: `docker-compose build --no-cache github-install`

## File Structure

```
docker/
├── Dockerfile.dev       # Development/local testing
├── Dockerfile.ubuntu    # GitHub install.sh testing
├── docker-compose.yml   # Service definitions
└── README.md           # This file
```
