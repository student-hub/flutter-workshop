# ACS UPB Mobile - Flutter workshop

This workshop is meant to help you get started with Flutter and contributing to the **ACS UPB Mobile** app. We will be using the app as reference throughout the workshop, so please make sure you follow the steps described [here](https://github.com/acs-upb-mobile/acs-upb-mobile/blob/master/README.md#building-from-source-with-android-studio) to build and run it.

## Getting started with Flutter

### What **is** Flutter?

First of all, let's talk a bit about Flutter. It is a cross-platform framework developed by Google, meaning it allows us to use the same codebase for an application that can run on multiple operating systems (iOS, Android, Fuchsia, MacOS etc.) and the web. Flutter uses **Dart** as its main programming language. The Dart syntax is clean and looks similar to Java, while sharing certain useful features with languages like JavaScript and C# (for example, the `async`/`await` combo, with `Future`s in Dart being similar to `Promise`s and `Task`s in JavaScript and C# respectively).

### Create a new Flutter application

Open Android Studio and create a new Flutter application. The sample app is very well explained through comments and it will help you understand the absolute basics of using Flutter. Analyze the folder structure and carefully read the following files:
- `lib/main.dart`, which is the application itself
- `pubspec.yaml`, which contains metadata necessary for building the application (similar to `build.gradle` in Android or `Info.plist` in iOS)
- `test/widget_test.dart`, a simple test for the sample application

Run the test to make sure it works by right-clicking `widget_test.dart` and selecting `Run`. Run the application and play around with the code in `main.dart`, while taking advantage of the Hot Reload feature, which allows you to load changes in the code quickly into an already running app, without you needing to restart/reinstall it. For example, change the text and colours, reposition the widgets, make the counter count backwards (make sure you fix the test accordingly for that last one) etc.

---
**Optimizing your workspace**

On the left-hand Project panel in Android Studio, make sure you have the *Project* view open in the drop-down (not *Android*).

You can make the emulator window display on top of the IDE by going to Extended controls (...) in the emulator and enabling 'Emulator always on top' in Settings. This is especially useful when playing around with the UI in Flutter, as you will see the application update every time you save, thanks to the Hot Reload feature.

<img src=screenshots/android_studio.png>

---
