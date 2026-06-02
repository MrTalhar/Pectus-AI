# Pectus AI — Excavatum Exercise & Recovery App

> **Your AI-powered chest recovery companion.** A smart Android application for Pectus Excavatum patients featuring guided exercises, AI chest analysis, progress tracking, and personalized recovery plans.

---

## About the App

**Pectus AI** is a specialized mobile fitness application designed for individuals living with **Pectus Excavatum** — a common chest wall deformity. The app provides a structured, science-backed exercise program that helps users improve chest expansion, posture, and overall respiratory function through daily guided workouts.

- **Who can use it:** Patients diagnosed with Pectus Excavatum (mild to moderate severity), physiotherapy students, and medical practitioners looking for a patient-facing tool.
- **Problem it solves:** There is a severe lack of dedicated mobile tools guiding Pectus Excavatum patients through safe, condition-specific exercises — this app fills that gap.
- **Key features:** AI-powered chest photo analysis, guided exercise sessions with timers, streak tracking, exercise library, dark/light theme, and an intelligent chat assistant powered by Ollama (local AI) or Groq (cloud AI).

---

## App Screenshots

| Splash Screen | Login Screen | Sign Up Screen |
|:---:|:---:|:---:|
| ![Splash](screenshots/Splash screen.png) | ![Login](screenshots/login_screen.png) | ![Sign Up](screenshots/signup_screen.png) |

| Dashboard | AI Chat Analysis |
|:---:|:---:|
| ![Dashboard](screenshots/dashboard.png) | ![AI Feature](screenshots/feature_screen.png) |

---

## Features

- 🔐 **User Authentication** — Secure login and sign-up with local session management
- 🏠 **Dashboard** — Personalized greeting, streak counter, session count, and daily workout suggestion
- 🤖 **AI Chest Analysis** — Upload a chest photo to get an instant severity analysis and a custom exercise plan (powered by Google Gemini / Groq / local Ollama)
- 💬 **AI Chat Assistant** — Conversational AI tuned specifically for Pectus Excavatum knowledge
- 🏋️ **Exercise Library** — Curated library of Pectus-specific exercises with descriptions, reps, and sets
- ▶️ **Session Mode** — Guided workout timer with exercise transitions and voice cues
- 📈 **Progress Tracking** — Visual charts tracking completed sessions and streak history
- 🌙 **Dark / Light Mode** — Fully theme-aware UI that adapts dynamically
- 🔔 **Smart Notifications** — Daily reminder notifications to keep users consistent
- 👤 **Profile Management** — Editable user profile with name, age, and condition details

---

## Technologies Used

| Category | Technology |
|---|---|
| Language | Dart |
| Framework | Flutter 3.x |
| UI | Material Design 3 + Custom Widgets |
| State Management | Provider |
| Local Storage | SharedPreferences |
| AI / Chat | Google Gemini API, Groq API (Llama 4), Local Ollama |
| Notifications | flutter_local_notifications |
| Image Handling | image_picker, path_provider |
| Permissions | permission_handler |
| Build System | Gradle (Kotlin DSL) |
| IDE | Android Studio / VS Code |

---

## APK Download

[⬇️ Download Pectus AI APK](apk/PectusAI.apk)

> **Note:** The APK is a release build targeting Android 5.0 (API 21) and above.

---

## How to Install the APK

1. Download the **PectusAI.apk** file from the `apk/` folder.
2. Transfer it to your Android device (via USB, Google Drive, or WhatsApp).
3. On your Android device, open **Settings → Security → Unknown Sources** and enable installation from unknown sources.
4. Open the downloaded APK file using your file manager.
5. Tap **Install** and wait for the installation to complete.
6. Open **Pectus AI** from your app drawer and start your recovery journey!

> ⚠️ Android 8.0+ users: Go to **Settings → Apps → Special App Access → Install Unknown Apps**, select your browser or file manager, and toggle on "Allow from this source."

---

## How to Run the Project (Developers)

```bash
# 1. Clone or download this repository
git clone https://github.com/YourUsername/pectus-ai.git
cd pectus_app

# 2. Install Flutter dependencies
flutter pub get

# 3. (Optional) Set up local AI with Ollama
#    Install Ollama from https://ollama.com
#    Run: ollama run llama3

# 4. Add your API keys in lib/services/ if using cloud AI
#    - Groq API Key
#    - Google Gemini API Key

# 5. Connect a device or start an emulator

# 6. Run the app
flutter run

# 7. To build a release APK
flutter build apk --release
```

> **Minimum Requirements:** Flutter SDK ≥ 3.0.0 · Dart SDK ≥ 3.0.0 · Android Studio Flamingo or newer · Android device / emulator running API 21+

---

## Demo Video

*Demo video coming soon.*

<!-- Uncomment and add your link when ready:
[▶️ Watch Demo Video](https://youtube.com/your-demo-link)
-->

---

## Privacy Policy

This app may collect the following data:
- **User-provided name** stored locally on device only (SharedPreferences)
- **Chest photos** uploaded for AI analysis — sent to the selected AI provider (Groq / Google Gemini) and not stored on any server by this app
- **No account system** — no email or password is transmitted to external servers

[📄 View Full Privacy Policy](docs/privacy_policy.pdf)

---

## Future Enhancements

- [ ] Firebase Authentication & Cloud Sync
- [ ] Admin / Doctor panel for monitoring patient progress
- [ ] Push notifications via Firebase Cloud Messaging
- [ ] Detailed PDF progress reports
- [ ] Wearable device integration (heart rate monitoring)
- [ ] Multi-language support (Urdu, Arabic)
- [ ] In-app exercise video tutorials
- [ ] Social sharing & community features

---

## Developed By

**Talha Riaz and Sana nisar (sanaconda)**
BS Computer Science — 3rd Year Project
Department of Computer Science

| Platform | Link |
|---|---|
|

---

## License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">
  <sub>Built with ❤️ and Flutter for Pectus Excavatum Warriors</sub>
</div>
