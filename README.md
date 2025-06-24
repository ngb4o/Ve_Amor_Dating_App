# Ve Amor App

<p align="center">
  <img src="assets/logos/dating_app_logo.gif" alt="Ve Amor Logo" width="120"/>
</p>

<p align="center">
  <b>Ve Amor</b> - Smart, Authentic & AI-powered Dating App
</p>

<p align="center">
  <a href="https://flutter.dev/"><img src="https://img.shields.io/badge/Flutter-3.10%2B-blue?logo=flutter"/></a>
  <a href="https://firebase.google.com/"><img src="https://img.shields.io/badge/Firebase-Enabled-yellow?logo=firebase"/></a>
  <a href="https://getx.dev/"><img src="https://img.shields.io/badge/GetX-State%20Management-red"/></a>
</p>

---

## 📑 Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Technologies Used](#technologies-used)
- [Contributing](#contributing)
- [Contact](#contact)

---

## 📝 Introduction
**Ve Amor** is a modern dating app that connects people based on shared interests and advanced AI. The app focuses on authenticity, safety, and smart matchmaking, providing a seamless and enjoyable dating experience.

---

## ✨ Features
- **User Registration/Sign-In**: Email, phone, or social accounts
- **Profile Verification**: Facial recognition & government-issued ID
- **Swipe Feature**: Like or pass with intuitive gestures
- **Detailed Profiles**: Rich user details & preferences
- **Smart Recommendations**: AI-powered suggestions
- **Chatbot Assistance**: Icebreakers & conversation tips
- **Anonymous Mode**: Browse privately
- **Events for Connection**: Join real-life events

---

## 📱 Screenshots
<!-- Add screenshots here if available -->
<!--
<p align="center">
  <img src="assets/images/on_boarding_images/sammy-line-delivery.gif" width="200"/>
  <img src="assets/images/content/image-girl.png" width="200"/>
</p>
-->

---

## 🚀 Installation

### 1. System Requirements
- Flutter SDK >= 3.10.0
- Dart >= 2.19
- Android Studio/Xcode for Android/iOS development

### 2. Clone the Repository
```bash
git clone https://github.com/your-repo/ve_amor_app.git
cd ve_amor_app
```

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Run the Application
- **Android/iOS**:
  ```bash
  flutter run
  ```
- **Web**:
  ```bash
  flutter run -d chrome
  ```

### 5. Build Release (Optional)
- **Android APK**:
  ```bash
  flutter build apk --release
  ```
- **iOS**:
  ```bash
  flutter build ios --release
  ```

---

## 🗂 Project Structure
```plaintext
lib/
├── bindings/         # Dependency injection & bindings
├── common/           # Common widgets & UI components
├── data/             # Data models, repositories, services
├── features/         # Feature modules (auth, main, personalization, ...)
├── generated/        # Generated files (e.g. assets)
├── utils/            # Utilities, constants, helpers, themes
├── app.dart          # App-level config & initialization
├── firebase_options.dart  # Firebase config
├── main.dart         # App entry point
└── navigation_menu.dart   # Navigation menu logic/UI
```

---

## 🛠 Technologies Used
- **Flutter**: Cross-platform UI toolkit
- **Firebase**: Auth, Firestore, Storage, Push Notifications
- **AWS Rekognition**: Face verification
- **GetX**: State management & routing
- **Gemini**: AI chatbot for conversation & suggestions

---

## 🤝 Contributing
We welcome contributions to improve the app!

1. Fork the repository
2. Create a new branch from `main`
3. Make your changes and commit them
4. Submit a pull request with a detailed description

---

## 📬 Contact
- **Email**: support@veamor.com
- **Website**: [veamor.com](https://veamor.com)
- **Facebook**: [Ve Amor](https://facebook.com/veamor)

---

<p align="center">Thank you for choosing <b>Ve Amor</b>! ❤️</p>
