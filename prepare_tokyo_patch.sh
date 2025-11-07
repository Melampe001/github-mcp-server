#!/usr/bin/env bash
set -euo pipefail

OUTDIR="tokyo-predictor"
ZIPFILE="${OUTDIR}.zip"
MODULE="github.com/modelcontextprotocol/tokyo-predictor"
YEAR="2025"
AUTHOR="Melampe001"

rm -rf "${OUTDIR}" "${ZIPFILE}"
mkdir -p "${OUTDIR}"

cd "${OUTDIR}"

# Directories
mkdir -p cmd internal lib admin config docs proto ruby testing .github .github/instructions
mkdir -p android/app/src/main/java/com/example/tokyopredictor
mkdir -p android/app/src/main/res
mkdir -p .github/workflows

# README
cat > README.md <<'EOF'
tokyo-predictor

Initial scaffold for the Tokyo Predictor repository.
EOF

# .gitignore (Go)
cat > .gitignore <<'EOF'
# Binaries for programs and plugins
bin/
# Test binary, build outputs
*.test
# Go workspace file
go.work
# IDE/editor files
.vscode/
.idea/
# Android builds
android/app/build/
android/.gradle/
EOF

# LICENSE (MIT)
cat > LICENSE <<EOF
MIT License

Copyright (c) ${YEAR} ${AUTHOR}

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

# CONTRIBUTING.md (uses your Code Standards)
cat > .github/CONTRIBUTING.md <<'EOF'
This repository is primarily a Go service with a Ruby client for some API endpoints. It is responsible for ingesting metered usage and recording that usage. Please follow these guidelines when contributing.

Required before each commit
- Run: make fmt — runs gofmt on all Go files.
- Ensure tests pass locally: make test.
- Add tests for new logic.

Development flow
- Build: make build
- Test: make test
- Full CI: make ci (includes build, fmt, lint, test)

If you modify proto/ or ruby/
- proto/: run `make proto` after changes.
- ruby/: increment ruby/lib/billing-platform/version.rb using semantic versioning.

Repository structure
- cmd/: Main service entry points and executables
- internal/: Logic related to interactions with other GitHub services
- lib/: Core Go packages for billing logic
- admin/: Admin interface components
- config/: Configuration files and templates
- docs/: Documentation
- proto/: Protocol buffer definitions (run `make proto` after updates)
- ruby/: Ruby implementation components (bump version file when updated)
- testing/: Test helpers and fixtures

Key guidelines
1. Follow idiomatic Go practices.
2. Preserve existing structure.
3. Use dependency injection patterns where appropriate.
4. Write unit tests (prefer table-driven).
5. Document public APIs and complex logic.

How to open a PR
- Create a descriptive branch (feature/..., fix/...).
- Ensure you ran: make fmt, make build, make test, make ci, make proto (if relevant), update ruby version file if modifying ruby/.
- PR description should include what it changes, how to test locally, API impacts and versioning needs.

PR checklist
- [ ] make fmt passed
- [ ] make build passed
- [ ] make test passed
- [ ] make ci passed
- [ ] Docs updated if applicable
- [ ] proto/ or ruby/ changes handled
- [ ] Tests added for new functionality
EOF

# Makefile (basic targets matching your Code Standards)
cat > Makefile <<'EOF'
.PHONY: fmt build test ci proto

fmt:
	@gofmt -w .

build:
	@go build ./...

test:
	@go test ./...

ci: fmt test

proto:
	@echo "Run codegen for proto files (not implemented)."
EOF

# Placeholder go.mod
cat > go.mod <<EOF
module ${MODULE}

go 1.20
EOF

# keep dirs visible
touch cmd/.gitkeep internal/.gitkeep lib/.gitkeep admin/.gitkeep config/.gitkeep docs/.gitkeep proto/.gitkeep ruby/.gitkeep testing/.gitkeep

# Android scaffold (Kotlin)
cat > android/settings.gradle <<'EOF'
rootProject.name = "TokyoPredictor"
include ':app'
EOF

cat > android/build.gradle <<'EOF'
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath "com.android.tools.build:gradle:7.4.2"
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.0"
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
EOF

