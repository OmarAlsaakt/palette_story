# PaletteStory

A comprehensive Flutter mobile application for color palette generation and management.

## Features

- **📸 Extract Colors**: Capture or upload images to extract dominant colors
- **💾 My Palettes**: Save and organize your color palettes
- **👔 My Wardrobe**: Digital wardrobe with color-based outfit suggestions
- **🎨 Artist Tools**: Professional color theory tools and utilities
- **✨ Generate Colors**: AI-powered palette generation from keywords
- **📤 Export & Share**: Multiple export formats (CSS, JSON, images)

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (>=3.0.0 <4.0.0)
- Android Studio / VS Code with Flutter extensions
- Android emulator

### Installation

1. **Clone or extract the project:**

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters:**

   The project uses Hive for local storage. You need to generate the type adapters:

   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── color_palette.dart
│   ├── wardrobe_item.dart
│   └── app_settings.dart
├── screens/                  # UI screens
│   ├── home_screen.dart
│   ├── camera_screen.dart
│   ├── saved_palettes_screen.dart
│   ├── palette_detail_screen.dart
│   ├── wardrobe_screen.dart
│   ├── artist_tools_screen.dart
│   ├── color_generator_screen.dart
│   └── settings_screen.dart
├── widgets/                  # Reusable widgets
│   ├── color_swatch_card.dart
│   ├── palette_card.dart
│   ├── wardrobe_item_card.dart
│   └── color_info_display.dart
├── services/                 # Business logic services
│   ├── color_extraction_service.dart
│   ├── color_generator_service.dart
│   ├── storage_service.dart
│   └── share_service.dart
├── providers/                # State management
│   ├── palette_provider.dart
│   ├── wardrobe_provider.dart
│   └── settings_provider.dart
└── utils/                    # Utilities and helpers
    ├── constants.dart
    └── color_helpers.dart
```

## Key Technologies

- **Flutter**: Cross-platform mobile framework
- **Provider**: State management
- **Hive**: Local database for persistent storage
- **image_picker**: Camera and gallery access
- **palette_generator**: Color extraction from images
- **google_fonts**: Custom typography

## Usage Guide

### 1. Extract Colors from Images

- Tap "Extract Colors" on the home screen
- Choose to take a photo or select from gallery
- View extracted colors and save as a palette

### 2. Manage Palettes

- Access "My Palettes" to view all saved palettes
- Tap a palette to view details
- Copy hex codes, export to CSS/JSON
- Delete or edit palettes

### 3. Digital Wardrobe

- Add clothing items with photos
- Colors are automatically extracted
- Get outfit suggestions based on color harmony
- Filter by category, season, or occasion

### 4. Artist Tools

- **Color Theory**: Explore complementary, analogous, and triadic colors
- **Color Picker**: Select any color and view its properties
- **Tints & Shades**: Generate lighter and darker variants
- **Contrast Checker**: Verify WCAG accessibility compliance

### 5. Generate Palettes

- Create palettes from keywords (ocean, sunset, etc.)
- Generate random harmonious palettes
- Save generated palettes for later use

## Troubleshooting

### Issue: Hive adapter errors

**Solution**: Run the build_runner command:

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Issue: Camera/Gallery not working

**Solution**: Ensure permissions are added:

- **Android**: Check `android/app/src/main/AndroidManifest.xml`
- **iOS**: Check `ios/Runner/Info.plist`

### Issue: Colors not extracting properly

**Solution**: Ensure image is not too large (app auto-compresses >2MB images)

## Configuration

### Permissions Required

#### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

#### iOS (`ios/Runner/Info.plist`)

```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to capture images for color extraction</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photo library access to select images for color extraction</string>
```

## Future Enhancements

- Cloud sync for palettes
- Social sharing features
- Machine learning for trend prediction
- AR try-on for wardrobe items
- Integration with design tools (Figma, Adobe)
- Community palette gallery

## dependencies

flutter pub add cupertino_icons
flutter pub add image_picker
flutter pub add image
flutter pub add palette_generator
flutter pub add provider
flutter pub add hive
flutter pub add hive_flutter
flutter pub add path_provider
flutter pub add google_fonts
flutter pub add flutter_colorpicker
flutter pub add uuid
flutter pub add shared_preferences
flutter pub add intl

## dev_dependencies

flutter pub add --dev flutter_test
flutter pub add --dev flutter_lints
flutter pub add --dev hive_generator
flutter pub add --dev build_runner

##

flutter pub get

flutter packages pub run build_runner build --delete-conflicting-outputs

flutter run
