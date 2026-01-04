# AutoHotkey AnkiJoyController Script v.1.0

![Image of Fox and game joyController, top](Images/headerimg.png)

## 🎮 **AnkiJoyController: The Ultimate Review Tool for Students & Gamers**
*Transform your Anki reviews into a relaxing gaming session.*

### **Introduction**
This project is an evolution of the learning methods discussed in various "Gaming Language Learning" guides found on the Steam Community. While those guides focus on capturing information, this tool focuses on **retention**.

Whether you are a language learner memorizing vocabulary from RPGs, or a medical student reviewing anatomy flashcards, the problem is the same: after a long day, sitting at a desk with a mouse and keyboard feels like work.

**This script changes the paradigm.** It allows you to lean back on your couch and control Anki entirely with a generic **Game Controller**. It bridges the gap between study and leisure, turning the "grind" of Spaced Repetition into a seamless extension of your relaxation time.

---

## 🔄 **The Workflow: From Discovery to Mastery**

To make this magic work, we follow a simple loop. Here is how you prepare your deck for the "Controller Experience":

### **Phase 1: Capture & Transfer**
You encounter a new word or concept in your source material (e.g., a dialogue-heavy video game or a digital textbook).
*   Use your preferred pop-up dictionary tool (like the popular one starting with **"L"** and ending with **"r"**) to capture the text.
*   Export these words into **Anki**.

### **Phase 2: The Audio Setup (Crucial Step)**
For the script to work fully, your cards need an audio element. You don't want to read; you want to *listen* and react, just like in a game.
1.  **Install a TTS Plugin:** Go to the Anki Add-ons page and download a **Text-to-Speech (TTS)** plugin (e.g., HyperTTS or AwesomeTTS).
2.  **Generate Audio:** Use the plugin to batch-generate audio files for your cards based on the text fields.
3.  **The Result:** Anki will automatically place a **"Play Audio" button** on your cards.
    *   *Note: This specific button is the target for our script's computer vision.*

### **Phase 3: Controller Review**
Launch this AutoHotkey script, pick up your gamepad, and start your review session without touching the keyboard.

---

## ⚙️ **Installation & Configuration**

### **1. The "Smart Audio" Visual Setup**
The script features an "Auto-Aim" function (**Button X**) that finds the Play button on your screen and clicks it. Since every Anki theme is different, you must "teach" the script what your button looks like.

**Follow these steps exactly:**
1.  Open Anki and find a card where the **Play Audio button** is visible.
2.  Take a screenshot of your screen (`PrintScreen`).
3.  Open an image editor (like MS Paint) and paste the screenshot.
4.  **Crop the image:** Cut out *only* the Play button.
    *   **Size Rule:** The final image must be strictly **26 x 26 pixels**.
    *   **Position:** Ensure the Play icon is centered in this square. 
    (Example of play button, size reference: ![play button size reference ](Images/playbuttonref.png) )
5.  **Save:** Save this file as `play.png` inside the folder where this script is located.

*(Reference: The script looks for this `play.png` on your screen to click it automatically.)*

### **2. Controller Mapping**
The script listens to **Joystick #2** by default. Ensure your controller is connected before launching the script. The layout is designed to be intuitive for any gamer.

| Button (Joy ID) | Action Description | Function |
| :--- | :--- | :--- |
| **Button A (Joy1)** | **Main Action** | `Space` (Show Answer / Good / Next) |
| **Button B (Joy2)** | **Navigation** | `Tab` (Switch focus between fields) |
| **Button X (Joy3)** | **Smart Audio** | **Auto-Detect & Click `play.png`** |
| **Button Y (Joy4)** | **Confirm** | `Enter` |
| **L1 (Joy5)** | **Scroll Up** | `Page Up` (Read long definitions) |
| **R1 (Joy6)** | **Scroll Down** | `Page Down` |

---

## 💡 **Why Use This?**

*   **For Polyglots:** You can "speed-run" your vocabulary reviews. The flow is instant: See word -> Press **X** to hear it -> Press **A** to flip -> Press **A** to grade.
*   **For Students:** Perfect for reviewing long sessions of history or law where reading on a screen causes eye strain. Sit back and listen.
*   **Ergonomics:** Prevents "Desk Fatigue". Changing your posture from "hunching over a keyboard" to "leaning back with a gamepad" significantly increases your study endurance.

## ⚠️ **Technical Notes**
*   **Theme Compatibility:** If you change your Anki theme (e.g., switch from Day to Night mode), the Play button usually changes color. You will need to repeat the **"Smart Audio" Visual Setup** (screenshot & crop) to create a matching `play.png`.
*   **Copyright:** No pre-made images are included to respect interface copyrights and ensure 100% compatibility with your specific screen resolution and theme.

---

*Script created by Aleksandrs M. Orrin.*
*Level up your knowledge without the grind.*