cat > android/gradle.properties <<'EOF'
org.gradle.jvmargs=-Xmx1536m
android.useAndroidX=true
android.enableJetifier=true
EOF

cat > android/app/build.gradle <<'EOF'
plugins {
    id 'com.android.application'
    id 'kotlin-android'
}

android {
    compileSdk 33

    defaultConfig {
        applicationId "com.example.tokyopredictor"
        minSdk 21
        targetSdk 33
        versionCode 1
        versionName "0.1"
        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_11
        targetCompatibility JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = "11"
    }
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib:1.9.0"
    implementation 'androidx.core:core-ktx:1.9.0'
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.8.0'

    testImplementation 'junit:junit:4.13.2'
    androidTestImplementation 'androidx.test.ext:junit:1.1.5'
    androidTestImplementation 'androidx.test.espresso:espresso-core:3.5.1'
}
EOF

cat > android/app/src/main/AndroidManifest.xml <<'EOF'
<manifest package="com.example.tokyopredictor"
    xmlns:android="http://schemas.android.com/apk/res/android">

    <application
        android:label="TokyoPredictor"
        android:icon="@mipmap/ic_launcher">
        <activity android:name=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>
EOF

cat > android/app/src/main/java/com/example/tokyopredictor/MainActivity.kt <<'EOF'
package com.example.tokyopredictor

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.TextView

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val tv = TextView(this)
        tv.text = "Tokyo Predictor - App Scaffold"
        tv.textSize = 20f
        setContentView(tv)
    }
}
EOF

cat > android/app/proguard-rules.pro <<'EOF'
# Keep default rules (empty stub for now)
EOF

# GitHub Actions workflow for Android build (assembleDebug)
cat > .github/workflows/android-build.yml <<'EOF'
name: Android Build (assembleDebug)

on:
  push:
    branches:
      - ci/android-build
  pull_request:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    env:
      ANDROID_SDK_ROOT: ${{ runner.temp }}/android-sdk

    steps:
      - uses: actions/checkout@v4

      - name: Set up JDK 11
        uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: '11'

      - name: Install Android SDK command-line tools & platforms
        run: |
          sudo apt-get update
          sudo apt-get install -y wget unzip
          mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools"
          wget -q -O /tmp/cmdline-tools.zip "https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip"
          unzip -q /tmp/cmdline-tools.zip -d "$ANDROID_SDK_ROOT/cmdline-tools"
          mv "$ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools" "$ANDROID_SDK_ROOT/cmdline-tools/latest" || true
          yes | "$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$ANDROID_SDK_ROOT" "platform-tools" "platforms;android-33" "build-tools;33.0.2"

      - name: Make gradlew executable
        run: |
          if [ -f ./android/gradlew ]; then chmod +x ./android/gradlew; fi

      - name: Build debug APK
        working-directory: android
        run: |
          if [ -f ./gradlew ]; then ./gradlew assembleDebug --stacktrace; else gradle assembleDebug --no-daemon --stacktrace; fi

      - name: Upload APK artifact
        uses: actions/upload-artifact@v4
        with:
          name: tokyopredictor-debug-apk
          path: android/app/build/outputs/apk/debug/*.apk
EOF

# optional: add a simple repo-level CI workflow (Go) - basic check
cat > .github/workflows/go-ci.yml <<'EOF'
name: Go CI

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Go
        uses: actions/setup-go@v4
        with:
          go-version: '1.20'
      - name: Run fmt
        run: make fmt || true
      - name: Run tests
        run: make test
EOF

# Add .github/instructions placeholder and original Fiel if needed
cat > .github/instructions/Fiel <<'EOF'
# Original instructions placeholder (migrated to CONTRIBUTING.md)
EOF

# finalize
git init -b main >/dev/null 2>&1 || true
git add -A >/dev/null 2>&1 || true
git commit -m "chore: prepare patch scaffold (initial files + Android scaffold + CI workflows)" >/dev/null 2>&1 || true
cd ..

zip -r "${ZIPFILE}" "${OUTDIR}" >/dev/null

echo "Created ${ZIPFILE} with the scaffold."
