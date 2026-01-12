![Image of Fox and game joyController, top](Images/headerimg.png)

# 🎮 AnkiJoyController: Couch-based Anki Review Setup

**Control Anki using a gamepad via AutoHotkey and pixel-based ImageSearch.**

![Platform](https://img.shields.io/badge/Platform-Windows-blue)
![Dependencies](https://img.shields.io/badge/Dependencies-AutoHotkey_v1.1+-green)

## The Hook

To be honest, I built this out of laziness. After staring at a monitor for 8 hours, the last thing I want to do is sit at a desk and click a mouse to grind through 200+ **Anki** cards.

I wanted to do my reviews lying on the couch, but standard keyboard shortcuts don't work for that. Instead of setting up complex remapping software, I wrote this `.ahk` script to handle the workflow.

The main feature is **"Smart Audio"**. The script uses `ImageSearch` to visually find the `Play` button on your screen and click it automatically, so you don't have to aim with a joystick. It's not perfect, but it works great for my daily workflow.

---

## Prerequisites

To get this running, you need a specific setup. The logic assumes you are **listening** to cards rather than just reading them.

1.  **Anki Add-ons:** Ensure you have a TTS plugin installed (e.g., `HyperTTS` or `AwesomeTTS`). Your cards must have a **visible Play button**.
2.  **Hardware:** Any gamepad that Windows recognizes (tested with an Xbox Controller).
3.  **Software:** `AutoHotkey` installed.

---

## Installation & Setup

The most "finicky" part of this script is the visual search. Since everyone uses different Anki themes (Dark mode, Light mode), you must "teach" the script what your button looks like.

### 1. Create the Reference Image (`play.png`)
The script scans your screen for a specific cluster of pixels.

1.  Open Anki to a card with audio.
2.  Take a screenshot.
3.  Open an image editor (MS Paint is fine) and crop **only** the Play button.
4.  **Important:** The image should be strictly **26x26 pixels** (or very close). The icon must be centered.
5.  Save the file as `play.png` in the same folder as the script.

*(Note: If you switch Anki themes later, you will need to redo this step as the pixel colors will change).*

### 2. Launch
Simply run the `.ahk` file. Make sure your gamepad is connected **before** starting the script (it listens to `Joy2` by default).

---

## Controls (Mapping)

The layout is designed for one-handed use, allowing for lazy scrolling.

| Gamepad Button | Keyboard Key | Action |
| :--- | :--- | :--- |
| **A (Joy1)** | `Space` | **Flip Card / Good / Next** (Primary Action) |
| **B (Joy2)** | `Tab` | Switch field focus |
| **X (Joy3)** | *Script Logic* | **Smart Audio:** Detects `play.png` & clicks it |
| **Y (Joy4)** | `Enter` | Confirm / Enter |
| **L1 (Joy5)** | `Page Up` | Scroll Up (for long definitions) |
| **R1 (Joy6)** | `Page Down` | Scroll Down |

> **Note:** If you are using a PlayStation controller or a generic clone, the button IDs might differ. Check them via Windows "Set up USB game controllers" if the mapping feels wrong.

---

## Notes & Limitations

*   **Ergonomics:** This actually saves my back. Shifting from "hunching over a keyboard" to "leaning back with a gamepad" extends my study endurance by about 1.5x.
*   **Copyright:** No `play.png` is included in the repo to respect theme interface copyrights. You must generate your own (see Installation).
*   **Source:** It's a simple script, ~100 lines of code. Feel free to fork it and tweak the sleep timers.

---

**Author:** Aleksandrs M. Orrin
*Built to make language learning slightly less painful.*
