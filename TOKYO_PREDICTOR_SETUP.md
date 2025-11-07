# Tokyo Predictor Scaffold Setup

This guide explains how to use the `prepare_tokyo_patch.sh` script to generate a complete project scaffold for the Tokyo Predictor application.

## What's Included

The script generates a complete project structure with:

### Core Files
- **README.md** - Project overview
- **LICENSE** - MIT License (Copyright 2025 Melampe001)
- **.gitignore** - Configured for Go and Android builds
- **go.mod** - Go module file (module: github.com/modelcontextprotocol/tokyo-predictor)
- **Makefile** - Build automation with targets: `fmt`, `build`, `test`, `ci`, `proto`

### Directory Structure
- `cmd/` - Main service entry points and executables
- `internal/` - Logic related to interactions with other GitHub services
- `lib/` - Core Go packages for billing logic
- `admin/` - Admin interface components
- `config/` - Configuration files and templates
- `docs/` - Documentation
- `proto/` - Protocol buffer definitions
- `ruby/` - Ruby implementation components
- `testing/` - Test helpers and fixtures

### Android Scaffold
Complete Android application structure:
- `android/settings.gradle` - Project settings
- `android/build.gradle` - Root build configuration
- `android/gradle.properties` - Gradle properties
- `android/app/build.gradle` - App module configuration
- `android/app/src/main/AndroidManifest.xml` - Android manifest
- `android/app/src/main/java/com/example/tokyopredictor/MainActivity.kt` - Main activity
- `android/app/proguard-rules.pro` - ProGuard rules

### GitHub Actions Workflows
- `.github/workflows/android-build.yml` - Android CI/CD (assembleDebug + artifact upload)
- `.github/workflows/go-ci.yml` - Go CI/CD (fmt + test)

### Contributing Guidelines
- `.github/CONTRIBUTING.md` - Complete contribution guidelines with:
  - Required pre-commit checks
  - Development flow
  - Repository structure explanation
  - Key guidelines for Go and Ruby development
  - PR checklist

## Quick Start

### Step 1: Run the Script

```bash
# Make the script executable (already done in repo)
chmod +x prepare_tokyo_patch.sh

# Execute the script
./prepare_tokyo_patch.sh
```

This will create `tokyo-predictor.zip` in your current directory.

### Step 2: Extract and Review

```bash
# Extract the ZIP
unzip tokyo-predictor.zip

# Review the contents
cd tokyo-predictor
ls -la

# Check the structure
tree -L 2  # or use ls -R
```

### Step 3: Customize (Optional)

Before creating your repository, you may want to customize:

1. **Module path** in `go.mod`:
   ```go
   module github.com/YOUR-ORG/YOUR-REPO
   ```

2. **Android package** in:
   - `android/app/build.gradle` (applicationId)
   - `android/app/src/main/AndroidManifest.xml` (package)
   - `android/app/src/main/java/com/example/tokyopredictor/MainActivity.kt` (package)

3. **License** in `LICENSE` (year, author name)

### Step 4: Create GitHub Repository

Option A: Using GitHub CLI
```bash
cd tokyo-predictor
gh repo create modelcontextprotocol/tokyo-predictor --public --source=. --remote=origin --push
```

Option B: Manual Setup
```bash
cd tokyo-predictor

# Add remote
git remote add origin git@github.com:modelcontextprotocol/tokyo-predictor.git

# Push to GitHub
git push -u origin main
```

## What's Generated

The script creates a fully initialized Git repository with all files committed. The ZIP includes:

