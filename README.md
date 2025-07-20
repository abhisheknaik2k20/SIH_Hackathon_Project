# CodeStore - Comprehensive Educational Platform

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

CodeStore is a feature-rich educational platform built with Flutter and Firebase, designed to revolutionize the learning experience for students and educators. This project was developed for the Smart India Hackathon (SIH) to address the growing need for accessible, interactive, and comprehensive digital education solutions.

## 🎯 Project Vision

In today's rapidly evolving educational landscape, traditional learning methods often fall short of providing engaging, personalized, and accessible education. CodeStore addresses these challenges by creating an all-in-one educational platform that combines course delivery, community interaction, real-time communication, and productivity tools.

## 🌟 Key Features

### 📚 **Course Management System**
- **Comprehensive Course Catalog**: 35+ courses across multiple technology domains
- **Advanced Search & Filtering**: Smart search with category and price filters
- **Multiple Learning Tracks**: Beginner to Advanced level courses
- **Course Categories**:
  - Data Structures & Algorithms
  - Operating Systems
  - Computer Networks
  - Database Management Systems (DBMS)
  - Cybersecurity
  - Artificial Intelligence & Machine Learning
  - Programming Languages (Python, Java, C++, JavaScript, Scala)
  - Mobile Development (Android, iOS, Flutter)
  - Cloud Computing & Big Data
  - IoT & Robotics

### 👥 **Community & Communication**
- **Real-time Chat System**: Peer-to-peer communication with multimedia support
- **Teacher-Student Interaction**: Direct communication channels with educators
- **File Sharing**: Support for images, videos, PDFs, and audio files
- **Push Notifications**: Firebase Cloud Messaging for instant updates
- **Community Dashboard**: Social learning environment with posts and discussions

### 🎥 **Video Communication**
- **WebRTC Integration**: Real-time video calling for virtual classrooms
- **Room-based Sessions**: Create and join virtual study rooms
- **Multi-platform Support**: Seamless video communication across devices

### 📅 **Productivity Tools**
- **Integrated Calendar**: Task management and scheduling system
- **SQLite Database**: Local task storage and management
- **Assignment Tracking**: Keep track of deadlines and important dates

### 🔍 **OCR Technology**
- **Text Recognition**: Convert handwritten or printed text to digital format
- **PDF Generation**: Create PDFs from extracted text
- **Image Processing**: Camera and gallery integration for document scanning

### 🎨 **Modern UI/UX**
- **Animated Interfaces**: Lottie animations for enhanced user experience
- **Material Design**: Clean, intuitive interface following Google's design principles
- **Dark/Light Theme Support**: Customizable visual preferences
- **Responsive Design**: Optimized for various screen sizes

### 🔐 **Authentication & Security**
- **Firebase Authentication**: Secure user management
- **Google Sign-In**: Easy onboarding process
- **Email Verification**: Account security measures
- **User Role Management**: Student and Teacher role differentiation

## 🛠️ Technical Stack

### **Frontend**
- **Flutter**: Cross-platform mobile app development
- **Dart**: Primary programming language
- **Material Design**: UI/UX framework

### **Backend & Cloud Services**
- **Firebase**: Complete backend solution
  - Authentication
  - Firestore Database
  - Cloud Storage
  - Cloud Messaging
- **Google ML Kit**: Text recognition capabilities

### **Key Dependencies**
```yaml
flutter_webrtc: ^0.9.48+hotfix.1    # Video calling functionality
firebase_core: ^2.24.2              # Firebase integration
cloud_firestore: ^4.14.0            # Database operations
google_sign_in: ^6.2.1              # Authentication
table_calendar: ^3.1.2              # Calendar widget
google_mlkit_text_recognition: ^0.10.0  # OCR capabilities
lottie: ^3.1.0                      # Animations
flutter_staggered_animations: ^1.1.1 # UI animations
```

## 🚀 Why CodeStore is Needed

### **Educational Challenges Addressed**

1. **Accessibility Issues**
   - Traditional education often lacks accessibility for remote learners
   - CodeStore provides 24/7 access to educational content

2. **Limited Interaction**
   - Conventional online courses lack peer interaction
   - Our platform fosters community learning through chat and video features

3. **Resource Fragmentation**
   - Students often need multiple platforms for different learning needs
   - CodeStore consolidates courses, communication, and productivity tools

4. **Technology Skills Gap**
   - High demand for technical education in emerging technologies
   - Comprehensive curriculum covering latest tech domains

5. **Personalized Learning**
   - One-size-fits-all approach doesn't work for diverse learners
   - Advanced filtering and search help students find relevant content

### **Market Impact**

- **Digital Education Growth**: The global e-learning market is expected to reach $350 billion by 2025
- **Post-Pandemic Shift**: Accelerated adoption of digital learning platforms
- **Skill Development**: Growing need for continuous upskilling in technology
- **Remote Learning**: Increasing demand for flexible, location-independent education

## 📁 Project Structure

```
lib/
├── main.dart                 # Application entry point
├── Animations/              # Custom animations
├── CustomWidgets/           # Reusable UI components
├── OCR/                     # Text recognition features
├── Screens/
│   ├── BootScreen/         # Main navigation
│   ├── calender/           # Calendar and task management
│   ├── Community/          # Chat and social features
│   ├── DashBoard/          # User dashboard
│   ├── HomeScreen/         # Course catalog
│   ├── IntroScreen/        # Onboarding
│   ├── login_screen/       # Authentication
│   ├── pptx/              # Presentation handling
│   ├── ProfileScreen/      # User profiles
│   └── webRTC/            # Video communication
└── styles/                 # App theming
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.4.3)
- Dart SDK
- Firebase account and project setup
- Android Studio or VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/SIH_Hackathon_Project.git
   cd SIH_Hackathon_Project
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Configure Firestore, Authentication, and Storage

4. **Run the application**
   ```bash
   flutter run
   ```

## 🏗️ Build and Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web
```

## 🎯 Target Audience

- **Students**: Pursuing technology and computer science education
- **Educators**: Teachers and trainers in technical fields
- **Professionals**: Working professionals seeking upskilling
- **Institutions**: Educational organizations looking for comprehensive platforms

## 🔮 Future Enhancements

- **AI-Powered Recommendations**: Personalized course suggestions
- **Live Streaming**: Large-scale virtual classrooms
- **Assessment System**: Quizzes and certification features
- **Mobile Offline Support**: Download courses for offline learning
- **Multi-language Support**: Localization for global reach
- **AR/VR Integration**: Immersive learning experiences

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

Developed for Smart India Hackathon by a dedicated team of developers passionate about revolutionizing education through technology.

## 📞 Support

For support and queries, please contact [your-email@example.com]

---

**CodeStore** - Empowering Education Through Technology 🚀
