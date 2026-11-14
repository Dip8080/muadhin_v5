# Muaddin

Muaddin is a comprehensive Islamic prayer time and Athan (Adhan) application built with Flutter. It provides accurate prayer times, audio/video playback for prayers, Islamic calendar (Hijri) integration, and live streaming capabilities.

## 🚀 Features

- **Accurate Prayer Times:** Get precise prayer schedules based on your timezone.
- **Athan Notifications & Alarms:** Automated alarms and reminders for daily prayers.
- **Media Playback:** High-quality audio and video playback for Athan using `just_audio` and `youtube_player_iframe`.
- **Live Streaming:** Dedicated live feature for real-time broadcasts.
- **Hijri Calendar:** Integrated Islamic calendar dates alongside Gregorian dates.
- **State Management & Architecture:** Built robustly using `GetX` for state management, dependency injection, and routing.
- **Multi-language Support:** Currently supports English (`en`) and Dutch (`nl`).
- **Over-The-Air Updates:** Integrated Firebase Remote Config to handle app updates smoothly.
- **Responsive Design:** Optimized for different screen sizes and orientations using `flutter_sizer`.

## 🛠 Tech Stack & Libraries

- **Framework:** [Flutter](https://flutter.dev/) & Dart
- **State Management:** [GetX](https://pub.dev/packages/get)
- **Audio & Video:** `just_audio`, `youtube_player_iframe`, `video_player`
- **Firebase:** `firebase_core`, `firebase_storage`, `firebase_remote_config`
- **Utility:** `intl`, `shared_preferences`, `permission_handler`, `path_provider`, `hijri`
- **Device Controls:** `screen_brightness`, `volume_controller`, `wifi_iot`, `connectivity_plus`

## 📁 Project Structure

This project follows a feature-based folder structure combined with a clean core architecture:

```text
lib/
 ┣ core/                # Core utilities, theme, bindings, widgets, and URL configurations
 ┣ features/            # App features separated by domain
 ┃ ┣ Home/              # Main dashboard, alarms, and translations
 ┃ ┣ live/              # Live broadcasting/media features
 ┃ ┣ player_two/        # Secondary media player implementation
 ┃ ┗ update/            # App update logic via Firebase
 ┣ main.dart            # Application entry point
 ┗ muaddin.dart         # Main GetMaterialApp widget and routing setup
```

## ⚙️ Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (sdk: ^3.5.1)
- Android Studio / Xcode for emulators and building.
- A connected device or running emulator.

### Installation

1. Clone the repository:
   ```bash
   git clone <repository_url>
   ```
2. Navigate to the project directory:
   ```bash
   cd muadhin_v8
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## 🌍 Translations

The app relies on `AppTranslations` located in `lib/features/Home/controller/app_translations.dart`. You can easily add more languages by extending the translation maps.

## 📝 License

This project is proprietary. All rights reserved.
