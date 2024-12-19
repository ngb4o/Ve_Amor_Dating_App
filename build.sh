#!/bin/bash

echo "Building Production APK..."
flutter clean
flutter pub get
flutter build apk --target-platform=android-arm64 --analyze-size