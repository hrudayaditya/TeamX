# TeamX Build Guide

This guide provides step-by-step instructions for setting up, building, and testing the TeamX Fantasy Sports application.

## Prerequisites

### System Requirements
- Operating System: macOS, Windows, or Linux
- RAM: Minimum 8GB (16GB recommended)
- Disk Space: At least 25GB free space
- Internet connection for downloading dependencies

### Required Software
1. **Git**
   - Download and install from [git-scm.com](https://git-scm.com)
   - Verify installation: `git --version`

2. **Flutter SDK**
   - Download Flutter SDK from [flutter.dev](https://flutter.dev/docs/get-started/install)
   - Extract the downloaded file to a desired location
   - Add Flutter to your PATH:
     ```bash
     # For macOS/Linux
     export PATH="$PATH:`pwd`/flutter/bin"
     
     # For Windows
     set PATH=%PATH%;C:\path\to\flutter\bin
     ```
   - Verify installation: `flutter doctor`

3. **Android Studio / Xcode**
   - For Android development: Install [Android Studio](https://developer.android.com/studio)
   - For iOS development: Install [Xcode](https://developer.apple.com/xcode/) (macOS only)
   - Install required SDKs and tools through the respective IDEs

4. **VS Code (Optional but Recommended)**
   - Download from [code.visualstudio.com](https://code.visualstudio.com)
   - Install Flutter and Dart extensions

## Repository Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/hrudayaditya111/TeamX.git
   cd TeamX
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

## Running the Application

### Development Mode
1. **Start an Emulator/Simulator**
   - Android: Open Android Studio → AVD Manager → Start emulator
   - iOS: Open Xcode → Open iOS Simulator

2. **Run the App**
   ```bash
   flutter run
   ```
   - Press `r` for hot reload
   - Press `R` for hot restart
   - Press `q` to quit

### Debug Mode
1. **Launch VS Code**
2. **Open the Project**
3. **Start Debugging**
   - Press F5 or click the "Run and Debug" button
   - Select your target device
   - The app will launch in debug mode

## Building the Application

### Android Build
1. **Generate Release Keystore**
   ```bash
   keytool -genkey -v -keystore android/app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

2. **Configure Signing**
   - Add keystore details to `android/key.properties`
   - Update `android/app/build.gradle`

3. **Build APK**
   ```bash
   flutter build apk --release
   ```
   - Output: `build/app/outputs/flutter-apk/app-release.apk`

4. **Build App Bundle**
   ```bash
   flutter build appbundle --release
   ```
   - Output: `build/app/outputs/bundle/release/app-release.aab`

### iOS Build
1. **Open Xcode**
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Configure Signing**
   - Set up your Apple Developer account
   - Configure signing certificates and provisioning profiles

3. **Build IPA**
   ```bash
   flutter build ios --release
   ```
   - Archive and export through Xcode

## Testing

### Unit Tests
```bash
flutter test
```

## Troubleshooting

### Common Issues
1. **Flutter Doctor Issues**
   - Run `flutter doctor -v` for detailed diagnostics
   - Follow the suggested fixes

2. **Build Failures**
   - Clean the project: `flutter clean`
   - Get dependencies again: `flutter pub get`
   - Rebuild: `flutter build`

3. **iOS-specific Issues**
   - Update CocoaPods: `sudo gem install cocoapods`
   - Install pods: `cd ios && pod install`

4. **Android-specific Issues**
   - Update Gradle: `cd android && ./gradlew wrapper --gradle-version 7.5`
   - Clean build: `cd android && ./gradlew clean`

## Contributing

1. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make Changes**
   - Follow the coding style guide
   - Write tests for new features
   - Update documentation

3. **Submit Changes**
   ```bash
   git add .
   git commit -m "Description of changes"
   git push origin feature/your-feature-name
   ```

4. **Create Pull Request**
   - Follow the PR template
   - Ensure all tests pass
   - Request code review

## Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [TeamX Wiki](link-to-wiki)
- [Issue Tracker](link-to-issues) 