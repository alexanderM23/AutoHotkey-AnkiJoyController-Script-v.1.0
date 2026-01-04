#NoEnv
#SingleInstance Force
; ================================================================================
; AutoHotkey AnkiJoyController Script v.1.0
; by Aleksandrs M. Orrin
; ================================================================================
;
; NAME: AutoHotkey AnkiJoyController
; VERSION: 1.0
; AUTHOR: Aleksandrs M. Orrin
;
; DESCRIPTION
; This script is the ultimate "Endgame" tool for learners and students. It acts as the
; final bridge between capturing information (via pop-up dictionary tools like the
; popular one starting with "L" and ending with "r") and mastering it in Anki.
;
; CORE FUNCTIONALITY
; 1. Controller Mapping: Transforms a standard Game Joystick into a review device,
;    allowing you to navigate Anki (Answer, Good, Scroll) from your couch.
; 2. Smart Audio (Auto-Aim): The script uses Computer Vision (ImageSearch) to visually
;    scan the screen for a specific "Play Audio" button and clicks it automatically.
;    * Note: This requires your cards to have audio fields generated via Anki
;      TTS (Text-to-Speech) plugins.
;
; PHILOSOPHY
; - The Unbroken Loop: Play/Read → Capture → Review with Controller.
;   It removes the "office work" feel from studying, keeping you in a relaxed state.
; - Universal Application: Suitable for language learners, medical students, or anyone
;   who wants to "speed-run" their flashcards without "desk fatigue."
; - Visual Intelligence: Instead of clicking blind coordinates, the script "sees"
;   your specific interface (using your custom 'play.png'), ensuring 100% accuracy
;   regardless of where the Anki window is positioned.
;
; ================================================================================
; CONTROLLER MAPPING (Based on Joystick #2):
; ================================================================================
;
; ACTION BUTTONS:
; Button A (2Joy1) → Space        (Show Answer / Good / Next)
; Button B (2Joy2) → Tab          (Navigation / Focus switch)
; Button X (2Joy3) → Smart Play   (Finds & Clicks "Play" button for Audio)
; Button Y (2Joy4) → Enter        (Confirm / Select)
;
; NAVIGATION:
; Button L1 (2Joy5) → Page Up     (Scroll Up / Previous)
; Button R1 (2Joy6) → Page Down   (Scroll Down / Next)
;
; ================================================================================
; TECHNICAL DETAILS:
; ================================================================================
; • Requires 'play.png' image file in the script directory for audio detection.
; • Auto-detects Anki window position and dimensions.
; • Fallback mode: Scans the entire screen if the specific window context is unclear.
; • Smart Search limits: Optimizes performance by searching relative to the last known position.
;
; ================================================================================
; SYSTEM REQUIREMENTS:
; ================================================================================
; -  Windows 7/8/10/11
; -  AutoHotkey v2.0+ (Legacy syntax preserved)
; -  Anki Desktop Application
; -  Connected Game Controller (detected as Joystick 2)
; -  'play.png' reference image
;
; ================================================================================
; VERSION & DATE:
; ================================================================================
; Version: 1.0
; Created: 2026-01-03
;
; ================================================================================
; SETTINGS
; ================================================================================

; #NoTrayIcon
#KeyHistory 0
SetBatchLines -1
ListLines, Off
SendMode Input ; Forces Send and SendRaw to use SendInput buffering for speed. Recommended for new scripts due to its superior speed and reliability.
; SetTitleMatchMode, 3 ; A window's title must exactly match WinTitle to be a match.
SetWorkingDir, %A_ScriptDir% ; Ensures a consistent starting directory.
; SplitPath, A_ScriptName, , , , MyScriptName ; store the script file name (without extension) in MyScriptName
; DetectHiddenWindows,On
; SetWinDelay, -1 ; Remove short delay done automatically after every windowing command except IfWinActive and IfWinExist
SetKeyDelay, -1, -1 ; Remove short delay done automatically after every keystroke sent by Send or ControlSend
SetMouseDelay,-1 ; Remove short delay done automatically after Click and MouseMove/Click/Drag
#MaxThreadsPerHotkey,1 ; no re-entrant hotkey handling
#Warn  ; Enable warnings to assist with detecting common errors.
Temp = 0
Temp2 = 0

; Djoystic button: A = 2Joy1
; Djoystic button: B = 2Joy2
; Djoystic button: X = 2Joy3
; Djoystic button: Y = 2Joy4
; Djoystic button: L1 = 2Joy5
; Djoystic button: R1 = 2Joy6
; Djoystic side (type): 2

; ================================================================================
; CODE BEGINS BELOW
; ================================================================================

; Global Variables
global LastFoundY := 0
global AnkiWindowX := 0
global AnkiWindowY := 0
global AnkiWindowW := 0
global AnkiWindowH := 0

; Function to retrieve Anki window coordinates
GetAnkiWindow() {
    global AnkiWindowX, AnkiWindowY, AnkiWindowW, AnkiWindowH

    ; Attempting various methods to detect the Anki window ID
    WinGet, AnkiID, ID, ahk_exe anki.exe
    if (!AnkiID) {
        WinGet, AnkiID, ID, ahk_class Qt5QWindowIcon
    }
    if (!AnkiID) {
        WinGet, AnkiID, ID, Anki
    }

    if (AnkiID) {
        WinGetPos, WinX, WinY, WinW, WinH, ahk_id %AnkiID%
        AnkiWindowX := WinX
        AnkiWindowY := WinY
        AnkiWindowW := WinW
        AnkiWindowH := WinH
        return true
    }
    return false
}

Loop {
    if GetKeyState("2Joy1", "P") {
        Send, {Space}
        Sleep, 50
        while GetKeyState("2Joy1", "P")
            Sleep, 10
    }

    if GetKeyState("2Joy2", "P") {
        Send, {Tab}
        Sleep, 50
        while GetKeyState("2Joy2", "P")
            Sleep, 10
    }

    if GetKeyState("2Joy3", "P") {
        ; Check if Anki window is currently open/detected
        if (!GetAnkiWindow()) {
            ; If Anki window is not found, scan the entire screen
            CoordMode, Mouse, Screen
            CoordMode, Pixel, Screen

            ; Quick search across the full screen
            Found := false

            ; Define search start area based on last known position
            if (LastFoundY = 0) {
                SearchStartY := 0
            } else {
                SearchStartY := LastFoundY + 10
            }

            ; Screen Search Execution
            ImageSearch, PosX, PosY, 0, %SearchStartY%, A_ScreenWidth, A_ScreenHeight, *40 play.png

            if (ErrorLevel = 0) {
                NewX := PosX + 12
                NewY := PosY + 12
                MouseMove, %NewX%, %NewY%, 0
                Sleep, 10
                MouseClick, Left
                Found := true
                LastFoundY := PosY
            }

            ; If not found, reset and search from the beginning
            if (!Found) {
                LastFoundY := 0
                ImageSearch, PosX, PosY, 0, 0, A_ScreenWidth, A_ScreenHeight, *40 play.png
                if (ErrorLevel = 0) {
                    NewX := PosX + 12
                    NewY := PosY + 12
                    MouseMove, %NewX%, %NewY%, 0
                    Sleep, 10
                    MouseClick, Left
                    LastFoundY := PosY
                } else {
                    ImageSearch, PosX, PosY, 0, 0, A_ScreenWidth, A_ScreenHeight, *60 play.png
                    if (ErrorLevel = 0) {
                        NewX := PosX + 12
                        NewY := PosY + 12
                        MouseMove, %NewX%, %NewY%, 0
                        Sleep, 10
                        MouseClick, Left
                        LastFoundY := PosY
                    }
                }
            }
        } else {
            ; If Anki window is found, restrict search to its coordinates
            CoordMode, Mouse, Screen
            CoordMode, Pixel, Screen

            ; Quick search within the Anki window
            Found := false

            ; Calculate search zones relative to the Anki window
            SearchLeftX := AnkiWindowX
            SearchRightX := AnkiWindowX + AnkiWindowW
            SearchTopY := AnkiWindowY + 100
            SearchBottomY := AnkiWindowY + AnkiWindowH - 50

            ; Define search start area based on last known position
            if (LastFoundY = 0) {
                SearchStartY := SearchTopY
            } else {
                SearchStartY := LastFoundY + 10
            }

            ; Search from current position downwards
            ImageSearch, PosX, PosY, %SearchLeftX%, %SearchStartY%, %SearchRightX%, %SearchBottomY%, *40 play.png

            if (ErrorLevel = 0) {
                NewX := PosX + 12
                NewY := PosY + 12
                MouseMove, %NewX%, %NewY%, 0
                Sleep, 10
                MouseClick, Left
                Found := true
                LastFoundY := PosY
            }

            ; If not found, reset and search from the beginning of the window zone
            if (!Found) {
                LastFoundY := 0
                ImageSearch, PosX, PosY, %SearchLeftX%, %SearchTopY%, %SearchRightX%, %SearchBottomY%, *40 play.png

                if (ErrorLevel = 0) {
                    NewX := PosX + 12
                    NewY := PosY + 12
                    MouseMove, %NewX%, %NewY%, 0
                    Sleep, 10
                    MouseClick, Left
                    LastFoundY := PosY
                } else {
                    ImageSearch, PosX, PosY, %SearchLeftX%, %SearchTopY%, %SearchRightX%, %SearchBottomY%, *60 play.png
                    if (ErrorLevel = 0) {
                        NewX := PosX + 12
                        NewY := PosY + 12
                        MouseMove, %NewX%, %NewY%, 0
                        Sleep, 10
                        MouseClick, Left
                        LastFoundY := PosY
                    }
                }
            }
        }

        while GetKeyState("2Joy3", "P")
            Sleep, 10
    }

    if GetKeyState("2Joy4", "P") {
        Send, {Enter}
        Sleep, 50
        while GetKeyState("2Joy5", "P")
            Sleep, 10
    }

    if GetKeyState("2Joy5", "P") {
        Send, {PgUp}
        Sleep, 50
        while GetKeyState("2Joy5", "P")
            Sleep, 10
    }

    if GetKeyState("2Joy6", "P") {
        Send, {PgDn}
        Sleep, 50
        while GetKeyState("2Joy6", "P")
            Sleep, 10
    }

    Sleep, 10
}

^!+#F10::ExitApp ; press CTRL + other buttons physicaly for Quick Exit, just for ensurance
ScrollLock::Suspend, Toggle ; press ScrollLock for Suspend Toggle
