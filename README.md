# PaletteStory

<div align="center">
  <img src="screens/Light Screen/flutter_01.png" alt="PaletteStory Home" width="300"/>
  
  **A comprehensive Flutter mobile application for color palette generation and management**
  
  [![Flutter](https://img.shields.io/badge/Flutter-3.0.0+-02569B?logo=flutter)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.0.0+-0175C2?logo=dart)](https://dart.dev)
</div>

---

## 📖 Overview

PaletteStory is your personal color companion—a powerful mobile app designed for designers, artists, fashion enthusiasts, and anyone passionate about colors. Extract colors from images, create custom palettes, organize your digital wardrobe, and explore professional color theory tools, all in one beautiful interface.

## ✨ Key Features

- **📸 Color Extraction** - Capture or upload images to extract dominant colors
- **💾 Palette Management** - Save, organize, and categorize your color palettes
- **👔 Digital Wardrobe** - Manage clothing items with color-based organization
- **🎨 Artist Tools** - Professional color theory utilities (complementary, analogous, triadic schemes)
- **✨ AI Generation** - Generate palettes from keywords and moods
- **📤 Export & Share** - Multiple export formats (CSS, JSON, image)
- **🌓 Theme Support** - Beautiful light and dark mode interfaces

---

## 📱 App Screenshots

### Home Screen

The main dashboard with quick access to all major features.

<div align="center">
  <img src="screens/Light Screen/flutter_01.png" alt="Home - Light Mode" width="250"/>
  <img src="screens/Dark Screen/flutter_47.png" alt="Home - Dark Mode" width="250"/>
</div>

---

### Extract Colors

Capture or upload images and extract dominant color palettes with ease.

<div align="center">
  <img src="screens/Light Screen/flutter_02.png" alt="Extract Colors - Light Mode" width="250"/>
  <img src="screens/Light Screen/flutter_03.png" alt="Image Selection - Light Mode" width="250"/>
  <img src="screens/Dark Screen/flutter_48.png" alt="Extract Colors - Dark Mode" width="250"/>
</div>

<div align="center">
  <img src="screens/Light Screen/flutter_04.png" alt="Color Extraction Result" width="250"/>
  <img src="screens/Light Screen/flutter_05.png" alt="Extracted Palette Details" width="250"/>
  <img src="screens/Dark Screen/flutter_49.png" alt="Extraction Result - Dark Mode" width="250"/>
</div>

---

### My Palettes

Browse, search, and organize your saved color palettes by categories.

<div align="center">
  <img src="screens/Light Screen/flutter_10.png" alt="My Palettes - Light Mode" width="250"/>
  <img src="screens/Light Screen/flutter_11.png" alt="Palette Details - Light Mode" width="250"/>
  <img src="screens/Dark Screen/flutter_54.png" alt="My Palettes - Dark Mode" width="250"/>
</div>

<div align="center">
  <img src="screens/Light Screen/flutter_12.png" alt="Palette Color View" width="250"/>
  <img src="screens/Light Screen/flutter_13.png" alt="Export Options" width="250"/>
  <img src="screens/Dark Screen/flutter_55.png" alt="Palette Details - Dark Mode" width="250"/>
</div>

---

### My Wardrobe

Build your digital wardrobe with color extraction and smart categorization.

<div align="center">
  <img src="screens/Light Screen/flutter_15.png" alt="My Wardrobe - Light Mode" width="250"/>
  <img src="screens/Light Screen/flutter_16.png" alt="Wardrobe Categories - Light Mode" width="250"/>
  <img src="screens/Dark Screen/flutter_58.png" alt="My Wardrobe - Dark Mode" width="250"/>
</div>

<div align="center">
  <img src="screens/Light Screen/flutter_20.png" alt="Add Wardrobe Item" width="250"/>
  <img src="screens/Light Screen/flutter_21.png" alt="Wardrobe Item Details" width="250"/>
  <img src="screens/Dark Screen/flutter_59.png" alt="Add Item - Dark Mode" width="250"/>
</div>

---

### Artist Tools

Professional color theory tools for designers and artists.

<div align="center">
  <img src="screens/Light Screen/flutter_24.png" alt="Artist Tools - Light Mode" width="250"/>
  <img src="screens/Light Screen/flutter_25.png" alt="Complementary Colors" width="250"/>
  <img src="screens/Dark Screen/flutter_62.png" alt="Artist Tools - Dark Mode" width="250"/>
</div>

<div align="center">
  <img src="screens/Light Screen/flutter_30.png" alt="Color Picker" width="250"/>
  <img src="screens/Light Screen/flutter_31.png" alt="Color Harmonies" width="250"/>
  <img src="screens/Light Screen/flutter_35.png" alt="Background Color Selection" width="250"/>
</div>

---

### Generate Colors

AI-powered palette generation from keywords, moods, and styles.

<div align="center">
  <img src="screens/Light Screen/flutter_38.png" alt="Generate Colors - Light Mode" width="250"/>
  <img src="screens/Light Screen/flutter_39.png" alt="Mood Selection" width="250"/>
  <img src="screens/Dark Screen/flutter_65.png" alt="Generate Colors - Dark Mode" width="250"/>
</div>

<div align="center">
  <img src="screens/Light Screen/flutter_40.png" alt="Save Generated Palette" width="250"/>
  <img src="screens/Light Screen/flutter_41.png" alt="Generated Palette Result" width="250"/>
  <img src="screens/Dark Screen/flutter_66.png" alt="Generated Result - Dark Mode" width="250"/>
</div>

---

### Settings & About

Customize your experience with theme modes, color format preferences, and more.

<div align="center">
  <img src="screens/Dark Screen/flutter_47.png" alt="Settings - Dark Mode" width="250"/>
  <img src="screens/Light Screen/flutter_44.png" alt="About Screen - Light Mode" width="250"/>
  <img src="screens/Dark Screen/flutter_67.png" alt="About - Dark Mode" width="250"/>
</div>

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (>=3.0.0 <4.0.0)
- Android Studio / VS Code with Flutter extensions
- Android emulator or physical device

### Installation

1. **Clone the repository:**

   ```bash
   git clone <repository-url>
   cd PaletteStory
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters:**

   The project uses Hive for local storage. Generate the type adapters:

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

### Configuration

The app uses local storage with Hive. No additional API keys or external configurations are required.

---

## 🏗️ Project Structure

```
lib/
├── models/          # Data models (Palette, WardrobeItem, etc.)
├── screens/         # UI screens
├── widgets/         # Reusable widgets
├── services/        # Business logic and services
├── utils/           # Helper functions and constants
└── main.dart        # App entry point
```

---

## 🛠️ Technologies

- **Flutter** - Cross-platform mobile framework
- **Dart** - Programming language
- **Hive** - Lightweight local database
- **Material Design 3** - Modern UI components
- **Image Picker** - Camera and gallery access
- **Color Utilities** - Advanced color manipulation

---

## 📦 Export Formats

PaletteStory supports exporting your color palettes in multiple formats:

- **CSS** - Ready-to-use CSS variables
- **JSON** - Structured data format
- **PNG Image** - Visual palette representation
- **Share** - Direct sharing to other apps

---

## 🎨 Features in Detail

### Color Extraction

- Extract 3-10 dominant colors from any image
- Automatic color clustering algorithm
- Adjustable color count in settings

### Palette Management

- Categorize palettes (Nature, Fashion, Art, etc.)
- Search and filter functionality
- Detailed color information (HEX, RGB, HSL)
- Copy individual colors to clipboard

### Digital Wardrobe

- Organize clothing by category (Top, Bottom, Dress, Shoes, etc.)
- Optional season and occasion tags
- Color-based wardrobe visualization
- Outfit suggestion based on color harmony

### Artist Tools

- **Complementary Colors** - Find opposite colors on the color wheel
- **Analogous Colors** - Discover harmonious adjacent colors
- **Triadic Colors** - Generate balanced three-color schemes
- **Tints & Shades** - Explore color variations
- **Color Picker** - Precise color selection with RGB/HSL values

### Color Generation

- Generate palettes from mood keywords
- Style-based generation (vintage, modern, bold, etc.)
- Random palette generation
- Save generated palettes instantly

---

## 🌙 Theme Support

PaletteStory features a beautiful adaptive interface with:

- Light mode with soft gradients
- Dark mode with rich contrasts
- Smooth theme transitions
- System theme detection

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👨‍💻 Author

**Your Name**

- GitHub: [@OmarAlsaakt](https://github.com/OmarAlsaakt)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for the design system
- All open-source contributors

---

<div align="center">
  Made with ❤️ and Flutter
  
  ⭐ Star this repo if you find it helpful!
</div>
