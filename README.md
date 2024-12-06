
# **Ve Amor App**

A Flutter-based dating app project.

## **Introduction**

**Ve Amor** is a smart dating app designed to connect people based on shared interests and advanced AI technologies. This application provides users with a modern dating experience, emphasizing authenticity and intelligent matchmaking.  

## **Features**  

- **User Registration/Sign-In**: Register using email, phone, or social accounts.  
- **Profile Verification**: Verify identity using facial recognition and government-issued ID.  
- **Swipe Feature**: Like or pass on potential matches with intuitive gestures.  
- **Detailed Profiles**: Explore user profiles with rich details and preferences.  
- **Smart Recommendations**: AI-powered suggestions tailored to user behavior.  
- **Chatbot Assistance**: Provides icebreakers and conversational tips.  
- **Anonymous Mode**: Browse without revealing personal information.  
- **Events for Connection**: Join real-life events to meet new people.  

## **Installation**  

1. **System Requirements**  
   - Flutter SDK >= 3.10.0  
   - Dart >= 2.19  
   - Android Studio or Xcode for Android/iOS development  

2. **Clone the Repository**  
   ```bash  
   git clone https://github.com/your-repo/ve_amor_app.git  
   cd ve_amor_app  
   ```  

3. **Install Dependencies**  
   ```bash  
   flutter pub get  
   ```  

4. **Run the Application**  
   ```bash  
   flutter run  
   ```  

## **Project Structure**  
```plaintext  
lib/  
├── bindings/         # Dependency injection and bindings for pages  
├── common/           # Common widgets and resources  
├── data/             # Data models and repositories  
├── features/         # Feature-specific modules (screens and logic)  
├── generated/        # Generated files for localization and other utilities  
├── utils/            # Utility functions and constants  
├── app.dart          # App-level configuration and initialization  
├── firebase_options.dart  # Firebase configuration  
├── main.dart         # Application entry point  
└── navigation_menu.dart  # Navigation menu logic and UI  
```  

## **Technologies Used**  
- **Firebase**: Database management, image storage, and push notifications.  
- **AWS Rekognition**: Facial comparison for user verification.  
- **GetX**: State management and routing.
- **Gemini**: An intelligent chatbot for assisting users in conversations and providing personalized suggestions.

## **Contributing**  
We welcome contributions to improve the app! Follow these steps to contribute:  
1. Fork the repository.  
2. Create a new branch from `main`.  
3. Make your changes and commit them.  
4. Submit a pull request with a detailed description of your changes.  

## **Contact**  
For questions or feedback, feel free to reach out:  
- Email: support@veamor.com  
- Website: [https://veamor.com](https://veamor.com)  
- Facebook: [Ve Amor](https://facebook.com/veamor)  

Thank you for choosing **Ve Amor**! ❤️  
