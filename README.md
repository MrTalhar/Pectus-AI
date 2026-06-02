# Pectus AI — Excavatum Exercise & Recovery App

> **Your AI-powered chest recovery companion.** A smart Android application for Pectus Excavatum patients featuring guided exercises, AI chest analysis, progress tracking, and personalized recovery plans.

---

## About the App

**Pectus AI** is a specialized mobile fitness application designed for individuals living with **Pectus Excavatum** — a common chest wall deformity where the breastbone is sunken into the chest. The app provides a structured, science-backed exercise program that helps users improve chest expansion, posture, and overall respiratory function through daily guided workouts.

- **Who can use it:** Patients diagnosed with Pectus Excavatum (mild to moderate severity), physiotherapy students, and medical practitioners looking for a patient-facing tool.
- **Problem it solves:** There is a severe lack of dedicated mobile tools guiding Pectus Excavatum patients through safe, condition-specific exercises — this app fills that gap.
- **Key features:** AI-powered chest analysis chat, guided timed exercise sessions, exercise library with categories, progress & achievements tracking, profile management, and daily reminders.

---

## App Screenshots

| Splash Screen | Dashboard | Exercise Library |
|:---:|:---:|:---:|
| ![Splash Screen](screenshots/Splash%20screen.png) | ![Dashboard](screenshots/Main%20dashboard.png) | ![Exercise Library](screenshots/Exercise%20list.png) |

| Exercise Detail | Session Timer | AI Chest Analysis |
|:---:|:---:|:---:|
| ![Exercise Detail](screenshots/Exercise%20info.png) | ![Timer](screenshots/Timer.png) | ![AI Chat](screenshots/Ai.png) |

| Progress & Achievements | Profile & Settings |
|:---:|:---:|
| ![Streaks](screenshots/Streaks.png) | ![Settings](screenshots/Settings%20screen.png) |

---

## Features

- 🌬️ **Splash Screen** — Animated launch screen with motivational quote: *"Your chest doesn't define your strength. Every breath you take is proof of your resilience."*
- 🏠 **Dashboard** — Personalized greeting with user name, current streak counter, session count, AI Chest Analysis shortcut, and today's suggested workout card
- 🏋️ **Exercise Library** — Curated library of Pectus-specific exercises filterable by category: **All, Breathing, Posture, Strength** — includes Vacuum Breathing, Doorway Stretch, Dumbbell Pullover, Wall Angels, Cat-Cow Stretch, and more
- 📋 **Exercise Detail** — Step-by-step instructions with method and benefits for each exercise (e.g. Vacuum Breathing: 5-step guide with duration info)
- ⏱️ **Session Timer** — Guided workout timer with circular countdown display, pause/resume button, and skip exercise option
- 🤖 **AI Chest Analysis** — Conversational AI assistant powered by Groq that analyzes chest symmetry and depth from uploaded photos, providing feedback and exercise recommendations
- 📈 **Progress & Achievements** — Stats overview (Total Sessions, Current Streak) and achievement badges: First Step, Consistency, Dedication, Iron Will
- 👤 **Profile & Settings** — Editable user profile (Talha Riaz), difficulty preference selector (Easy / Medium / Hard), Reminders, Learn about Pectus Excavatum info section, Help & Support
- 🔔 **Daily Reminders** — Set daily exercise reminders from the profile settings
- 🌙 **Dark Theme** — Fully dark-themed premium UI with cyan/teal accent colors throughout

---

## Technologies Used

| Category | Technology |
|---|---|
| Language | Dart |
| Framework | Flutter 3.x |
| UI | Material Design 3 + Custom Widgets |
| State Management | Provider |
| Local Storage | SharedPreferences |
| AI / Chat | Groq API (Llama 4 Scout) |
| Notifications | flutter_local_notifications |
| Image Handling | image_picker, path_provider |
| Permissions | permission_handler |
| Build System | Gradle (Kotlin DSL) |
| IDE | Android Studio / VS Code |

---

## APK Download

[⬇️ Download PectusAI.apk](apk/PectusAI.apk)

> **Note:** Release build targeting Android 5.0 (API 21) and above. File size: ~51 MB.

---

## How to Install the APK

1. Download the **PectusAI.apk** file from the `apk/` folder above.
2. Transfer it to your Android device (via USB cable, Google Drive, or WhatsApp).
3. On your Android device, go to **Settings → Security → Unknown Sources** and enable it.
4. Open the downloaded APK file using your file manager.
5. Tap **Install** and wait for the installation to complete.
6. Open **Pectus AI** from your app drawer and start your recovery journey!

> ⚠️ Android 8.0+ users: Go to **Settings → Apps → Special App Access → Install Unknown Apps**, then allow your file manager or browser to install apps.

---

## How to Run the Project (Developers)

```bash
# 1. Clone this repository
git clone https://github.com/MrTalha/Pectus-AI.git
cd pectus_app

# 2. Install Flutter dependencies
flutter pub get

# 3. Add your Groq API key in lib/services/
#    Replace the placeholder with your key from https://console.groq.com

# 4. Connect a physical device or start an Android emulator

# 5. Run the app
flutter run

# 6. To build a release APK
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

> **Requirements:** Flutter SDK ≥ 3.0.0 · Dart SDK ≥ 3.0.0 · Android Studio Flamingo or newer · Android device / emulator API 21+

---

## Demo Video

*Demo video coming soon.*

---

## Privacy Policy

This app may collect the following data:
- **User name** — stored locally on device only (SharedPreferences), never sent to any server
- **Chest photos** — sent to Groq API only when you initiate AI analysis; not stored by this app
- **Session & progress data** — stored locally on device only

[📄 View Full Privacy Policy](docs/privacy_policy.pdf)

---

## Future Enhancements

- [ ] Firebase Authentication & Cloud Sync
- [ ] Admin / Doctor panel for monitoring patient progress
- [ ] Push notifications via Firebase Cloud Messaging
- [ ] Detailed PDF progress reports
- [ ] Light mode support
- [ ] Multi-language support (Urdu, Arabic)
- [ ] In-app exercise video tutorials
- [ ] Wearable device integration (heart rate monitoring)

---

## Developed By

**Talha Riaz and Sana Nisar**
BS Computer Science — 3rd Year Project
Department of Computer Science

| Platform | Link |
|---|---|
| GitHub | [github.com/MrTalha](https://github.com/MrTalha) |

---

## License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">
  <sub>Built with ❤️ and Flutter for Pectus Excavatum Warriors</sub>
</div>
