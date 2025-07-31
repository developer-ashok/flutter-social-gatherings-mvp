# 📸 Screenshot Guide

## How to Take Screenshots of Your Flutter App

### Method 1: Using Flutter DevTools
1. Run your app: `flutter run`
2. Open DevTools: `flutter pub global activate devtools`
3. In DevTools, go to "Performance" tab
4. Use the screenshot feature

### Method 2: Using Simulator/Emulator
1. **iOS Simulator**:
   - Run: `flutter run -d ios`
   - Press `Cmd + S` to take screenshot
   - Screenshots saved to Desktop

2. **Android Emulator**:
   - Run: `flutter run -d android`
   - Press `Ctrl + S` (Windows) or `Cmd + S` (Mac)
   - Screenshots saved to Desktop

### Method 3: Using Device
1. **Physical Device**:
   - Take screenshot using device buttons
   - Transfer to computer
   - Rename and move to `screenshots/` folder

## Recommended Screenshots

Take screenshots of these key screens:

1. **Login Screen** - Show the modern login interface
2. **Home Screen** - Display the relationship circle and quick actions
3. **Calendar Screen** - Show events and calendar view
4. **Polls Screen** - Display poll creation and voting
5. **News Screen** - Show announcements and news
6. **Profile Screen** - Display user profile

## Screenshot Tips

- **Use high resolution** - Take screenshots at full resolution
- **Good lighting** - Ensure the screen is well-lit
- **Clean state** - Make sure the app is in a clean, presentable state
- **Key features** - Focus on the main features of each screen
- **Consistent naming** - Use descriptive filenames

## File Naming Convention

Save screenshots with these names in the `screenshots/` folder:
- `login_screen.png`
- `home_screen.png`
- `calendar_screen.png`
- `polls_screen.png`
- `news_screen.png`
- `profile_screen.png`

## Updating README

After taking screenshots:
1. Move them to the `screenshots/` folder
2. The README.md file is already set up to display them
3. Commit and push your changes

Your screenshots will automatically appear in the README when you push to GitHub! 