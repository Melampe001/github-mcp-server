# Tokyo Predictor Quick Start

Generate a complete project scaffold for the Tokyo Predictor application in seconds.

## One Command Setup

```bash
./prepare_tokyo_patch.sh
```

This creates `tokyo-predictor.zip` containing:
- ✅ Go service structure (cmd, internal, lib, admin, config, docs, proto, ruby, testing)
- ✅ Complete Android app with Kotlin
- ✅ GitHub Actions CI/CD workflows
- ✅ Makefile with standard targets
- ✅ Contributing guidelines
- ✅ MIT License

## Extract and Use

```bash
# Extract the scaffold
unzip tokyo-predictor.zip

# Navigate to the project
cd tokyo-predictor

# Review the structure
ls -la

# Push to GitHub
gh repo create modelcontextprotocol/tokyo-predictor --public --source=. --remote=origin --push
```

## What You Get

### Directory Structure
```
tokyo-predictor/
├── .github/
│   ├── CONTRIBUTING.md              # Full contribution guidelines
│   └── workflows/
│       ├── android-build.yml        # Android CI (assembleDebug + artifacts)
│       └── go-ci.yml                # Go CI (fmt + test)
├── android/                          # Complete Android app
│   ├── app/
│   │   ├── build.gradle             # App configuration
│   │   └── src/main/
│   │       ├── AndroidManifest.xml  
│   │       └── java/.../MainActivity.kt
│   ├── build.gradle                 # Root build config
│   └── settings.gradle              
├── cmd/                              # CLI/server entry points
├── internal/                         # Internal packages
├── lib/                              # Core libraries
├── admin/                            # Admin components
├── config/                           # Configuration
├── docs/                             # Documentation
├── proto/                            # Protocol buffers
├── ruby/                             # Ruby components
├── testing/                          # Test utilities
├── Makefile                          # Build automation
├── go.mod                            # Go module
├── LICENSE                           # MIT License
└── README.md                         # Project overview
```

### Makefile Targets

```bash
make fmt      # Format Go code
make build    # Build the project
make test     # Run tests
make ci       # Full CI (fmt + test)
make proto    # Generate protobuf code (when implemented)
```

### Android Build

```bash
cd android
./gradlew assembleDebug    # Build debug APK
./gradlew assembleRelease  # Build release APK
```

## Customization

Before pushing, you may want to customize:

1. **Module path** in `go.mod`
2. **Android package** in `android/app/build.gradle` and `AndroidManifest.xml`
3. **License** year/author in `LICENSE`

See [TOKYO_PREDICTOR_SETUP.md](TOKYO_PREDICTOR_SETUP.md) for detailed instructions.

## Requirements

- Bash shell
- `zip` utility (usually pre-installed)
- `git` (for the generated repository)

## Support

For detailed documentation, see [TOKYO_PREDICTOR_SETUP.md](TOKYO_PREDICTOR_SETUP.md)