```
tokyo-predictor/
├── .git/                           # Git repository (initialized)
├── .github/
│   ├── CONTRIBUTING.md             # Contribution guidelines
│   ├── instructions/
│   │   └── Fiel                    # Placeholder for legacy instructions
│   └── workflows/
│       ├── android-build.yml       # Android CI workflow
│       └── go-ci.yml               # Go CI workflow
├── .gitignore                      # Go and Android ignores
├── LICENSE                         # MIT License
├── Makefile                        # Build targets
├── README.md                       # Project overview
├── go.mod                          # Go module definition
├── admin/                          # Admin components
├── android/                        # Complete Android app
│   ├── app/
│   │   ├── build.gradle
│   │   ├── proguard-rules.pro
│   │   └── src/main/
│   │       ├── AndroidManifest.xml
│   │       └── java/com/example/tokyopredictor/
│   │           └── MainActivity.kt
│   ├── build.gradle
│   ├── gradle.properties
│   └── settings.gradle
├── cmd/                            # CLI/server entry points
├── config/                         # Configuration files
├── docs/                           # Documentation
├── internal/                       # Internal packages
├── lib/                            # Core libraries
├── proto/                          # Protocol buffers
├── ruby/                           # Ruby components
└── testing/                        # Test utilities
```

## Next Steps After Setup

### 1. Add Gradle Wrapper (Recommended)

On a machine with Gradle installed:

```bash
cd android
gradle wrapper
git add gradle/ gradlew gradlew.bat
git commit -m "Add Gradle wrapper"
git push
```

### 2. Enable Android Signing (Optional)

To sign release builds in CI:

1. Add secrets to your GitHub repository:
   - `ANDROID_KEYSTORE_BASE64`
   - `KEYSTORE_PASSWORD`
   - `KEY_ALIAS`
   - `KEY_PASSWORD`

2. Update `.github/workflows/android-build.yml` to use `assembleRelease` with signing configuration

### 3. Enable Branch Protection

In your GitHub repository settings:
- Require pull request reviews
- Require status checks to pass
- Enable required checks: "Go CI", "Android Build"

### 4. Configure Organization Permissions

If using GitHub organization:
- Set up team access
- Configure repository settings
- Enable required policies

## Development Workflow

### Building

```bash
# Go build
make build

# Format code
make fmt

# Run tests
make test

# Full CI locally
make ci

# Protocol buffers (when implemented)
make proto
```

### Android Development

```bash
cd android

# Build debug APK
./gradlew assembleDebug

# Build release APK
./gradlew assembleRelease

# Run tests
./gradlew test
```

## CI/CD Workflows

### Android Build Workflow

- **Trigger**: Push to `ci/android-build` branch or PR to `main`
- **Actions**:
  - Sets up JDK 11
  - Installs Android SDK
  - Builds debug APK
  - Uploads APK as artifact

### Go CI Workflow

- **Trigger**: Push to `main` or PR to `main`
- **Actions**:
  - Sets up Go 1.20
  - Runs `make fmt`
  - Runs `make test`

## Customization Options

### Change Module Path

Edit `go.mod`:
```go
module github.com/YOUR-ORG/YOUR-REPO

go 1.20
```

### Change Android Package

1. Update `android/app/build.gradle`:
   ```gradle
   applicationId "com.yourorg.yourapp"
   ```

2. Update `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <manifest package="com.yourorg.yourapp" ...>
   ```

3. Move and update `MainActivity.kt`:
   ```bash
   mkdir -p android/app/src/main/java/com/yourorg/yourapp
   mv android/app/src/main/java/com/example/tokyopredictor/MainActivity.kt \
      android/app/src/main/java/com/yourorg/yourapp/
   ```

4. Update package in `MainActivity.kt`:
   ```kotlin
   package com.yourorg.yourapp
   ```

### Add PR Templates

Create `.github/pull_request_template.md` with your preferred template.

### Add Issue Templates

Create `.github/ISSUE_TEMPLATE/` directory with issue templates.

## Troubleshooting

### Script Permission Denied

```bash
chmod +x prepare_tokyo_patch.sh
```

### Zip Not Found

Install zip utility:
```bash
# Ubuntu/Debian
sudo apt-get install zip

# macOS
brew install zip
```

### Git Not Initialized

The script automatically initializes a Git repository. If you need to reinitialize:
```bash
cd tokyo-predictor
rm -rf .git
git init -b main
git add -A
git commit -m "Initial commit"
```

## Support

For issues or questions:
1. Check the generated `.github/CONTRIBUTING.md` file
2. Review the Makefile targets
3. Inspect the generated workflows in `.github/workflows/`

## License

The generated scaffold includes an MIT License. Customize the LICENSE file as needed for your project.
